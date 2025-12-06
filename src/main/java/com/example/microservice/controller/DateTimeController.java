package com.example.microservice.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/datetime")
@Tag(name = "DateTime", description = "Date and time test endpoints")
public class DateTimeController {

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    @GetMapping
    @Operation(summary = "Get current date time", description = "Returns the current server date and time")
    @ApiResponses({
            @ApiResponse(responseCode = "200", description = "Successfully retrieved current date time")
    })
    public ResponseEntity<Map<String, Object>> getCurrentDateTime() {
        LocalDateTime now = LocalDateTime.now();
        ZoneId zoneId = ZoneId.systemDefault();

        Map<String, Object> response = new HashMap<>();
        response.put("datetime", now.format(FORMATTER));
        response.put("date", now.toLocalDate().toString());
        response.put("time", now.toLocalTime().toString());
        response.put("timezone", zoneId.getId());
        response.put("timestamp", System.currentTimeMillis());

        return ResponseEntity.ok(response);
    }
}
