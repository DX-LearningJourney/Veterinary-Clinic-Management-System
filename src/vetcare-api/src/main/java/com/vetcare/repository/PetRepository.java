package com.vetcare.repository;

import com.vetcare.model.Pet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PetRepository extends JpaRepository<Pet, Long> {

    List<Pet> findByOwnerId(Long ownerId);

    List<Pet> findByNameContainingIgnoreCase(String name);

    Optional<Pet> findByMicrochipId(String microchipId);

    List<Pet> findBySpeciesIgnoreCase(String species);
}
