package com.vetcare.model;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "medicines")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Medicine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 200)
    private String name;

    @Column(name = "active_ingredient", length = 200)
    private String activeIngredient;

    @Column(name = "dosage_form", length = 50)
    private String dosageForm;

    @Column(nullable = false, length = 30)
    private String unit;

    @Column(name = "unit_price", nullable = false, precision = 10, scale = 2)
    private BigDecimal unitPrice;

    @Column(name = "stock_quantity", nullable = false)
    @Builder.Default
    private Integer stockQuantity = 0;

    @Column(name = "min_stock_threshold", nullable = false)
    @Builder.Default
    private Integer minStockThreshold = 10;

    @Column(name = "is_active", nullable = false)
    @Builder.Default
    private Boolean isActive = true;

    @Column(name = "expiry_date")
    private LocalDate expiryDate;

    @Column(name = "last_restocked_at")
    private LocalDateTime lastRestockedAt;

    @Column(name = "supplier_name", length = 200)
    private String supplierName;

    public boolean isLowStock() {
        return stockQuantity != null && stockQuantity <= minStockThreshold;
    }
}

