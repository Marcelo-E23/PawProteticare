package br.com.pawproteticare.api.controller;

import br.com.pawproteticare.api.auth.AuthenticationResponse;
import br.com.pawproteticare.api.auth.AuthenticationService;

import br.com.pawproteticare.api.auth.RegisterRequest;
import br.com.pawproteticare.api.model.enums.Role;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;



@RestController
@RequestMapping("/admin")
@CrossOrigin(origins = "http://localhost:5173")
public class AdminController {

    private final AuthenticationService authenticationService;

    public AdminController(AuthenticationService authenticationService) {
        this.authenticationService = authenticationService;
    }


    // Salvar Admin
    @PostMapping
    public ResponseEntity<AuthenticationResponse> registerProprietario(@RequestBody RegisterRequest request){
        request.setRole(Role.ADMIN);
        return ResponseEntity.ok(authenticationService.register(request));

    }

}
