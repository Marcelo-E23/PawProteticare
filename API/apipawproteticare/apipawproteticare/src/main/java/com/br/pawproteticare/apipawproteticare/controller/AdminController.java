package com.br.pawproteticare.apipawproteticare.controller;

import com.br.pawproteticare.apipawproteticare.model.entity.Admin;
import com.br.pawproteticare.apipawproteticare.model.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/admins")
@CrossOrigin(origins = "http://localhost:5173")
public class AdminController {

    @Autowired
    private AdminService adminService;

    // Listar todos os administradores
    @GetMapping
    public ResponseEntity<List<Admin>> listarTodos() {
        return ResponseEntity.ok(adminService.listarTodos());
    }

    // Buscar administrador por ID
    @GetMapping("/{id}")
    public ResponseEntity<Admin> buscarPorId(@PathVariable Long id) {
        return adminService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Buscar administrador por login
    @GetMapping("/login/{login}")
    public ResponseEntity<Admin> buscarPorLogin(@PathVariable String login) {
        return adminService.buscarPorLogin(login)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Criar novo administrador
    @PostMapping
    public ResponseEntity<Admin> salvar(@RequestBody Admin admin) {
        Admin novoAdmin = adminService.salvar(admin);
        return ResponseEntity.ok(novoAdmin);
    }

    // Atualizar administrador existente
    @PutMapping("/{id}")
    public ResponseEntity<Admin> atualizar(@PathVariable Long id, @RequestBody Admin adminAtualizado) {
        Admin admin = adminService.atualizar(id, adminAtualizado);
        return ResponseEntity.ok(admin);
    }

    // Deletar administrador
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable Long id) {
        adminService.deletar(id);
        return ResponseEntity.noContent().build();
    }
}
