package com.example.vehicle.service.reservation.entity;

import jakarta.persistence.*;

import java.sql.Date;
import java.sql.Time;

@Entity
@Table(name = "reservations")
public class Reservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int bookingId;

    @Column(nullable = false)
    private String username;

    @Column(nullable = false)
    private Date date;

    @Column(nullable = false)
    private Time time;

    @Column(nullable = false)
    private String location;

    @Column(nullable = false)
    private String vehicleNo;

    @Column(nullable = false)
    private int mileage;

    @Column(columnDefinition = "TEXT")
    private String message;
}



