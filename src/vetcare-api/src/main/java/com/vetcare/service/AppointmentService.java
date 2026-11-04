package com.vetcare.service;

import com.vetcare.model.Appointment;
import com.vetcare.model.Pet;
import com.vetcare.model.PetOwner;
import com.vetcare.model.Veterinarian;
import com.vetcare.model.enums.AppointmentStatus;
import com.vetcare.repository.AppointmentRepository;
import com.vetcare.repository.PetRepository;
import com.vetcare.repository.VeterinarianRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;
    private final PetRepository petRepository;
    private final VeterinarianRepository veterinarianRepository;

    @Transactional(readOnly = true)
    public List<Appointment> findAll() {
        return appointmentRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Optional<Appointment> findById(Long id) {
        return appointmentRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public List<Appointment> findTodayAppointments() {
        LocalDateTime startOfDay = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0);
        LocalDateTime endOfDay = LocalDateTime.now().withHour(23).withMinute(59).withSecond(59);
        return appointmentRepository.findByScheduledAtBetween(startOfDay, endOfDay);
    }

    @Transactional
    public Appointment bookAppointment(Long petId, Long vetId, LocalDateTime scheduledAt, String reason) {
        Pet pet = petRepository.findById(petId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid pet ID: " + petId));
        Veterinarian vet = veterinarianRepository.findById(vetId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid vet ID: " + vetId));

        Appointment appointment = Appointment.builder()
                .pet(pet)
                .veterinarian(vet)
                .petOwner(pet.getOwner())
                .scheduledAt(scheduledAt)
                .status(AppointmentStatus.PENDING)
                .reasonForVisit(reason)
                .build();

        return appointmentRepository.save(appointment);
    }

    @Transactional
    public void updateStatus(Long id, AppointmentStatus status) {
        Appointment apt = appointmentRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid appointment ID: " + id));
        apt.setStatus(status);
        appointmentRepository.save(apt);
    }
}

