package com.example.vehicle.service.reservation.service;

import com.example.vehicle.service.reservation.entity.Reservation;
import com.example.vehicle.service.reservation.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservationService {

    private final ReservationRepository reservationRepository;

    @Autowired
    public ReservationService(ReservationRepository reservationRepository) {
        this.reservationRepository = reservationRepository;
    }

    public List<Reservation> findByUsername(String username) {
        return reservationRepository.findByUsername(username);
    }

    public Reservation save(Reservation reservation) {
        return reservationRepository.save(reservation);
    }

    public void deleteByIdAndUsername(int id, String username) {
        reservationRepository.deleteByIdAndUsername(id, username);
    }
}