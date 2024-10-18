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

    private String username;
    private Date date;
    private Time time;
    private String location;
    private String vehicleNo;
    private int mileage;
    private String message;
}



