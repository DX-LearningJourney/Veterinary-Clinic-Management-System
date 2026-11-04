package com.vetcare.controller;

import com.vetcare.model.Appointment;
import com.vetcare.model.MedicalRecord;
import com.vetcare.service.AppointmentService;
import com.vetcare.service.MedicalRecordService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/medical-records")
public class MedicalRecordController {

    private final MedicalRecordService medicalRecordService;
    private final AppointmentService appointmentService;

    public MedicalRecordController(MedicalRecordService medicalRecordService,
                                   AppointmentService appointmentService) {
        this.medicalRecordService = medicalRecordService;
        this.appointmentService = appointmentService;
    }

    @GetMapping
    public String listRecords(Model model) {
        model.addAttribute("records", medicalRecordService.findAll());
        return "medical-records/list";
    }

    @GetMapping("/new")
    public String showSoapForm(@RequestParam("appointmentId") Long appointmentId, Model model) {
        Appointment apt = appointmentService.findById(appointmentId)
                .orElseThrow(() -> new IllegalArgumentException("Invalid appointment ID: " + appointmentId));

        model.addAttribute("appointment", apt);
        model.addAttribute("record", new MedicalRecord());
        return "medical-records/soap-form";
    }

    @PostMapping
    public String saveRecord(@ModelAttribute("record") MedicalRecord record,
                             @RequestParam("appointmentId") Long appointmentId,
                             @RequestParam(value = "diagnosisName", required = false) String diagnosisName,
                             @RequestParam(value = "icdCode", required = false) String icdCode,
                             @RequestParam(value = "severity", required = false) String severity) {
        medicalRecordService.saveRecord(record, appointmentId, diagnosisName, icdCode, severity);
        return "redirect:/medical-records";
    }

    @GetMapping("/{id}")
    public String viewRecord(@PathVariable("id") Long id, Model model) {
        MedicalRecord record = medicalRecordService.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid record ID: " + id));
        model.addAttribute("record", record);
        return "medical-records/detail";
    }
}
