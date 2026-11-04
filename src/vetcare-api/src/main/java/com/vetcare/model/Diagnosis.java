package com.vetcare.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;

@Entity
@Table(name = "diagnoses")
public class Diagnosis {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medical_record_id", nullable = false)
    @JsonIgnore
    private MedicalRecord medicalRecord;

    @Column(name = "diagnosis_name", nullable = false)
    private String diagnosisName;

    @Column(name = "icd_code")
    private String icdCode;

    @Column
    private String severity;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @Column(name = "is_primary", nullable = false)
    private Boolean isPrimary = false;

    public Diagnosis() {}

    public Diagnosis(Long id, MedicalRecord medicalRecord, String diagnosisName, String icdCode, String severity, String notes, Boolean isPrimary) {
        this.id = id;
        this.medicalRecord = medicalRecord;
        this.diagnosisName = diagnosisName;
        this.icdCode = icdCode;
        this.severity = severity;
        this.notes = notes;
        this.isPrimary = isPrimary != null ? isPrimary : false;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public MedicalRecord getMedicalRecord() { return medicalRecord; }
    public void setMedicalRecord(MedicalRecord medicalRecord) { this.medicalRecord = medicalRecord; }

    public String getDiagnosisName() { return diagnosisName; }
    public void setDiagnosisName(String diagnosisName) { this.diagnosisName = diagnosisName; }

    public String getIcdCode() { return icdCode; }
    public void setIcdCode(String icdCode) { this.icdCode = icdCode; }

    public String getSeverity() { return severity; }
    public void setSeverity(String severity) { this.severity = severity; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    public Boolean getIsPrimary() { return isPrimary; }
    public void setIsPrimary(Boolean isPrimary) { this.isPrimary = isPrimary; }
}
