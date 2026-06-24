package com.kmbeast.utils;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.UUID;

/**
 * jwt token 工具类
 */
@Component
public class JwtUtil {

    @Value("${jwt.private-key:d8c986df-8512-42b5-906f-eeea9b3acf86}")
    private String privateKey;

    private final Integer time = 1000 * 60 * 60 * 24 * 7;

    private SecretKey getSigningKey() {
        return new SecretKeySpec(
                privateKey.getBytes(StandardCharsets.UTF_8),
                "HmacSHA256"
        );
    }

    public String toToken(Integer id, Integer role) {
        return Jwts.builder()
                .header().add("typ", "JWT").add("alg", "HS256").and()
                .claim("id", id)
                .claim("role", role)
                .subject("用户认证")
                .expiration(new Date(System.currentTimeMillis() + time))
                .id(UUID.randomUUID().toString())
                .signWith(getSigningKey())
                .compact();
    }

    public Claims fromToken(String token) {
        try {
            Jws<Claims> claimsJws = Jwts.parser()
                    .verifyWith(getSigningKey())
                    .build()
                    .parseSignedClaims(token);
            return claimsJws.getPayload();
        } catch (Exception e) {
            return null;
        }
    }
}
