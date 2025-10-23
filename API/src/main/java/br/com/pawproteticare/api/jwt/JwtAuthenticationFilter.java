package br.com.pawproteticare.api.jwt;

import br.com.pawproteticare.api.model.entity.UsuarioEntity;
import br.com.pawproteticare.api.token.TokenRepository;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

	private final JwtService jwtService;
	private final UserDetailsService userDetailsService;
	private final TokenRepository tokenRepository;

	public JwtAuthenticationFilter(JwtService jwtService, UserDetailsService userDetailsService, TokenRepository tokenRepository) {
		this.jwtService = jwtService;
		this.userDetailsService = userDetailsService;
		this.tokenRepository = tokenRepository;
	}

	@Override
	protected void doFilterInternal(
			@NonNull HttpServletRequest request,
			@NonNull HttpServletResponse response,
			@NonNull FilterChain filterChain
	) throws ServletException, IOException {

		final String authHeader = request.getHeader("Authorization");
		final String token;
		final String userEmail;

		if (authHeader == null || !authHeader.startsWith("Bearer ")) {
			System.out.println("Authorization header ausente ou mal formatado.");
			filterChain.doFilter(request, response);
			return;
		}

		token = authHeader.substring(7);
		userEmail = jwtService.extractUsername(token);
		System.out.println("Token recebido: " + token);
		System.out.println("Email extraído do token: " + userEmail);

		if (userEmail != null && SecurityContextHolder.getContext().getAuthentication() == null) {
			UsuarioEntity userDetails = (UsuarioEntity) this.userDetailsService.loadUserByUsername(userEmail);
			System.out.println("Usuário carregado: " + userDetails.getEmail());

			var isTokenValid = tokenRepository.findByToken(token)
					.map(t -> !t.isExpired() && !t.isRevoked())
					.orElse(false);

			System.out.println("Token válido no banco? " + isTokenValid);
			System.out.println("Token válido pelo JWT? " + jwtService.isTokenValid(token, userDetails));

			if (jwtService.isTokenValid(token, userDetails) && isTokenValid) {
				UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
						userDetails,
						null,
						userDetails.getAuthorities()
				);
				authToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
				SecurityContextHolder.getContext().setAuthentication(authToken);
				System.out.println("Autenticação registrada no contexto de segurança.");
			} else {
				System.out.println("Token inválido ou revogado.");
			}
		} else {
			System.out.println("Email nulo ou usuário já autenticado.");
		}

		filterChain.doFilter(request, response);
	}
}
