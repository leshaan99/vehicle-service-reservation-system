package com.example.vehicle.service.reservation.service;

import com.example.vehicle.service.reservation.entity.Reservation;
import com.example.vehiclereservation.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;

    public List<Reservation> findByUsername(String username) {
        // Fetch all reservations for a specific user
        return reservationRepository.findByUsername(username);
    }

    public Reservation save(Reservation reservation) {
        // Save a new reservation to the database
        return reservationRepository.save(reservation);
    }

    public void deleteByIdAndUsername(int id, String username) {
        // Ensure the reservation belongs to the authenticated user before deleting
        reservationRepository.deleteByIdAndUsername(id, username);
    }
}
