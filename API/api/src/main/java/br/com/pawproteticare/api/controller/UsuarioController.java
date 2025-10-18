package br.com.pawproteticare.api.controller;

import br.com.pawproteticare.api.model.entity.UsuarioEntity;
import br.com.pawproteticare.api.model.service.IUsuarioService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/usuario")
@CrossOrigin(origins = "http://localhost:5173")
public class UsuarioController {
    private final IUsuarioService usuarioServiceImpl;


    public UsuarioController(IUsuarioService usuarioServiceImpl) {
        this.usuarioServiceImpl = usuarioServiceImpl;
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
    @PostMapping
    public ResponseEntity<UsuarioEntity> salvar(@RequestBody UsuarioEntity usuarioEntity){
        return ResponseEntity.ok(usuarioServiceImpl.salvar(usuarioEntity));
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
