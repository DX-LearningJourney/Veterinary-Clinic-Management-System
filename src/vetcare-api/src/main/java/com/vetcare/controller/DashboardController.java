package com.vetcare.controller;

import com.vetcare.repository.AppointmentRepository;
import com.vetcare.repository.InvoiceRepository;
import com.vetcare.repository.MedicineRepository;
import com.vetcare.repository.PetRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.time.LocalDateTime;

@Controller
public class DashboardController {

    private final PetRepository petRepository;
    private final AppointmentRepository appointmentRepository;
    private final InvoiceRepository invoiceRepository;
    private final MedicineRepository medicineRepository;

    public DashboardController(PetRepository petRepository,
                               AppointmentRepository appointmentRepository,
                               InvoiceRepository invoiceRepository,
                               MedicineRepository medicineRepository) {
        this.petRepository = petRepository;
        this.appointmentRepository = appointmentRepository;
        this.invoiceRepository = invoiceRepository;
        this.medicineRepository = medicineRepository;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        LocalDateTime startOfDay = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0);
        LocalDateTime endOfDay = LocalDateTime.now().withHour(23).withMinute(59).withSecond(59);

        model.addAttribute("totalPets", petRepository.count());
        model.addAttribute("todayAppointments", appointmentRepository.findByScheduledAtBetween(startOfDay, endOfDay));
        model.addAttribute("todayAppointmentsCount", appointmentRepository.findByScheduledAtBetween(startOfDay, endOfDay).size());
        model.addAttribute("totalInvoices", invoiceRepository.count());
        model.addAttribute("lowStockMedicines", medicineRepository.findAll().stream().filter(m -> m.isLowStock()).toList());

        return "dashboard";
    }
}
