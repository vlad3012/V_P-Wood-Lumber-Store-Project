package com.example.lumberstore.security;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class LoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws ServletException, IOException {

        boolean isAdminRole = authentication.getAuthorities().stream()
                .anyMatch(role -> role.getAuthority().equalsIgnoreCase("ROLE_ADMIN"));

        if (isAdminRole) {
            response.sendRedirect("/order/all");
        } else {
            response.sendRedirect("/main");
        }
    }
}
