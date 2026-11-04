package com.vetcare.repository;

import com.vetcare.model.Service;
import com.vetcare.model.enums.ServiceCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ServiceRepository extends JpaRepository<Service, Long> {

    List<Service> findByIsActiveTrue();

    List<Service> findByCategory(ServiceCategory category);

    List<Service> findByNameContainingIgnoreCase(String name);
}
