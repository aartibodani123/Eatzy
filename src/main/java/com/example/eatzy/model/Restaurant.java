package com.example.eatzy.model;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "restaurants")
public class Restaurant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "restaurant_id")
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String area;

    @Column(nullable = false)
    private String location;

    @Column(nullable = false)
    private Double rating;

    @Column(nullable = false)
    private String phone;

    @Column(nullable = false,name="is_active")
    private boolean active;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Status status;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "image_public_id")
    private String imagePublicId;

    @JsonBackReference
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id", referencedColumnName = "user_id", nullable = false)
    private User owner;

    @Column(name = "rejection_reason")
    private String rejectionReason;

    @CreationTimestamp
    private LocalDateTime created_at;

//    @OneToMany(
//            mappedBy = "restaurant",
//            cascade = CascadeType.ALL,
//            orphanRemoval = true
//    )
//    private List<RestaurantTiming> timings = new ArrayList<>();

    public boolean getActive() {
        return this.active;
    }


}
