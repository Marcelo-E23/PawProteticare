package br.com.pawproteticare.api.controller;

import br.com.pawproteticare.api.model.entity.ProteseEntity;
import br.com.pawproteticare.api.model.service.IProteseService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/protese")
@CrossOrigin(origins = "http://localhost:5173")
public class ProteseController {
    private final IProteseService proteseServiceImpl;


    public ProteseController(IProteseService proteseServiceImpl) {
        this.proteseServiceImpl = proteseServiceImpl;
    }

    //Listar Todos
    @GetMapping
    public ResponseEntity<List<ProteseEntity>> listarTodasProteses() {
        return ResponseEntity.ok(proteseServiceImpl.listarTodos());
    }

    //Buscar por Id
    @GetMapping("/{id}")
    public ResponseEntity<ProteseEntity> buscarProtesePorId(@PathVariable Long id){
        return proteseServiceImpl.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //Buscar por Tipo
    @GetMapping("/tipoProtese")
    public ResponseEntity<ProteseEntity> buscarProtesesPorTipo(@PathVariable String tipo){
        return proteseServiceImpl.buscarPorTipo(tipo)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    //Criar
    @PostMapping
    public ResponseEntity<ProteseEntity> criarProtese(@RequestBody ProteseEntity proteseCriada){
        return ResponseEntity.ok(proteseServiceImpl.salvar(proteseCriada));
    }

    //Atualizar
    @PutMapping("/{id}")
    public ResponseEntity<ProteseEntity> atualizar(@PathVariable Long id, @RequestBody ProteseEntity proteseEntity){
        try {
            return ResponseEntity.ok(proteseServiceImpl.atualizar(id, proteseEntity));
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletar(@PathVariable Long id){
        proteseServiceImpl.deletar(id);
        return ResponseEntity.noContent().build();
    }
}
