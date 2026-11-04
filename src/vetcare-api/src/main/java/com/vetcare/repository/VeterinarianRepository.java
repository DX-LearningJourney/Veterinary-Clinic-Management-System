package com.vetcare.repository;

import com.vetcare.model.Veterinarian;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VeterinarianRepository extends JpaRepository<Veterinarian, Long> {

    Optional<Veterinarian> findByUserId(Long userId);

    List<Veterinarian> findByIsAvailableTrue();

    Optional<Veterinarian> findByLicenseNumber(String licenseNumber);
}
