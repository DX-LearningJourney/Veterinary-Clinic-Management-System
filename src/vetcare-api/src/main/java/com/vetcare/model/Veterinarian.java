package com.vetcare.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "veterinarians")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Veterinarian {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Column
    private String specialization;

    @Column(name = "license_number", nullable = false, unique = true)
    private String licenseNumber;

    @Builder.Default
    @Column(name = "is_available", nullable = false)
    private Boolean isAvailable = true;
}
