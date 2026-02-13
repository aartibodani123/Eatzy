package com.example.eatzy.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.AnyDiscriminatorImplicitValues;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "restaurants")
public class Restaurant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long restaurant_id;

    @Column(nullable = false)
    private String area;

    @Column(nullable = false)
    private String location;

    @Column(nullable = false)
    private Double rating;

    @Column(nullable = false)
    private boolean is_active;

    @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "owner_id", nullable = false)
    private User owner;
}
