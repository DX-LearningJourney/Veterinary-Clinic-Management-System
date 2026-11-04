package com.vetcare.service;

import com.vetcare.model.Appointment;
import com.vetcare.model.Diagnosis;
import com.vetcare.model.MedicalRecord;
import com.vetcare.model.enums.AppointmentStatus;
import com.vetcare.repository.AppointmentRepository;
import com.vetcare.repository.DiagnosisRepository;
import com.vetcare.repository.MedicalRecordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MedicalRecordService {

    private final MedicalRecordRepository medicalRecordRepository;
    private final AppointmentRepository appointmentRepository;
    private final DiagnosisRepository diagnosisRepository;

    @Transactional(readOnly = true)
    public List<MedicalRecord> findAll() {
        return medicalRecordRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Optional<MedicalRecord> findById(Long id) {
        return medicalRecordRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public Optional<MedicalRecord> findByAppointmentId(Long appointmentId) {
        return medicalRecordRepository.findByAppointmentId(appointmentId);
    }

    @Transactional
    public MedicalRecord saveRecord(MedicalRecord record, Long appointmentId, String diagnosisName, String icdCode, String severity) {
        Appointment apt = appointmentRepository.findById(appointmentId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid appointment ID: " + appointmentId));

        record.setAppointment(apt);
        if (record.getVisitDate() == null) {
            record.setVisitDate(LocalDateTime.now());
        }

        MedicalRecord saved = medicalRecordRepository.save(record);

        if (diagnosisName != null && !diagnosisName.trim().isEmpty()) {
            Diagnosis diag = Diagnosis.builder()
                    .medicalRecord(saved)
                    .diagnosisName(diagnosisName)
                    .icdCode(icdCode)
                    .severity(severity != null ? severity : "MODERATE")
                    .isPrimary(true)
                    .build();
            diagnosisRepository.save(diag);
        }

        apt.setStatus(AppointmentStatus.COMPLETED);
        appointmentRepository.save(apt);

        return saved;
    }
}

