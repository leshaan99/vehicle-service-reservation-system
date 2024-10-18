package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/", "/login", "/error").permitAll() // Allow public access to these paths
                        .anyRequest().authenticated() // Require authentication for all other requests
                )
                .oauth2Login(oauth2 -> oauth2 // Configure OIDC login
                        .loginPage("/login") // Optional: customize login page
                        .defaultSuccessUrl("/") // Redirect to home page after login
                        .failureUrl("/login?error=true") // Redirect to login page on failure
                );

        return http.build();
    }
}
