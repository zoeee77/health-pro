package com.kmbeast.utils;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

/**
 * 数据加密工具类
 * 提供两种加密方式：
 * 1. 数值型混淆：用于Double类型字段（如健康记录值），保持数值类型不变
 * 2. AES文本加密：用于String类型字段的加密存储
 */
@Component
@Slf4j
public class AESUtil {

    @Value("${aes.secret-key:SelfHealth2024SecureKey!}")
    private String secretKey;

    // ==================== 数值型混淆（用于Double字段） ====================

    /**
     * 对数值进行混淆加密
     * 使用基于密钥的线性变换 + 偏移，结果仍为Double，可直接存入double类型数据库列
     *
     * @param value 原始数值
     * @return 混淆后的数值
     */
    public double encryptValue(Double value) {
        if (value == null) {
            return 0;
        }
        long keyLong = deriveNumericKey();
        double encrypted = (value + (keyLong % 10000)) * ((keyLong >> 8) % 1000 + 1);
        return Math.round(encrypted * 1000000.0) / 1000000.0;
    }

    /**
     * 对混淆后的数值进行解密还原
     * 解密失败时返回原值，避免影响业务流程
     *
     * @param encryptedValue 混淆后的数值
     * @return 原始数值，解密失败时返回原值
     */
    public double decryptValue(double encryptedValue) {
        try {
            long keyLong = deriveNumericKey();
            double divisor = (keyLong >> 8) % 1000 + 1;
            double offset = keyLong % 10000;
            double decrypted = (encryptedValue / divisor) - offset;
            return Math.round(decrypted * 1000000.0) / 1000000.0;
        } catch (Exception e) {
            log.warn("数值解密失败，返回原值: {}", e.getMessage());
            return encryptedValue;
        }
    }

    /**
     * 从字符串密钥派生一个长整型数值密钥
     *
     * @return 数值密钥
     */
    private long deriveNumericKey() {
        long hash = 0;
        byte[] bytes = secretKey.getBytes(java.nio.charset.StandardCharsets.UTF_8);
        for (int i = 0; i < bytes.length; i++) {
            hash = hash * 31 + (bytes[i] & 0xFF);
        }
        if (hash == 0) {
            hash = 20240601L; // 兜底默认值
        }
        return Math.abs(hash);
    }

    // ==================== AES文本加密（用于String字段） ====================

    /**
     * 加密明文
     *
     * @param plainText 明文
     * @return Base64编码的密文
     */
    public String encrypt(String plainText) {
        if (plainText == null || plainText.isEmpty()) {
            return plainText;
        }
        try {
            javax.crypto.Cipher cipher = javax.crypto.Cipher.getInstance("AES/CBC/PKCS5Padding");
            byte[] keyBytes = padKey(secretKey.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            javax.crypto.spec.SecretKeySpec keySpec = new javax.crypto.spec.SecretKeySpec(keyBytes, "AES");
            javax.crypto.spec.IvParameterSpec ivSpec = new javax.crypto.spec.IvParameterSpec(keyBytes, 0, 16);
            cipher.init(javax.crypto.Cipher.ENCRYPT_MODE, keySpec, ivSpec);
            byte[] encrypted = cipher.doFinal(plainText.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            return java.util.Base64.getEncoder().encodeToString(encrypted);
        } catch (Exception e) {
            log.error("AES加密失败: {}", e.getMessage(), e);
            throw new RuntimeException("数据加密失败", e);
        }
    }

    /**
     * 解密密文
     *
     * @param encryptedText Base64编码的密文
     * @return 明文
     */
    public String decrypt(String encryptedText) {
        if (encryptedText == null || encryptedText.isEmpty()) {
            return encryptedText;
        }
        try {
            javax.crypto.Cipher cipher = javax.crypto.Cipher.getInstance("AES/CBC/PKCS5Padding");
            byte[] keyBytes = padKey(secretKey.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            javax.crypto.spec.SecretKeySpec keySpec = new javax.crypto.spec.SecretKeySpec(keyBytes, "AES");
            javax.crypto.spec.IvParameterSpec ivSpec = new javax.crypto.spec.IvParameterSpec(keyBytes, 0, 16);
            cipher.init(javax.crypto.Cipher.DECRYPT_MODE, keySpec, ivSpec);
            byte[] encrypted = java.util.Base64.getDecoder().decode(encryptedText);
            byte[] decrypted = cipher.doFinal(encrypted);
            return new String(decrypted, java.nio.charset.StandardCharsets.UTF_8);
        } catch (Exception e) {
            log.error("AES解密失败: {}", e.getMessage(), e);
            throw new RuntimeException("数据解密失败", e);
        }
    }

    /**
     * 将密钥填充或截断为指定长度
     */
    private byte[] padKey(byte[] key) {
        byte[] result = new byte[16];
        if (key.length >= 16) {
            System.arraycopy(key, 0, result, 0, 16);
        } else {
            System.arraycopy(key, 0, result, 0, key.length);
        }
        return result;
    }

    /**
     * 判断字符串是否为已加密格式（Base64特征检测）
     */
    public boolean isEncrypted(String text) {
        if (text == null || text.isEmpty()) {
            return false;
        }
        return text.length() > 20 && !text.matches("^-?\\d+(\\.\\d+)?$");
    }
}
