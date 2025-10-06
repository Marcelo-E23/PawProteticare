package br.com.pawproteticare.api.config;

import br.com.pawproteticare.api.exception.security.CustomAccessDeniedHandler;
import br.com.pawproteticare.api.exception.security.CustomAuthenticationEntryPoint;
import br.com.pawproteticare.api.jwt.JwtAuthenticationFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.authentication.logout.LogoutHandler;

import static br.com.pawproteticare.api.model.enums.Permission.*;
import static org.springframework.http.HttpMethod.*;
import static org.springframework.security.config.http.SessionCreationPolicy.STATELESS;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfiguration {

	private static final String[] WHITE_LIST_URL = {
			"/index",
			"/images/**",
			"/v2/api-docs",
			"/v3/api-docs",
			"/v3/api-docs/**",
			"/swagger-resources",
			"/swagger-resources/**",
			"/configuration/ui",
			"/configuration/security",
			"/swagger-ui/**",
			"/webjars/**",
			"/swagger-ui.html"};

	private final JwtAuthenticationFilter jwtAuthFilter;
	private final AuthenticationProvider authenticationProvider;
	private final LogoutHandler logoutHandler;
	private final CustomAuthenticationEntryPoint customAuthenticationEntryPoint;
	private final CustomAccessDeniedHandler customAccessDeniedHandler;

	public SecurityConfiguration(JwtAuthenticationFilter jwtAuthFilter,
								 AuthenticationProvider authenticationProvider,
								 LogoutHandler logoutHandler,
								 CustomAuthenticationEntryPoint customAuthenticationEntryPoint,
								 CustomAccessDeniedHandler customAccessDeniedHandler) {
		this.jwtAuthFilter = jwtAuthFilter;
		this.authenticationProvider = authenticationProvider;
		this.logoutHandler = logoutHandler;
		this.customAuthenticationEntryPoint = customAuthenticationEntryPoint;
		this.customAccessDeniedHandler = customAccessDeniedHandler;
	}

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
				.csrf(AbstractHttpConfigurer::disable)
				.authorizeHttpRequests(req ->
						    req
								.requestMatchers(GET, "/solicitacao-adocao/**").hasAnyAuthority(ADMIN_READ.name())
								.requestMatchers(PUT, "/solicitacao-adocao/**").hasAnyAuthority(PROPRIETARIO_UPDATE.name())
								.requestMatchers(DELETE, "/solicitacao-adocao/**").hasAnyAuthority(PROPRIETARIO_DELETE.name())
								.requestMatchers(POST, "/solicitacao-adocao/**").hasAnyAuthority(PROPRIETARIO_CREATE.name())

								.requestMatchers(GET, "/proprietario/**").hasAnyAuthority(PROPRIETARIO_READ.name())
								.requestMatchers(PUT, "/proprietario/**").hasAnyAuthority(PROPRIETARIO_UPDATE.name())
								.requestMatchers(DELETE, "/proprietario/**").hasAnyAuthority(PROPRIETARIO_DELETE.name())
								.requestMatchers(POST, "/proprietario/**").permitAll()
								//.requestMatchers("/api/v1/cliente").hasAnyRole(CLIENTE.name())
								//.requestMatchers("/api/v1/cliente/**").hasAnyRole(CLIENTE.name())

								.requestMatchers(POST,"/protese/**").hasAnyAuthority(ADMIN_CREATE.name())
								.requestMatchers(PUT,"/protese/**").hasAnyAuthority(ADMIN_UPDATE.name())
								.requestMatchers(GET,"/protese/**").hasAnyAuthority(ADMIN_READ.name())
								.requestMatchers(DELETE,"/protese/**").hasAnyAuthority(ADMIN_DELETE.name())

								.requestMatchers(POST,"/animachado/**").hasAnyAuthority(ADMIN_CREATE.name())
								.requestMatchers(PUT,"/animachado/**").hasAnyAuthority(ADMIN_UPDATE.name())
								.requestMatchers(GET,"/animachado/**").hasAnyAuthority(ADMIN_READ.name())
								.requestMatchers(DELETE,"/animachado/**").hasAnyAuthority(ADMIN_DELETE.name())

								.requestMatchers(PUT,"/animadotado/**").hasAnyAuthority(ADMIN_UPDATE.name())
								.requestMatchers(GET,"/animadotado/**").hasAnyAuthority(ADMIN_READ.name())
								.requestMatchers(DELETE,"/animadotado/**").hasAnyAuthority(ADMIN_DELETE.name())
								.requestMatchers(POST,"/animadotado/**").permitAll()

								.requestMatchers(PUT,"/admin/**").hasAnyAuthority(ADMIN_UPDATE.name())
								.requestMatchers(GET,"/admin/**").hasAnyAuthority(ADMIN_READ.name())
								.requestMatchers(DELETE,"/admin/**").hasAnyAuthority(ADMIN_DELETE.name())
								.requestMatchers(POST,"/admin/**").permitAll()

								.requestMatchers(POST,"/doacao/**").hasAnyAuthority(DOADOR_CREATE.name())
								.requestMatchers(PUT,"/doacao/**").hasAnyAuthority(DOADOR_UPDATE.name())
								.requestMatchers(GET,"/doacao/**").hasAnyAuthority(DOADOR_READ.name())
								.requestMatchers(DELETE,"/doacao/**").hasAnyAuthority(DOADOR_DELETE.name())

								.requestMatchers(PUT,"/doador/**").hasAnyAuthority(DOADOR_UPDATE.name())
								.requestMatchers(GET,"/doador/**").hasAnyAuthority(DOADOR_READ.name())
								.requestMatchers(DELETE,"/doador/**").hasAnyAuthority(DOADOR_DELETE.name())
								.requestMatchers(POST,"/doador/**").permitAll()

								.requestMatchers("/usuario").permitAll()
								.requestMatchers("/auth/authenticate").permitAll()
								.requestMatchers(WHITE_LIST_URL)
								.permitAll()
								.anyRequest()
								.authenticated()
				)
				.exceptionHandling(exception -> exception
						.authenticationEntryPoint(customAuthenticationEntryPoint)
						.accessDeniedHandler(customAccessDeniedHandler)
				)
				.sessionManagement(session -> session.sessionCreationPolicy(STATELESS))
				.authenticationProvider(authenticationProvider)
				.addFilterBefore(jwtAuthFilter, UsernamePasswordAuthenticationFilter.class)
				.logout(logout ->
						logout.logoutUrl("/auth/logout")
								.addLogoutHandler(logoutHandler)
								.logoutSuccessHandler((request, response, authentication) -> SecurityContextHolder.clearContext())
				);

		return http.build();
	}
}
