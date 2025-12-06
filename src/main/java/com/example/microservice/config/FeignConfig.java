package com.example.microservice.config;

import feign.Logger;
import feign.Request;
import feign.Retryer;
import feign.codec.ErrorDecoder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

@Configuration
public class FeignConfig {

    @Bean
    public Logger.Level feignLoggerLevel() {
        return Logger.Level.FULL;
    }

    @Bean
    public Request.Options requestOptions() {
        return new Request.Options(
                5000, TimeUnit.MILLISECONDS,  // connectTimeout
                10000, TimeUnit.MILLISECONDS, // readTimeout
                true                           // followRedirects
        );
    }

    @Bean
    public Retryer retryer() {
        return new Retryer.Default(
                100,   // initial interval
                1000,  // max interval
                3      // max attempts
        );
    }

    @Bean
    public ErrorDecoder errorDecoder() {
        return new FeignErrorDecoder();
    }

    public static class FeignErrorDecoder implements ErrorDecoder {
        private final ErrorDecoder defaultDecoder = new Default();

        @Override
        public Exception decode(String methodKey, feign.Response response) {
            if (response.status() >= 400 && response.status() <= 499) {
                return new FeignClientException(
                        response.status(),
                        String.format("Client error: %s calling %s", response.status(), methodKey)
                );
            }
            if (response.status() >= 500 && response.status() <= 599) {
                return new FeignServerException(
                        response.status(),
                        String.format("Server error: %s calling %s", response.status(), methodKey)
                );
            }
            return defaultDecoder.decode(methodKey, response);
        }
    }

    public static class FeignClientException extends RuntimeException {
        private final int status;

        public FeignClientException(int status, String message) {
            super(message);
            this.status = status;
        }

        public int getStatus() {
            return status;
        }
    }

    public static class FeignServerException extends RuntimeException {
        private final int status;

        public FeignServerException(int status, String message) {
            super(message);
            this.status = status;
        }

        public int getStatus() {
            return status;
        }
    }
}
