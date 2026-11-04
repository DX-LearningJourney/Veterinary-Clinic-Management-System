package com.vetcare.repository;

import com.vetcare.model.VetWorkingHours;
import com.vetcare.model.enums.DayOfWeekEnum;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VetWorkingHoursRepository extends JpaRepository<VetWorkingHours, Long> {

    List<VetWorkingHours> findByVeterinarianId(Long vetId);

    List<VetWorkingHours> findByVeterinarianIdAndIsActiveTrue(Long vetId);

    Optional<VetWorkingHours> findByVeterinarianIdAndDayOfWeek(Long vetId, DayOfWeekEnum dayOfWeek);
}
