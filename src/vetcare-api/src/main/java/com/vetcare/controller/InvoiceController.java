package com.vetcare.controller;

import com.vetcare.model.Invoice;
import com.vetcare.service.AppointmentService;
import com.vetcare.service.InvoiceService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;

@Controller
@RequestMapping("/invoices")
public class InvoiceController {

    private final InvoiceService invoiceService;
    private final AppointmentService appointmentService;

    public InvoiceController(InvoiceService invoiceService, AppointmentService appointmentService) {
        this.invoiceService = invoiceService;
        this.appointmentService = appointmentService;
    }

    @GetMapping
    public String listInvoices(Model model) {
        model.addAttribute("invoices", invoiceService.findAll());
        return "invoices/list";
    }

    @PostMapping("/generate")
    public String generateInvoice(@RequestParam("appointmentId") Long appointmentId,
                                  @RequestParam(value = "fee", required = false) BigDecimal fee) {
        Invoice invoice = invoiceService.generateInvoiceForAppointment(appointmentId, fee);
        return "redirect:/invoices/" + invoice.getId();
    }

    @GetMapping("/{id}")
    public String viewInvoice(@PathVariable("id") Long id, Model model) {
        Invoice invoice = invoiceService.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid invoice ID: " + id));
        model.addAttribute("invoice", invoice);
        return "invoices/detail";
    }

    @PostMapping("/{id}/pay")
    public String payInvoice(@PathVariable("id") Long id,
                             @RequestParam("paymentMethod") String paymentMethod,
                             @RequestParam("amountPaid") BigDecimal amountPaid) {
        invoiceService.processPayment(id, paymentMethod, amountPaid);
        return "redirect:/invoices/" + id;
    }
}
