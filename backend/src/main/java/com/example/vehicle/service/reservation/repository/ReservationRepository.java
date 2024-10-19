package com.example.vehicle.service.reservation.repository;

import com.example.vehicle.service.reservation.model.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReservationRepository extends JpaRepository<Reservation, Long> {
    List<Reservation> findByUsername(String username);
}

