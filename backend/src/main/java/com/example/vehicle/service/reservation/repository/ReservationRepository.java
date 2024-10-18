package com.example.vehicle.service.reservation.repository;

import com.example.vehicle.service.reservation.entity.Reservation;
import com.example.vehiclereservation.entity.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReservationRepository extends JpaRepository<Reservation, Integer> {
    List<Reservation> findByUsername(String username);

    void deleteByIdAndUsername(int id, String username);
}
