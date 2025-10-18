package br.com.pawproteticare.api.controller;

import br.com.pawproteticare.api.model.entity.DoacaoEntity;
import br.com.pawproteticare.api.model.service.IDoacaoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/doacao")
@CrossOrigin(origins = "http://localhost:5173")
public class DoacaoController {

    private final IDoacaoService doacaoServiceImpl;

    public DoacaoController(IDoacaoService doacaoServiceImpl) {
        this.doacaoServiceImpl = doacaoServiceImpl;
    }

    @GetMapping
    public ResponseEntity<List<DoacaoEntity>> listarTodos(){
        return ResponseEntity.ok(doacaoServiceImpl.listarTodos());
    }

    @GetMapping("/{id}")
    public ResponseEntity<DoacaoEntity> buscaById(@PathVariable Long id){
        return doacaoServiceImpl.listarDoacaoPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public ResponseEntity<DoacaoEntity> salvarDoacao(@RequestBody DoacaoEntity doacaoEntity){
        return ResponseEntity.ok(doacaoServiceImpl.salvarDoacao(doacaoEntity));
    }
}
