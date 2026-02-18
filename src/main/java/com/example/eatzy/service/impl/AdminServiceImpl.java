package com.example.eatzy.service.impl;

import com.example.eatzy.dto.RestaurantDTO;
import com.example.eatzy.dto.StatusUpdateDTO;
import com.example.eatzy.exception.ResourceNotFoundException;
import com.example.eatzy.model.Restaurant;
import com.example.eatzy.model.Status;
import com.example.eatzy.repository.RestaurantRepository;
import com.example.eatzy.repository.UserRepository;
import com.example.eatzy.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {
    @Autowired
    private UserRepository repo;
    @Autowired
    private RestaurantRepository restaurantRepository;
    public AdminServiceImpl(UserRepository repo){
        this.repo=repo;
    }
    public Long countTotalCustomer(){
        return repo.countCustomers();
    }
    public Long countTotalRestaurant(){
        return restaurantRepository.countRestaurants();
    }
    public RestaurantDTO updateRestaurantStatus(Long id, StatusUpdateDTO statusUpdateDTO){
        Restaurant restaurant=restaurantRepository.findById(id)
                .orElseThrow(()-> new ResourceNotFoundException("Restaurant  not found"));
        restaurant.setStatus(statusUpdateDTO.getStatus());
        if(statusUpdateDTO.getStatus()== Status.REJECTED){
            restaurant.setRejectionReason(statusUpdateDTO.getRejectionReason());
            restaurant.setActive(false);
        }else if(statusUpdateDTO.getStatus()==Status.APPROVED){
            restaurant.setActive(true);
            restaurant.setRejectionReason(null);
        }
        restaurantRepository.save(restaurant);
        RestaurantDTO dto = new RestaurantDTO();
        dto.setId(restaurant.getId());
        dto.setName(restaurant.getName());
        dto.setArea(restaurant.getArea());
        dto.setLocation(restaurant.getLocation());
        dto.setPhone(restaurant.getPhone());
        dto.setActive(restaurant.getActive());
        dto.setStatus(restaurant.getStatus());
        dto.setRejectionReason(restaurant.getRejectionReason());

        return dto;

    }

    public List<RestaurantDTO> getPendingRestaurants(){
        List<Restaurant> restaurants = restaurantRepository.findByStatus(Status.PENDING);

        return restaurants.stream()
                .map(this::toDTO)   // convert each entity to DTO
                .toList();

    }
    private RestaurantDTO toDTO(Restaurant r) {
        RestaurantDTO dto = new RestaurantDTO();
        dto.setId(r.getId());
        dto.setName(r.getName());
        dto.setArea(r.getArea());
        dto.setLocation(r.getLocation());
        dto.setPhone(r.getPhone());

        dto.setActive(r.getActive());
        dto.setStatus(r.getStatus());
        dto.setRejectionReason(r.getRejectionReason());

        return dto;
    }



}
