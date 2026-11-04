package com.vetcare.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "pets")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Pet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id", nullable = false)
    @JsonIgnore
    private PetOwner owner;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String species;

    @Column
    private String breed;

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    @Column
    private String gender;

    @Column(precision = 10, scale = 2)
    private BigDecimal weight;

    @Column(name = "microchip_id", unique = true)
    private String microchipId;

    @Column(name = "known_allergies", columnDefinition = "TEXT")
    private String knownAllergies;

    @Column(name = "photo_url")
    private String photoUrl;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
