package com.vetcare.repository;

import com.vetcare.model.Prescription;
import com.vetcare.model.enums.PrescriptionStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface PrescriptionRepository extends JpaRepository<Prescription, Long> {

    Optional<Prescription> findByMedicalRecordId(Long medicalRecordId);

    List<Prescription> findByStatus(PrescriptionStatus status);
}
