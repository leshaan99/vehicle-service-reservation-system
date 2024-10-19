package com.example.vehicle.service.reservation.controller;

import com.example.vehicle.service.reservation.model.Reservation;
import com.example.vehicle.service.reservation.repository.ReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/reservations")
public class ReservationController {
    @Autowired
    private ReservationRepository reservationRepository;

    @GetMapping
    public List<Reservation> getAllReservations(Authentication authentication) {
        String username = getUsername(authentication);
        return reservationRepository.findByUsername(username);
    }

    @PostMapping
    public Reservation createReservation(@RequestBody Reservation reservation, Authentication authentication) {
        reservation.setUsername(getUsername(authentication));
        return reservationRepository.save(reservation);
    }

    @DeleteMapping("/{id}")
    public void deleteReservation(@PathVariable Long id, Authentication authentication) {
        Reservation reservation = reservationRepository.findById(id).orElseThrow();
        if (reservation.getUsername().equals(getUsername(authentication))) {
            reservationRepository.delete(reservation);
        }
    }

    private String getUsername(Authentication authentication) {
        if (authentication.getPrincipal() instanceof OAuth2User) {
            OAuth2User user = (OAuth2User) authentication.getPrincipal();
            return user.getAttribute("preferred_username");
        }
        return authentication.getName();
    }
}
