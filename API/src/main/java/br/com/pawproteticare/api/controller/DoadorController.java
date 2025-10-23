package br.com.pawproteticare.api.controller;

import br.com.pawproteticare.api.auth.AuthenticationResponse;
import br.com.pawproteticare.api.auth.AuthenticationService;
import br.com.pawproteticare.api.auth.RegisterRequest;
import br.com.pawproteticare.api.model.entity.UsuarioEntity;
import br.com.pawproteticare.api.model.enums.Role;
import br.com.pawproteticare.api.model.service.IUsuarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/doador")
@CrossOrigin(origins = "http://localhost:5173")
public class DoadorController {
    private final IUsuarioService usuarioServiceImpl;
    private final AuthenticationService authenticationService;

    public DoadorController(IUsuarioService usuarioServiceImpl, AuthenticationService authenticationService) {
        this.usuarioServiceImpl = usuarioServiceImpl;
        this.authenticationService = authenticationService;
    }

    // Salvar Doador
    @PostMapping
    public ResponseEntity<AuthenticationResponse> registerProprietario(@RequestBody RegisterRequest request){
        request.setRole(Role.DOADOR);
        return ResponseEntity.ok(authenticationService.register(request));

    }

    //Listar Todos
    @GetMapping
    public ResponseEntity<List<UsuarioEntity>> listarTodos(){
        return ResponseEntity.ok(usuarioServiceImpl.listarTodos());
    }

    //Buscar por Id
    @GetMapping("/{id}")
    public ResponseEntity<UsuarioEntity> buscarPorId(@PathVariable Long id){
        return usuarioServiceImpl.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //Buscar por email
    @GetMapping("/email")
    public ResponseEntity<UsuarioEntity> buscarPorEmail(@PathVariable String Email){
        return usuarioServiceImpl.buscarPorEmail(Email)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }



    //Atualizar Usuario
    @PutMapping("/{id}")
    public ResponseEntity<UsuarioEntity> atualizar(@PathVariable Long id, @RequestBody UsuarioEntity usuarioEntity){
        try {
            return ResponseEntity.ok(usuarioServiceImpl.atualizar(id, usuarioEntity));
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    //Deletar
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> remover(@PathVariable Long id){
        usuarioServiceImpl.deletar(id);
        return ResponseEntity.noContent().build();
    }
}
