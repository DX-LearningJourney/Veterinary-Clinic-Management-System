package com.vetcare.controller;

import com.vetcare.model.Appointment;
import com.vetcare.model.enums.AppointmentStatus;
import com.vetcare.repository.VeterinarianRepository;
import com.vetcare.service.AppointmentService;
import com.vetcare.service.PetService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
@RequestMapping("/appointments")
public class AppointmentController {

    private final AppointmentService appointmentService;
    private final PetService petService;
    private final VeterinarianRepository veterinarianRepository;

    public AppointmentController(AppointmentService appointmentService,
                                 PetService petService,
                                 VeterinarianRepository veterinarianRepository) {
        this.appointmentService = appointmentService;
        this.petService = petService;
        this.veterinarianRepository = veterinarianRepository;
    }

    @GetMapping
    public String listAppointments(Model model) {
        model.addAttribute("appointments", appointmentService.findAll());
        return "appointments/list";
    }

    @GetMapping("/new")
    public String showBookingForm(Model model) {
        model.addAttribute("pets", petService.findAll());
        model.addAttribute("vets", veterinarianRepository.findAll());
        return "appointments/form";
    }

    @PostMapping
    public String bookAppointment(@RequestParam("petId") Long petId,
                                  @RequestParam("vetId") Long vetId,
                                  @RequestParam("scheduledAt") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime scheduledAt,
                                  @RequestParam("reason") String reason) {
        appointmentService.bookAppointment(petId, vetId, scheduledAt, reason);
        return "redirect:/appointments";
    }

    @PostMapping("/{id}/status")
    public String updateStatus(@PathVariable("id") Long id,
                               @RequestParam("status") AppointmentStatus status) {
        appointmentService.updateStatus(id, status);
        return "redirect:/appointments";
    }
}
