package com.example.microservice.repository;

import com.example.microservice.model.SampleEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SampleRepository extends JpaRepository<SampleEntity, Long> {

    List<SampleEntity> findByNameContainingIgnoreCase(String name);
}
