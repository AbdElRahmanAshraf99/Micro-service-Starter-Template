# Microservice Starter Template

A production-ready Spring Boot microservice template with pre-configured dependencies for building scalable, observable, and maintainable microservices.

## Project Overview

This template provides a solid foundation for developing microservices with Java 8 and Spring Boot 2.7.18. It includes essential integrations for configuration management, distributed tracing, API documentation, inter-service communication, and database connectivity.

## Tech Stack

| Component | Version |
|-----------|---------|
| Java | 1.8 |
| Spring Boot | 2.7.18 |
| Spring Cloud | 2021.0.9 |
| SpringFox (Swagger) | 3.0.0 |
| Lombok | 1.18.38 |

---

## Dependencies & Their Usage

### 1. Spring Boot Starter Web
```xml
<artifactId>spring-boot-starter-web</artifactId>
```
**Purpose:** Core dependency for building RESTful web applications.

**Features:**
- Embedded Tomcat server
- Spring MVC for REST controllers
- JSON serialization/deserialization with Jackson
- Exception handling

**Usage in Project:** Enables creating REST endpoints like `/health`, `/api/datetime`.

---

### 2. Spring Boot Starter Data JPA
```xml
<artifactId>spring-boot-starter-data-jpa</artifactId>
```
**Purpose:** Simplifies database operations using Java Persistence API.

**Features:**
- Hibernate ORM integration
- Repository pattern with `JpaRepository`
- Automatic CRUD operations
- Query derivation from method names

**Usage in Project:** `SampleRepository` extends `JpaRepository` for database operations. Entity classes use `@Entity` annotation.

---

### 3. Spring Boot Starter Actuator
```xml
<artifactId>spring-boot-starter-actuator</artifactId>
```
**Purpose:** Production-ready features for monitoring and managing the application.

**Endpoints:**
| Endpoint | Description |
|----------|-------------|
| `/actuator/health` | Application health status |
| `/actuator/info` | Application information |
| `/actuator/metrics` | Application metrics (memory, CPU, etc.) |
| `/actuator/prometheus` | Metrics in Prometheus format |

**Configuration:**
```yaml
management:
  endpoints:
    web:
      exposure:
        include: health,info,metrics,prometheus
  endpoint:
    health:
      show-details: always
```

**Usage:** Access `http://localhost:8080/Microservice/actuator/health` to check service health.

---

### 4. Spring Boot Starter Validation
```xml
<artifactId>spring-boot-starter-validation</artifactId>
```
**Purpose:** Bean validation using Hibernate Validator.

**Features:**
- Annotations like `@NotNull`, `@Size`, `@Email`, `@Pattern`
- Automatic validation in controllers with `@Valid`
- Custom validation messages

**Usage Example:**
```java
public class UserDTO {
    @NotNull
    @Size(min = 2, max = 50)
    private String name;

    @Email
    private String email;
}
```

---

### 5. Spring Cloud Config Client
```xml
<artifactId>spring-cloud-starter-config</artifactId>
<artifactId>spring-cloud-starter-bootstrap</artifactId>
```
**Purpose:** Externalized configuration management via a central Config Server.

**Features:**
- Centralized configuration for all microservices
- Environment-specific configurations (dev, staging, prod)
- Dynamic configuration refresh
- Encrypted sensitive properties

**Configuration (bootstrap.yml):**
```yaml
spring:
  cloud:
    config:
      uri: http://localhost:8888
      fail-fast: true
      retry:
        max-attempts: 10000
```

**How it Works:**
1. On startup, the service connects to Config Server
2. Fetches configuration based on `spring.application.name`
3. Merges remote config with local properties

---

### 6. Spring Cloud OpenFeign
```xml
<artifactId>spring-cloud-starter-openfeign</artifactId>
```
**Purpose:** Declarative REST client for inter-service communication.

**Features:**
- Interface-based HTTP client
- Automatic load balancing (with Ribbon/LoadBalancer)
- Built-in error handling and fallbacks
- Request/response logging

**Usage in Project:**
```java
@FeignClient(name = "example-service", url = "http://localhost:8081")
public interface ExampleFeignClient {

    @GetMapping("/api/examples/{id}")
    ExampleResponse getExampleById(@PathVariable("id") Long id);
}
```

**Configuration:**
```yaml
feign:
  client:
    config:
      default:
        connectTimeout: 5000
        readTimeout: 5000
        loggerLevel: FULL
```

---

### 7. Spring Cloud Sleuth & Zipkin
```xml
<artifactId>spring-cloud-starter-sleuth</artifactId>
<artifactId>spring-cloud-sleuth-zipkin</artifactId>
```
**Purpose:** Distributed tracing for tracking requests across microservices.

**Features:**
- Automatic trace ID and span ID generation
- Propagation of trace context across services
- Integration with logging (trace IDs in logs)
- Visualization in Zipkin UI

**Key Concepts:**
| Term | Description |
|------|-------------|
| Trace ID | Unique identifier for entire request flow |
| Span ID | Unique identifier for a single operation |
| Parent Span | The calling span |

**Configuration:**
```yaml
spring:
  sleuth:
    sampler:
      probability: 1.0  # 100% of requests traced
  zipkin:
    base-url: http://localhost:9411
    enabled: true
```

**Log Output Example:**
```
2024-01-15 10:30:45 [http-nio-8080-exec-1] [abc123,def456] INFO  Controller - Request received
```

**Zipkin UI:** Access `http://localhost:9411` to visualize traces.

---

### 8. SpringFox Swagger (OpenAPI 3)
```xml
<artifactId>springfox-boot-starter</artifactId>
```
**Purpose:** Auto-generates interactive API documentation.

**Features:**
- Swagger UI for testing endpoints
- OpenAPI 3.0 specification
- Automatic schema generation from DTOs
- Customizable documentation

**Access URLs:**
| URL | Description |
|-----|-------------|
| `/swagger-ui/` | Interactive Swagger UI |
| `/v3/api-docs` | OpenAPI JSON specification |

**Usage in Controllers:**
```java
@RestController
@Tag(name = "Health", description = "Health check endpoints")
public class HealthController {

    @Operation(summary = "Health check")
    @ApiResponses({
        @ApiResponse(responseCode = "200", description = "Service is healthy")
    })
    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> healthCheck() { ... }
}
```

---

### 9. Lombok
```xml
<artifactId>lombok</artifactId>
```
**Purpose:** Reduces boilerplate code through annotations.

**Common Annotations:**
| Annotation | Description |
|------------|-------------|
| `@Data` | Generates getters, setters, toString, equals, hashCode |
| `@Builder` | Implements builder pattern |
| `@NoArgsConstructor` | Generates no-args constructor |
| `@AllArgsConstructor` | Generates all-args constructor |
| `@Slf4j` | Creates a logger field |

**Usage in Project:**
```java
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ExampleResponse {
    private Long id;
    private String name;
}
```

---

### 10. Database Drivers

#### H2 (In-Memory Database)
```xml
<artifactId>h2</artifactId>
```
**Purpose:** Lightweight in-memory database for development/testing.

**Access Console:** `http://localhost:8080/Microservice/h2-console`

#### MySQL Connector
```xml
<artifactId>mysql-connector-j</artifactId>
```
**Purpose:** Production database connectivity for MySQL.

#### PostgreSQL Driver
```xml
<artifactId>postgresql</artifactId>
```
**Purpose:** Production database connectivity for PostgreSQL.

---

## Project Structure

```
src/main/
├── java/com/example/microservice/
│   ├── MicroserviceStarterApplication.java    # Main application
│   ├── config/
│   │   ├── SwaggerConfig.java                 # Swagger configuration
│   │   └── FeignConfig.java                   # Feign client configuration
│   ├── controller/
│   │   ├── HealthController.java              # Health endpoints
│   │   └── DateTimeController.java            # DateTime test endpoint
│   ├── client/
│   │   ├── ExampleFeignClient.java            # Feign client interface
│   │   └── ExampleFeignClientFallback.java    # Fallback implementation
│   ├── model/
│   │   └── SampleEntity.java                  # JPA entity
│   ├── repository/
│   │   └── SampleRepository.java              # JPA repository
│   └── dto/
│       └── ExampleResponse.java               # Data transfer object
└── resources/
    ├── application.yml                        # Base configuration
    ├── application-dev.yml                    # Development profile
    ├── application-mysql.yml                  # MySQL profile
    ├── application-postgres.yml               # PostgreSQL profile
    ├── application-prod.yml                   # Production profile
    ├── bootstrap.yml                          # Config server (base)
    ├── bootstrap-dev.yml                      # Config server (dev)
    ├── bootstrap-staging.yml                  # Config server (staging)
    └── bootstrap-prod.yml                     # Config server (prod)
```

---

## Quick Start

### Build
```bash
mvn clean package -DskipTests
```

### Run
```bash
# Default profile
java -jar target/microservice-starter-1.0.0-SNAPSHOT.jar

# With specific profile
java -jar target/microservice-starter-1.0.0-SNAPSHOT.jar --spring.profiles.active=dev

# Multiple profiles
java -jar target/microservice-starter-1.0.0-SNAPSHOT.jar --spring.profiles.active=prod,mysql
```

### Docker
```bash
# Build image
docker-build.bat

# Run container
docker-run.bat
```

---

## Available Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/Microservice/health` | GET | Health check |
| `/Microservice/datetime` | GET | Current date/time |
| `/Microservice/actuator/health` | GET | Actuator health |
| `/Microservice/actuator/info` | GET | Application info |
| `/Microservice/swagger-ui/` | GET | Swagger UI |
| `/Microservice/h2-console` | GET | H2 Database Console |

---

## Configuration Profiles

| Profile | Description | Database |
|---------|-------------|----------|
| `default` | Base configuration | H2 (in-memory) |
| `dev` | Development settings | H2 (in-memory) |
| `mysql` | MySQL database | MySQL |
| `postgres` | PostgreSQL database | PostgreSQL |
| `prod` | Production settings | Configured via env |

---

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `SERVER_PORT` | Server port | 8080 |
| `DB_URL` | Database URL | H2 in-memory |
| `DB_USERNAME` | Database username | sa |
| `DB_PASSWORD` | Database password | 12345678 |
| `ZIPKIN_BASE_URL` | Zipkin server URL | http://localhost:9411 |
| `CONFIG_SERVER_USERNAME` | Config server username | config |
| `CONFIG_SERVER_PASSWORD` | Config server password | config |
