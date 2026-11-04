package com.vetcare.controller;

import com.vetcare.model.Vaccination;
import com.vetcare.repository.VeterinarianRepository;
import com.vetcare.service.PetService;
import com.vetcare.service.VaccinationService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/vaccinations")
@RequiredArgsConstructor
public class VaccinationController {

    private final VaccinationService vaccinationService;
    private final PetService petService;
    private final VeterinarianRepository veterinarianRepository;

    @GetMapping
    public String listVaccinations(Model model) {
        model.addAttribute("vaccinations", vaccinationService.findAll());
        return "vaccinations/list";
    }

    @GetMapping("/new")
    public String showForm(Model model) {
        model.addAttribute("pets", petService.findAll());
        model.addAttribute("vaccines", vaccinationService.findAllVaccines());
        model.addAttribute("vets", veterinarianRepository.findAll());
        return "vaccinations/form";
    }

    @PostMapping
    public String recordVaccination(@RequestParam("petId") Long petId,
                                    @RequestParam("vaccineId") Long vaccineId,
                                    @RequestParam("vetId") Long vetId,
                                    @RequestParam("batchNumber") String batchNumber,
                                    @RequestParam("adminDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate adminDate,
                                    @RequestParam(value = "notes", required = false) String notes) {
        vaccinationService.recordVaccination(petId, vaccineId, vetId, batchNumber, adminDate, notes);
        return "redirect:/vaccinations";
    }
}

