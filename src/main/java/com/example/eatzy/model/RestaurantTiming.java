package com.example.eatzy.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

import java.sql.Time;
import java.time.DayOfWeek;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "restaurant_timings")
public class RestaurantTiming {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long Id;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name="retaurant_id",nullable = false)
    private Restaurant restaurant;

    @Enumerated(EnumType.STRING)
    private DayOfWeek day_of_week;

    private Time open_time;

    private Time close_time;

    private Boolean is_close;
}
