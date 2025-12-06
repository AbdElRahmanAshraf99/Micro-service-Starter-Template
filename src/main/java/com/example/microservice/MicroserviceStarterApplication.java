package com.example.microservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
public class MicroserviceStarterApplication {

    public static void main(String[] args) {
        SpringApplication.run(MicroserviceStarterApplication.class, args);
    }
}
