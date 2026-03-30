package com.example.eatzy.util;


public enum RoleDashboard {
    ADMIN("ROLE_ADMIN", "/admin/dashboard"),
    CUSTOMER("ROLE_CUSTOMER", "/customer/dashboard"),
    RESTAURANT_OWNER("ROLE_RESTAURANT_OWNER", "/restaurant/dashboard");

    private final String role;
    private final String url;

    RoleDashboard(String role, String url) {
        this.role = role;
        this.url = url;
    }

    public String getRole() { return role; }
    public String getUrl() { return url; }

    public static String getUrlByRole(String role) {
        for (RoleDashboard rd : values()) {
            if (rd.getRole().equals(role)) return rd.getUrl();
        }
        return "/"; // default fallback
    }
}