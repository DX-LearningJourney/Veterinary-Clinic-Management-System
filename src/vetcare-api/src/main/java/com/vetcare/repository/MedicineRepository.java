package com.vetcare.repository;

import com.vetcare.model.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MedicineRepository extends JpaRepository<Medicine, Long> {

    List<Medicine> findByIsActiveTrue();

    List<Medicine> findByStockQuantityLessThanEqual(int threshold);

    List<Medicine> findByNameContainingIgnoreCase(String name);

    @Query("SELECT m FROM Medicine m WHERE m.stockQuantity <= m.minStockThreshold AND m.isActive = true")
    List<Medicine> findLowStockMedicines();

    long countByStockQuantityLessThanEqualAndIsActiveTrue(int threshold);
}
