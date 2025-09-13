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

import com.br.pawproteticare.apipawproteticare.model.entity.Animal;

import com.br.pawproteticare.apipawproteticare.model.service.AnimalServiceImpl;
@RestController
@RequestMapping("/api/animais")
@CrossOrigin(origins = "http://localhost:5173")
public class AnimalController {

    private final AnimalServiceImpl animalServiceImpl;

    @Autowired
    public AnimalController(AnimalServiceImpl animalServiceImpl) {
        this.animalServiceImpl = animalServiceImpl;
    }

    // Listar todos
    @GetMapping
    public ResponseEntity<List<Animal>> listarTodos() {
        return ResponseEntity.ok(animalServiceImpl.listarTodos());
    }

    // Buscar por ID
    @GetMapping("/{id}")
    public ResponseEntity<Animal> buscarPorId(@PathVariable Long id) {
        return animalServiceImpl.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Buscar por status
    @GetMapping("/status/{status}")
    public ResponseEntity<List<Animal>> buscarPorStatus(@PathVariable String status) {
        return ResponseEntity.ok(animalServiceImpl.buscarPorStatus(status));
    }

    // Buscar por nome (parcial, ignorando maiúsculas/minúsculas)
    @GetMapping("/nome/{nome}")
    public ResponseEntity<List<Animal>> buscarPorNome(@PathVariable String nome) {
        return ResponseEntity.ok(animalServiceImpl.buscarPorNome(nome));
    }

    // Criar novo
    @PostMapping
    public ResponseEntity<Animal> salvar(@RequestBody Animal animal) {
        return ResponseEntity.ok(animalServiceImpl.salvar(animal));
    }

    // Atualizar
    @PutMapping("update/{id}")
    public ResponseEntity<Animal> atualizar(@PathVariable Long id, @RequestBody Animal animal) {
        try {
            return ResponseEntity.ok(animalServiceImpl.atualizar(id, animal));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    // Deletar
    @DeleteMapping("delete/{id}")
    public ResponseEntity<Void> deletar(@PathVariable Long id) {
        animalServiceImpl.deletar(id);
        return ResponseEntity.noContent().build();
    }
}
