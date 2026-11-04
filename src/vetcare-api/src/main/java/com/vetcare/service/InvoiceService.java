package com.vetcare.service;

import com.vetcare.model.Appointment;
import com.vetcare.model.Invoice;
import com.vetcare.model.InvoiceItem;
import com.vetcare.model.enums.AppointmentStatus;
import com.vetcare.model.enums.ItemType;
import com.vetcare.model.enums.PaymentStatus;
import com.vetcare.repository.AppointmentRepository;
import com.vetcare.repository.InvoiceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class InvoiceService {

    private final InvoiceRepository invoiceRepository;
    private final AppointmentRepository appointmentRepository;

    @Transactional(readOnly = true)
    public List<Invoice> findAll() {
        return invoiceRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Optional<Invoice> findById(Long id) {
        return invoiceRepository.findById(id);
    }

    @Transactional
    public Invoice generateInvoiceForAppointment(Long appointmentId, BigDecimal consultationFee) {
        Appointment apt = appointmentRepository.findById(appointmentId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid appointment ID: " + appointmentId));

        if (invoiceRepository.findByAppointmentId(appointmentId).isPresent()) {
            return invoiceRepository.findByAppointmentId(appointmentId).get();
        }

        BigDecimal fee = (consultationFee != null && consultationFee.compareTo(BigDecimal.ZERO) > 0)
                ? consultationFee : new BigDecimal("150000.00");

        Invoice invoice = Invoice.builder()
                .appointment(apt)
                .issuedAt(LocalDateTime.now())
                .subtotal(fee)
                .tax(BigDecimal.ZERO)
                .totalAmount(fee)
                .amountPaid(BigDecimal.ZERO)
                .paymentStatus(PaymentStatus.UNPAID)
                .build();

        InvoiceItem item = InvoiceItem.builder()
                .invoice(invoice)
                .description("Khám lâm sàng thú y: " + apt.getReasonForVisit())
                .itemType(ItemType.SERVICE)
                .quantity(1)
                .unitPrice(fee)
                .subtotal(fee)
                .build();

        invoice.addItem(item);
        return invoiceRepository.save(invoice);
    }

    @Transactional
    public Invoice processPayment(Long invoiceId, String paymentMethod, BigDecimal amountPaid) {
        Invoice invoice = invoiceRepository.findById(invoiceId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid invoice ID: " + invoiceId));

        invoice.setPaymentMethod(paymentMethod);
        invoice.setAmountPaid(amountPaid);
        invoice.setPaidAt(LocalDateTime.now());

        if (amountPaid.compareTo(invoice.getTotalAmount()) >= 0) {
            invoice.setPaymentStatus(PaymentStatus.PAID);
            if (invoice.getAppointment() != null) {
                invoice.getAppointment().setStatus(AppointmentStatus.CLOSED);
                appointmentRepository.save(invoice.getAppointment());
            }
        } else if (amountPaid.compareTo(BigDecimal.ZERO) > 0) {
            invoice.setPaymentStatus(PaymentStatus.PARTIALLY_PAID);
        }

        return invoiceRepository.save(invoice);
    }
}

