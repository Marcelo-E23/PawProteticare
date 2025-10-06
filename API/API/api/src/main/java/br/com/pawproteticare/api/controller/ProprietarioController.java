package br.com.pawproteticare.api.controller;

import br.com.pawproteticare.api.auth.AuthenticationResponse;
import br.com.pawproteticare.api.auth.AuthenticationService;
import br.com.pawproteticare.api.auth.RegisterRequest;
import br.com.pawproteticare.api.exception.Forbidden;
import br.com.pawproteticare.api.model.entity.SolicitacaoAdocaoEntity;
import br.com.pawproteticare.api.model.entity.UsuarioEntity;
import br.com.pawproteticare.api.model.enums.Role;
import br.com.pawproteticare.api.model.service.IProprietarioService;
import br.com.pawproteticare.api.model.service.IUsuarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/proprietario")
@CrossOrigin(origins = "http://localhost:5173")
public class ProprietarioController {
    private final IUsuarioService usuarioServiceImpl;
    private final AuthenticationService authenticationService;
    private final IProprietarioService proprietarioService;


    public ProprietarioController(IUsuarioService usuarioServiceImpl, AuthenticationService authenticationService, IProprietarioService proprietarioService) {
        this.usuarioServiceImpl = usuarioServiceImpl;
        this.authenticationService = authenticationService;
        this.proprietarioService = proprietarioService;
    }


    // Salvar Proprietario
    @PostMapping
    public ResponseEntity<AuthenticationResponse> registerProprietario(@RequestBody RegisterRequest request){
        request.setRole(Role.PROPRIETARIO);
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

    //Criar novo usuário


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


    @PreAuthorize("isAuthenticated() and T(java.lang.Long).parseLong(#id) == principal.id")
    @GetMapping("/{id}/solicitacao-adocao")
    public ResponseEntity <List<SolicitacaoAdocaoEntity>> findAllSolicitacoesByProprietarioId(@PathVariable Long id){

        // Recupera o id do usuário logado pra reforçar a validação (dupla segurança)
        UsuarioEntity usuarioLogado = (UsuarioEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (!usuarioLogado.getId().equals(id)) {
            throw new Forbidden("Você só pode acessar seus próprios pedidos.");
        }
        return ResponseEntity.ok().body(proprietarioService.findAllSolicitacaoByProprietarioId(id));
    }
}
