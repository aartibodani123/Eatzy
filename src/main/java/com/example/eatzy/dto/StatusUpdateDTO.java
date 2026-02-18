package com.example.eatzy.dto;

import com.example.eatzy.model.Status;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class StatusUpdateDTO {
    private Long id;
    private Status status;
    private String rejectionReason;
}
