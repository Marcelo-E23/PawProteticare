package br.com.pawproteticare.api.controller;

import br.com.pawproteticare.api.model.entity.AnimadotadoEntity;
import br.com.pawproteticare.api.model.service.IAnimadotadoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/animadotado")
@CrossOrigin(origins = "http://localhost:5173")
public class AnimadotadoController {
    private final IAnimadotadoService animadotadoServiceImpl;

    public AnimadotadoController(IAnimadotadoService animadotadoServiceImpl) {
        this.animadotadoServiceImpl = animadotadoServiceImpl;
    }

    @GetMapping
    public ResponseEntity<List<AnimadotadoEntity>> listarTodos(){
        return ResponseEntity.ok(animadotadoServiceImpl.listarTodos());
    }

    @GetMapping("/{id}")
    public ResponseEntity<AnimadotadoEntity> buscarPorId(@PathVariable Long id){
        return animadotadoServiceImpl.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
