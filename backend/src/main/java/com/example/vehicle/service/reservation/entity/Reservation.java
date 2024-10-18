package com.example.vehicle.service.reservation.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "reservations")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bookingId;

    private String username;
    private String date;
    private String time;
    private String location;
    private String vehicleNo;
    private int mileage;
    private String message;
}



