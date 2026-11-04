package com.vetcare.repository;

import com.vetcare.model.StockTransaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface StockTransactionRepository extends JpaRepository<StockTransaction, Long> {

    List<StockTransaction> findByMedicineIdOrderByTransactionDateDesc(Long medicineId);

    List<StockTransaction> findByTransactionDateBetween(LocalDateTime start, LocalDateTime end);
}
