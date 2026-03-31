package com.example.eatzy.service.impl;

import com.example.eatzy.common.exception.InvalidOperationException;
import com.example.eatzy.common.exception.ResourceAccessDeniedException;
import com.example.eatzy.common.exception.ResourceNotFoundException;
import com.example.eatzy.dto.CategoryMenuResponseDTO;
import com.example.eatzy.dto.MenuItemRequest;
import com.example.eatzy.dto.MenuItemResponseDTO;
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

import java.util.List;
import java.util.Map;
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

        MenuItem menuItem = buildMenuItem(id, request, email);

        menuItemRepository.save(menuItem);

        return request;
    }
    public MenuItemRequest addMenuItemWithImage(Long id, MenuItemRequest request, String email) {

        MenuItem menuItem = buildMenuItem(id, request, email);

        menuItem.setImageUrl(request.getImageUrl());
        menuItem.setImagePublicId(request.getImagePublicId());

        menuItemRepository.save(menuItem);
        request.setImageFile(null);
        return request;
    }
    private MenuItem buildMenuItem(Long id, MenuItemRequest request, String email) {

        User owner = userRepository.findByEmail(email)
                .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (owner.getRole() != Role.RESTAURANT_OWNER) {
            throw new ResourceAccessDeniedException("Access Denied");
        }

        Restaurant restaurant = restaurantRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Restaurant not found"));

        if (!restaurant.getOwner().getUserId().equals(owner.getUserId())) {
            throw new ResourceAccessDeniedException("Not your restaurant");
        }

        if (restaurant.getStatus() != Status.APPROVED || !restaurant.getActive()) {
            throw new InvalidOperationException("Restaurant not allowed to add menu");
        }

        if (categoryRepository.countByRestaurantId(restaurant.getId()) == 0) {
            throw new InvalidOperationException("Create a category first to enter menu item");
        }

        if (request.getCategoryIds() == null || request.getCategoryIds().isEmpty()) {
            throw new InvalidOperationException("Menu item must belong to at least one category");
        }

        Set<Category> categories = categoryRepository.findAllById(request.getCategoryIds())
                .stream()
                .collect(Collectors.toSet());

        if (categories.size() != request.getCategoryIds().size()) {
            throw new ResourceNotFoundException("One or more categories not found");
        }

        boolean invalidCategory = categories.stream()
                .anyMatch(c -> !c.getRestaurant().getId().equals(restaurant.getId()));

        if (invalidCategory) {
            throw new ResourceAccessDeniedException("Category does not belong to this restaurant");
        }

        MenuItem menuItem = new MenuItem();
        menuItem.setName(request.getName());
        menuItem.setAvailable(request.isAvailable());
        menuItem.setPrice(request.getPrice());
        menuItem.setRestaurant(restaurant);
        menuItem.setCategories(categories);

        return menuItem;
    }

    @Override
    public List<CategoryMenuResponseDTO> getMenuByRestaurant(Long id) {
        if(!restaurantRepository.existsById(id)){
            throw new ResourceNotFoundException("Restaurant not found with id"+id);
        }
        List<MenuItem> items=menuItemRepository.findByRestaurantIdAndAvailableTrue(id);
        Map<Category, List<MenuItem>> grouped = items.stream()
                .flatMap(item -> item.getCategories().stream()
                        .map(cat -> Map.entry(cat, item)))
                .collect(Collectors.groupingBy(
                        Map.Entry::getKey,
                        Collectors.mapping(Map.Entry::getValue, Collectors.toList())
                ));
        return grouped.entrySet().stream().map(entry -> {
            Category category = entry.getKey();
            List<MenuItem> menuItems = entry.getValue();

            CategoryMenuResponseDTO dto = new CategoryMenuResponseDTO();
            dto.setCategoryId(category.getId());
            dto.setCategoryName(category.getName());

            List<MenuItemResponseDTO> itemDtos = menuItems.stream()
                    .map(this::toDto)
                    .toList();

            dto.setItems(itemDtos);

            return dto;
        }).toList();
    }
    private MenuItemResponseDTO toDto(MenuItem item) {
        MenuItemResponseDTO dto = new MenuItemResponseDTO();
        dto.setId(item.getId());
        dto.setName(item.getName());
        dto.setPrice(item.getPrice());
        dto.setDescription(item.getDescription());
        dto.setAvailable(item.isAvailable());
        dto.setImageUrl(item.getImageUrl());
        return dto;
    }
}
