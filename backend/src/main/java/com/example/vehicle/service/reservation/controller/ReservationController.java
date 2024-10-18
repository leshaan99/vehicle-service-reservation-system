package com.example.vehicle.service.reservation.controller;

import com.example.vehicle.service.reservation.entity.Reservation;
import com.example.vehicle.service.reservation.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/api/reservations")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @GetMapping
    public List<Reservation> getAllReservations(Principal principal) {
        return reservationService.findByUsername(principal.getName());
    }

    @PostMapping
    public Reservation createReservation(@RequestBody Reservation reservation, Principal principal) {
        reservation.setUsername(principal.getName());
        return reservationService.save(reservation);
    }

    @DeleteMapping("/{id}")
    public void deleteReservation(@PathVariable int id, Principal principal) {
        reservationService.deleteByIdAndUsername(id, principal.getName());
    }
}
