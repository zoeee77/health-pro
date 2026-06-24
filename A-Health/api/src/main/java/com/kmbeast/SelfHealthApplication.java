package com.kmbeast;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@MapperScan("com.kmbeast.mapper")
@SpringBootApplication
@EnableScheduling
public class SelfHealthApplication {
    public static void main(String[] args) {
        SpringApplication.run(SelfHealthApplication.class, args);
    }
}
