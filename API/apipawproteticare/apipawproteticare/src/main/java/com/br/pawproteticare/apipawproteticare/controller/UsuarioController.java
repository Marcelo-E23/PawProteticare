package com.br.pawproteticare.apipawproteticare.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.br.pawproteticare.apipawproteticare.model.entity.Usuario;
import com.br.pawproteticare.apipawproteticare.model.service.UsuarioService;

@RestController
@RequestMapping("/api/usuarios")
@CrossOrigin(origins = "http://localhost:5173")
public class UsuarioController {

    private final UsuarioService usuarioService;

    @Autowired
    public UsuarioController(UsuarioService usuarioService) {
        this.usuarioService = usuarioService;
    }

    // Listar todos
    @GetMapping
    public ResponseEntity<List<Usuario>> listarTodos() {
        return ResponseEntity.ok(usuarioService.listarTodos());
    }

    // Buscar por ID
    @GetMapping("/{id}")
    public ResponseEntity<Usuario> buscarPorId(@PathVariable Long id) {
        return usuarioService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Buscar por email
    @GetMapping("/email/{email}")
    public ResponseEntity<Usuario> buscarPorEmail(@PathVariable String email) {
        return usuarioService.buscarPorEmail(email)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Criar novo usuário
    @PostMapping
    public ResponseEntity<Usuario> salvar(@RequestBody Usuario usuario) {
        return ResponseEntity.ok(usuarioService.salvar(usuario));
    }

    // Atualizar usuário existente
    @PutMapping("update/{id}")
    public ResponseEntity<Usuario> atualizar(@PathVariable Long id, @RequestBody Usuario usuario) {
        try {
            return ResponseEntity.ok(usuarioService.atualizar(id, usuario));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Deletar usuário
    @DeleteMapping("delete/{id}")
    public ResponseEntity<Void> deletar(@PathVariable Long id) {
        usuarioService.deletar(id);
        return ResponseEntity.noContent().build();
    }

}
