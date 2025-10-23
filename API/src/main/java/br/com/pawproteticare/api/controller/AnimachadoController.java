package br.com.pawproteticare.api.controller;

import br.com.pawproteticare.api.model.entity.AnimachadoEntity;
import br.com.pawproteticare.api.model.entity.ProteseEntity;
import br.com.pawproteticare.api.model.enums.StatusAnimal;
import br.com.pawproteticare.api.model.service.IAnimachadoService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/animachado")
@CrossOrigin(origins = "http://localhost:5173")
public class AnimachadoController {
    private final IAnimachadoService animachadoServiceImpl;

    public AnimachadoController(IAnimachadoService animachadoServiceImpl) {
        this.animachadoServiceImpl = animachadoServiceImpl;
    }

    @GetMapping
    public ResponseEntity<List<AnimachadoEntity>> listarTodos(){
        List<AnimachadoEntity> lista = animachadoServiceImpl.listarTodos();
        return ResponseEntity.ok().body(lista);
    }

    @GetMapping("/{id}")
    public ResponseEntity<AnimachadoEntity> buscarPorId(@PathVariable Long id){
        return animachadoServiceImpl.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/status")
    public ResponseEntity<AnimachadoEntity> buscarStatus(@PathVariable StatusAnimal status){
        return animachadoServiceImpl.buscarPorStatus(status)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());

    }

    @GetMapping("/nome")
    public ResponseEntity<AnimachadoEntity> buscarPorNome(@PathVariable String nome){
        return animachadoServiceImpl.buscarPorNome(nome)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping(consumes = "multipart/form-data")
    @Transactional
    public ResponseEntity<AnimachadoEntity> salvar(
            @RequestParam("imagem") MultipartFile imagem,
            @RequestParam Map<String, String> allParams) throws IOException {

        ObjectMapper objectMapper = new ObjectMapper();
        AnimachadoEntity animachado;

        if (!allParams.containsKey("proteseId")) {
            animachado = objectMapper.convertValue(allParams, AnimachadoEntity.class);
        } else {
            Long proteseId = Long.parseLong(allParams.get("proteseId"));
            allParams.remove("proteseId");
            animachado = objectMapper.convertValue(allParams, AnimachadoEntity.class);

            ProteseEntity proteseEntity = new ProteseEntity();
            proteseEntity.setId(proteseId);
            animachado.setProteseEntity(proteseEntity);
        }

        // Agora seta a imagem por último
        if (imagem != null && !imagem.isEmpty()) {
            animachado.setImagem(imagem.getBytes());
        }

        return ResponseEntity.ok(animachadoServiceImpl.salvar(animachado));

        // No react consumir
        // <img src={`data:image/png;base64,${animachado.imagem}`} alt="imagem" />
    }


    @PutMapping("/{id}")
    public ResponseEntity<AnimachadoEntity> atualizar(@PathVariable Long id, @RequestBody AnimachadoEntity animachadoEntity){
        try {
            return ResponseEntity.ok(animachadoServiceImpl.atualizar(id, animachadoEntity));
        } catch (Exception e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/id")
    public ResponseEntity<Void> remover(@PathVariable Long id){
        animachadoServiceImpl.deletar(id);
        return ResponseEntity.noContent().build();
    }
}
