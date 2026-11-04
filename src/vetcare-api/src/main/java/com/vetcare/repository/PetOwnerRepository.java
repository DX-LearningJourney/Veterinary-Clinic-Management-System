package com.vetcare.repository;

import com.vetcare.model.PetOwner;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PetOwnerRepository extends JpaRepository<PetOwner, Long> {

    Optional<PetOwner> findByUserId(Long userId);

    List<PetOwner> findByFullNameContainingIgnoreCase(String name);
}
