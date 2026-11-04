package com.vetcare.model;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "receptionists")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Receptionist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "full_name", nullable = false)
    private String fullName;

    @Column(name = "employee_code", nullable = false, unique = true)
    private String employeeCode;
}
