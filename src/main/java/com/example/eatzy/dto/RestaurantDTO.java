package com.example.eatzy.dto;

import com.example.eatzy.model.Status;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RestaurantDTO {
    private Long id;
    private String name;
    private String area;
    private String location;
    private String phone;

    private boolean active;
    private Status status;

    private String rejectionReason;
    @JsonProperty("id")
    public Long getId() {
        return id;
    }



}
