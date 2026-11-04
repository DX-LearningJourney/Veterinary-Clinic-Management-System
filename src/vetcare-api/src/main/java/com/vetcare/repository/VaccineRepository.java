package com.vetcare.repository;

import com.vetcare.model.Vaccine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VaccineRepository extends JpaRepository<Vaccine, Long> {

    Optional<Vaccine> findByName(String name);

    List<Vaccine> findByTargetSpeciesIgnoreCase(String species);
}
