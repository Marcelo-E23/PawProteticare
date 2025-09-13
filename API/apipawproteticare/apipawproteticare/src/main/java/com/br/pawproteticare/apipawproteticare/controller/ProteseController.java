package com.br.pawproteticare.apipawproteticare.controller;

import com.br.pawproteticare.apipawproteticare.model.entity.Protese;
import com.br.pawproteticare.apipawproteticare.model.service.ProteseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/proteses")
@CrossOrigin(origins = "http://localhost:5173")
public class ProteseController {

    @Autowired
    private ProteseService proteseService;

    //  Listar todas as próteses
    @GetMapping
    public ResponseEntity<List<Protese>> listarTodos() {
        return ResponseEntity.ok(proteseService.listarTodos());
    }

    // Buscar prótese por ID
    @GetMapping("/{id}")
    public ResponseEntity<Protese> buscarPorId(@PathVariable Long id) {
        return proteseService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Buscar prótese por tipo
    @GetMapping("/tipo/{tipo}")
    public ResponseEntity<Protese> buscarPorTipo(@PathVariable String tipo) {
        return proteseService.buscarPorTipo(tipo)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // Criar nova prótese
    @PostMapping
    public ResponseEntity<Protese> salvar(@RequestBody Protese protese) {
        Protese novaProtese = proteseService.salvar(protese);
        return ResponseEntity.ok(novaProtese);
    }

    // Atualizar prótese existente
    @PutMapping("/{id}")
    public ResponseEntity<Protese> atualizar(@PathVariable Long id, @RequestBody Protese proteseAtualizada) {
        Protese protese = proteseService.atualizar(id, proteseAtualizada);
        return ResponseEntity.ok(protese);
    }

    // Deletar prótese
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable Long id) {
        proteseService.deletar(id);
        return ResponseEntity.noContent().build();
    }
}
