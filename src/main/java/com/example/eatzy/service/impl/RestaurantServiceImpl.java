package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.dto.RestaurantDTO;
import com.example.eatzy.dto.RestaurantResponseDTO;
import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.Role;
import com.example.eatzy.model.Status;
import com.example.eatzy.model.User;
import com.example.eatzy.repository.RestaurantRepository;
import com.example.eatzy.repository.UserRepository;
import com.example.eatzy.service.CloudinaryService;
import com.example.eatzy.service.RestaurantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.AccessDeniedException;
import java.util.List;

@Service
public class RestaurantServiceImpl implements RestaurantService {
    @Autowired
    RestaurantRepository repo;
    @Autowired
    UserRepository userRepository;

    @Autowired
    CloudinaryService cloudinaryService;
    public RestaurantDTO  addRestuarantDetails(RestaurantDTO rest, User owner) throws AccessDeniedException {
        Restaurant restaurant=new Restaurant();
        restaurant.setName(rest.getName());
        restaurant.setArea(rest.getArea());
        restaurant.setLocation(rest.getLocation());
        restaurant.setPhone(rest.getPhone());

        if(owner.getRole() != Role.RESTAURANT_OWNER){
            throw new AccessDeniedException("Only restaurant owners can add restaurants");
        }
        restaurant.setStatus(Status.PENDING);
        restaurant.setActive(false);
        restaurant.setRating(0.0);
        restaurant.setOwner(owner);

        Restaurant saved = repo.save(restaurant);

        RestaurantDTO response = new RestaurantDTO();
        response.setId(saved.getId());
        response.setName(saved.getName());
        response.setArea(saved.getArea());
        response.setLocation(saved.getLocation());
        response.setPhone(saved.getPhone());
        return response;
    }


    public List<RestaurantResponseDTO> findRestaurantsByArea(String area) {
        if (area == null || area.trim().isEmpty()) {
            throw new IllegalArgumentException("Area must not be empty");
        }
        List<Restaurant> restaurants =
                repo.findActiveApprovedByArea(area, Status.APPROVED);
        return restaurants.stream()
                .map(this::toDto)
                .toList();
    }

    public List<RestaurantResponseDTO> getRestaurantsByOwner(Long ownerId) {
        return repo.findByOwner_UserId(ownerId)
                .stream()
                .map(r -> {
                    RestaurantResponseDTO dto = new RestaurantResponseDTO();
                    dto.setId(r.getId());
                    dto.setName(r.getName());
                    dto.setArea(r.getArea());
                    dto.setLocation(r.getLocation());
                    return dto;
                })
                .toList();
    }
    public boolean isOwnedBy(Long restaurantId, Long ownerId) {
        return repo.existsByIdAndOwner_UserId(restaurantId, ownerId);
    }
    public Restaurant getOwnedRestaurant(Long restaurantId, Long ownerId) {
        return repo.findById(restaurantId)
                .filter(r -> r.getOwner().getUserId().equals(ownerId))
                .orElseThrow(() -> new ResourceAccessDeniedException("Not your restaurant"));
    }

    private RestaurantResponseDTO toDto(Restaurant restaurant) {
        RestaurantResponseDTO dto = new RestaurantResponseDTO();
        dto.setId(restaurant.getId());
        dto.setName(restaurant.getName());
        dto.setArea(restaurant.getArea());
        dto.setLocation(restaurant.getLocation());
        dto.setImageUrl(restaurant.getImageUrl());
        return dto;
    }
    public String uploadRestaurantImage(Long restaurantId,
                                        MultipartFile image,
                                        String email) {

        Restaurant restaurant = repo.findById(restaurantId)
                .orElseThrow(() -> new RuntimeException("Restaurant not found"));

        if (!restaurant.getOwner().getEmail().equals(email)) {
            throw new RuntimeException("Unauthorized");
        }


        try {

            if (restaurant.getImagePublicId() != null) {
                cloudinaryService.deleteImage(restaurant.getImagePublicId());
            }


            var uploadResponse = cloudinaryService.uploadImage(
                    image,
                    "eatzy/restaurants"
            );

            restaurant.setImageUrl(uploadResponse.get("url"));
            restaurant.setImagePublicId(uploadResponse.get("publicId"));

            repo.saveAndFlush(restaurant);

            return uploadResponse.get("url");

        } catch (Exception e) {
            throw new RuntimeException("Image upload failed", e);
        }
    }
}
