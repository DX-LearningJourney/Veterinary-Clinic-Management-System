package com.vetcare.service;

import com.vetcare.model.Pet;
import com.vetcare.model.PetOwner;
import com.vetcare.repository.PetOwnerRepository;
import com.vetcare.repository.PetRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class PetService {

    private final PetRepository petRepository;
    private final PetOwnerRepository petOwnerRepository;

    public PetService(PetRepository petRepository, PetOwnerRepository petOwnerRepository) {
        this.petRepository = petRepository;
        this.petOwnerRepository = petOwnerRepository;
    }

    @Transactional(readOnly = true)
    public List<Pet> findAll() {
        return petRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Optional<Pet> findById(Long id) {
        return petRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public List<Pet> findByOwnerId(Long ownerId) {
        return petRepository.findByOwnerId(ownerId);
    }

    @Transactional
    public Pet save(Pet pet, Long ownerId) {
        if (ownerId != null) {
            PetOwner owner = petOwnerRepository.findById(ownerId)
                    .orElseThrow(() -> new IllegalArgumentException("Invalid owner ID: " + ownerId));
            pet.setOwner(owner);
        }
        return petRepository.save(pet);
    }

    @Transactional
    public void deleteById(Long id) {
        petRepository.deleteById(id);
    }

    @Transactional(readOnly = true)
    public List<PetOwner> findAllOwners() {
        return petOwnerRepository.findAll();
    }
}
