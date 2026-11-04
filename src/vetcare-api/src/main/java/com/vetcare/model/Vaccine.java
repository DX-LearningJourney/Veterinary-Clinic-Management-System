package com.vetcare.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "vaccines")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Vaccine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 100)
    private String name;

    @Column(length = 200)
    private String manufacturer;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "interval_days")
    private Integer intervalDays;

    @Column(name = "target_species", length = 50)
    private String targetSpecies;
}

