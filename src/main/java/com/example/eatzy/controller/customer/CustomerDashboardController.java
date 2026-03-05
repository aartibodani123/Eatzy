package com.example.eatzy.controller.customer;



import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/customer/dashboard")
public class CustomerDashboardController {

    @GetMapping("/stats")
    public ResponseEntity<?> getDashboardStats() {

        Map<String, Object> stats = new HashMap<>();

        // Hardcoded values (you can later replace with DB queries)
        stats.put("totalOrders", 12);
        stats.put("favorites", 5);
        stats.put("activeOffers", 3);

        return ResponseEntity.ok(stats);
    }
}