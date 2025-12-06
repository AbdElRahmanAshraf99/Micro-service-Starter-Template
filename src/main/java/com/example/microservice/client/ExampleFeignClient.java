package com.example.microservice.client;

import com.example.microservice.config.FeignConfig;
import com.example.microservice.dto.ExampleResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * Example Feign Client for external service communication.
 * Replace the name and url with your actual service details.
 */
@FeignClient(
        name = "example-service",
        url = "${feign.client.config.example-service.url:http://localhost:8081}",
        configuration = FeignConfig.class,
        fallback = ExampleFeignClientFallback.class
)
public interface ExampleFeignClient {

    @GetMapping("/api/examples")
    List<ExampleResponse> getAllExamples();

    @GetMapping("/api/examples/{id}")
    ExampleResponse getExampleById(@PathVariable("id") Long id);

    @GetMapping("/api/examples/search")
    List<ExampleResponse> searchExamples(@RequestParam("query") String query);
}
