package com.vetcare.repository;

import com.vetcare.model.VetLeave;
import com.vetcare.model.enums.LeaveStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface VetLeaveRepository extends JpaRepository<VetLeave, Long> {

    List<VetLeave> findByVeterinarianId(Long vetId);

    List<VetLeave> findByVeterinarianIdAndStatus(Long vetId, LeaveStatus status);

    List<VetLeave> findByVeterinarianIdAndStartDateLessThanEqualAndEndDateGreaterThanEqual(Long vetId, LocalDate endDate, LocalDate startDate);
}
