package com.example.eatzy.controller.customer;

import com.example.eatzy.dto.TrackOrderResponse;
import com.example.eatzy.model.User;
import com.example.eatzy.service.OrderService;
import com.example.eatzy.service.UserGuard;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.ui.Model;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerPageController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserGuard userGuard;
    @GetMapping("/dashboard")
    public String customerDashboard(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("========== DASHBOARD ACCESS ==========");
        System.out.println("Request URI: " + request.getRequestURI());
        System.out.println("Auth header: " + request.getHeader("Authorization"));

        // Get token from session if you're also using session
        System.out.println("Session token: " + request.getSession().getAttribute("jwt"));

        return "customer-dashboard";
    }


    @RequestMapping("/browse-restaurant")
    public String browseRestaurant(){
        return "browse-restaurant";
    }
    @GetMapping("/area-restaurants")
    public String areaRestaurantsPage(@RequestParam String area, Model model) {
        model.addAttribute("area", area);
        return "area-restaurants";
    }
    @GetMapping("/view-restaurant-menu")
    public String viewRestaurantMenuPage(@RequestParam Long restaurantId, Model model) {
        model.addAttribute("restaurantId", restaurantId);
        return "view-restaurant-menu";
    }

    @GetMapping("/cart-page")
    public String cartPage() {
        return "cart";
    }

//    @GetMapping("/orders")
//    public String myOrders(Model model){
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//
//        System.out.println("Authorities: " + auth.getAuthorities());
//        System.out.println("Principal: " + auth.getPrincipal());
//
//        String email = auth.getName();
//        User user = userGuard.validateCustomer(email);
//        List<TrackOrderResponse> orders = orderService.allOrders(user.getUserId());
//        model.addAttribute("orders", orders);
//
//        return "customer-orders";
//    }
        @GetMapping("/orders")
        public String myOrders(Model model){
            return "customer-orders";
        }
    @GetMapping("/orders/{orderId}/track-page")
    public String trackOrderPage(@PathVariable Long orderId, Model model) {
        model.addAttribute("orderId", orderId);
        return "track-order";
    }


}
