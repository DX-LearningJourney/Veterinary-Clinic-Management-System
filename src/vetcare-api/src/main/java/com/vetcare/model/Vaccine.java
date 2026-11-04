package com.vetcare.model;

import jakarta.persistence.*;

@Entity
@Table(name = "vaccines")
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

    public Vaccine() {}

    public Vaccine(Long id, String name, String manufacturer, String description, Integer intervalDays, String targetSpecies) {
        this.id = id;
        this.name = name;
        this.manufacturer = manufacturer;
        this.description = description;
        this.intervalDays = intervalDays;
        this.targetSpecies = targetSpecies;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Integer getIntervalDays() { return intervalDays; }
    public void setIntervalDays(Integer intervalDays) { this.intervalDays = intervalDays; }

    public String getTargetSpecies() { return targetSpecies; }
    public void setTargetSpecies(String targetSpecies) { this.targetSpecies = targetSpecies; }
}
