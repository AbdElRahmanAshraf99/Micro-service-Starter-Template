package com.example.microservice.client;

import com.example.microservice.dto.ExampleResponse;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.List;

/**
 * Fallback implementation for ExampleFeignClient.
 * Returns default values when the external service is unavailable.
 */
@Component
public class ExampleFeignClientFallback implements ExampleFeignClient {

    @Override
    public List<ExampleResponse> getAllExamples() {
        return Collections.emptyList();
    }

    @Override
    public ExampleResponse getExampleById(Long id) {
        return null;
    }

    @Override
    public List<ExampleResponse> searchExamples(String query) {
        return Collections.emptyList();
    }
}
