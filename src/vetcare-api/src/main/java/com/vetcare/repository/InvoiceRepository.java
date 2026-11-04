package com.vetcare.repository;

import com.vetcare.model.Invoice;
import com.vetcare.model.enums.PaymentStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface InvoiceRepository extends JpaRepository<Invoice, Long> {

    Optional<Invoice> findByAppointmentId(Long appointmentId);

    List<Invoice> findByPaymentStatus(PaymentStatus status);

    long countByPaymentStatus(PaymentStatus status);
}
