package com.vetcare.repository;

import com.vetcare.model.Appointment;
import com.vetcare.model.enums.AppointmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment, Long> {

    List<Appointment> findByPetOwnerId(Long ownerId);

    List<Appointment> findByVeterinarianId(Long vetId);

    List<Appointment> findByPetId(Long petId);

    List<Appointment> findByScheduledAtBetween(LocalDateTime start, LocalDateTime end);

    List<Appointment> findByVeterinarianIdAndScheduledAtBetween(Long vetId, LocalDateTime start, LocalDateTime end);

    List<Appointment> findByStatus(AppointmentStatus status);

    long countByScheduledAtBetweenAndStatusNot(LocalDateTime start, LocalDateTime end, AppointmentStatus status);

    List<Appointment> findByScheduledAtBetweenAndStatusNot(LocalDateTime start, LocalDateTime end, AppointmentStatus status);
}
