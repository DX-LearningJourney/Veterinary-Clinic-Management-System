package com.vetcare.service;

import com.vetcare.model.Pet;
import com.vetcare.model.Vaccination;
import com.vetcare.model.Vaccine;
import com.vetcare.model.Veterinarian;
import com.vetcare.repository.PetRepository;
import com.vetcare.repository.VaccinationRepository;
import com.vetcare.repository.VaccineRepository;
import com.vetcare.repository.VeterinarianRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;

@Service
public class VaccinationService {

    private final VaccinationRepository vaccinationRepository;
    private final VaccineRepository vaccineRepository;
    private final PetRepository petRepository;
    private final VeterinarianRepository veterinarianRepository;

    public VaccinationService(VaccinationRepository vaccinationRepository,
                              VaccineRepository vaccineRepository,
                              PetRepository petRepository,
                              VeterinarianRepository veterinarianRepository) {
        this.vaccinationRepository = vaccinationRepository;
        this.vaccineRepository = vaccineRepository;
        this.petRepository = petRepository;
        this.veterinarianRepository = veterinarianRepository;
    }

    @Transactional(readOnly = true)
    public List<Vaccination> findAll() {
        return vaccinationRepository.findAll();
    }

    @Transactional(readOnly = true)
    public List<Vaccine> findAllVaccines() {
        return vaccineRepository.findAll();
    }

    @Transactional
    public Vaccination recordVaccination(Long petId, Long vaccineId, Long vetId, String batchNumber, LocalDate adminDate, String notes) {
        Pet pet = petRepository.findById(petId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid pet ID: " + petId));
        Vaccine vaccine = vaccineRepository.findById(vaccineId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid vaccine ID: " + vaccineId));
        Veterinarian vet = veterinarianRepository.findById(vetId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid vet ID: " + vetId));

        LocalDate date = adminDate != null ? adminDate : LocalDate.now();
        LocalDate nextDueDate = (vaccine.getIntervalDays() != null)
                ? date.plusDays(vaccine.getIntervalDays()) : date.plusYears(1);

        Vaccination vaccination = new Vaccination();
        vaccination.setPet(pet);
        vaccination.setVaccine(vaccine);
        vaccination.setVeterinarian(vet);
        vaccination.setAdministeredDate(date);
        vaccination.setNextDueDate(nextDueDate);
        vaccination.setBatchNumber(batchNumber != null ? batchNumber : "BATCH-" + System.currentTimeMillis() % 10000);
        vaccination.setNotes(notes);
        vaccination.setReminderSent(false);

        return vaccinationRepository.save(vaccination);
    }
}
