package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.InvalidOperationException;
import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.common.exception.ResourceNotFoundException;
import com.example.eatzy.dto.MenuItemRequest;
import com.example.eatzy.model.*;
//import com.example.eatzy.repository.CategoryRepository;
import com.example.eatzy.repository.CategoryRepository;
import com.example.eatzy.repository.MenuItemRepository;
import com.example.eatzy.repository.RestaurantRepository;
import com.example.eatzy.repository.UserRepository;
import com.example.eatzy.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.stereotype.Service;

import java.util.Set;
import java.util.stream.Collectors;

@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    UserRepository userRepository;
    @Autowired
    RestaurantRepository restaurantRepository;
    @Autowired
    MenuItemRepository menuItemRepository;
    @Autowired
    CategoryRepository categoryRepository;
    @Override
    public MenuItemRequest addMenuItem(Long id, MenuItemRequest request, String email) {
        User owner=userRepository.findByEmail(email)
                .orElseThrow(()->new ResourceNotFoundException("User not found"));
        if(owner.getRole()!=Role.RESTAURANT_OWNER){
            throw new ResourceAccessDeniedException("Access Denied");
        }
        Restaurant restaurant=restaurantRepository.findById(id)
                .orElseThrow(()->new ResourceNotFoundException("Restaurant not found"));
        //check if this owner owns this restaurant or not
        if(!restaurant.getOwner().getUserId().equals(owner.getUserId())){
            throw new ResourceAccessDeniedException("Not your restaurant");
        }
        //check if restaurant is already approved or not
        if(restaurant.getStatus()!= Status.APPROVED || !restaurant.getActive()){
            throw new InvalidOperationException("Restaurant not allowed to add menu");
        }
        //their must exist category for a particular restaurant
        if(categoryRepository.countByRestaurantId(restaurant.getId())==0){
            throw new InvalidOperationException("Create a category first to enter menu item");
        }
        //request must have category in which item has to included
        if(request.getCategoryIds()==null || request.getCategoryIds().isEmpty()){
            throw new InvalidOperationException("Menu item must belong to at least one category");

        }
        Set<Category> categories = categoryRepository.findAllById(request.getCategoryIds())
                .stream()
                .collect(Collectors.toSet());
        //all categoires in request should be in restarunt as well
        if (categories.size() != request.getCategoryIds().size()) {
            throw new ResourceNotFoundException("One or more categories not found");
        }
        boolean invalidCategory = categories.stream()
                .anyMatch(c -> !c.getRestaurant().getId().equals(restaurant.getId()));

        if (invalidCategory) {
            throw new ResourceAccessDeniedException("Category does not belong to this restaurant");
        }

        MenuItem menuItem=new MenuItem();
        menuItem.setName(request.getName());
        menuItem.setAvailable(request.isAvailable());
        menuItem.setPrice(request.getPrice());
        menuItem.setRestaurant(restaurant);
        menuItem.setCategories(categories);

        menuItemRepository.save(menuItem);
        return request;

    }
}
