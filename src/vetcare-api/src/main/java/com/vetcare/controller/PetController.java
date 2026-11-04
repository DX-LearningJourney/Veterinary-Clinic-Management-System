package com.vetcare.controller;

import com.vetcare.model.Pet;
import com.vetcare.service.PetService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/pets")
public class PetController {

    private final PetService petService;

    public PetController(PetService petService) {
        this.petService = petService;
    }

    @GetMapping
    public String listPets(Model model) {
        model.addAttribute("pets", petService.findAll());
        return "pets/list";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("pet", new Pet());
        model.addAttribute("owners", petService.findAllOwners());
        return "pets/form";
    }

    @PostMapping
    public String savePet(@ModelAttribute("pet") Pet pet, @RequestParam("ownerId") Long ownerId) {
        petService.save(pet, ownerId);
        return "redirect:/pets";
    }

    @GetMapping("/{id}")
    public String viewPet(@PathVariable("id") Long id, Model model) {
        Pet pet = petService.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid pet ID: " + id));
        model.addAttribute("pet", pet);
        return "pets/detail";
    }

    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable("id") Long id, Model model) {
        Pet pet = petService.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid pet ID: " + id));
        model.addAttribute("pet", pet);
        model.addAttribute("owners", petService.findAllOwners());
        return "pets/form";
    }

    @PostMapping("/{id}/delete")
    public String deletePet(@PathVariable("id") Long id) {
        petService.deleteById(id);
        return "redirect:/pets";
    }
}
