package br.com.pawproteticare.api.controller;


import br.com.pawproteticare.api.dto.SolicitacaoAdocaoRequest;
import br.com.pawproteticare.api.model.entity.AnimachadoEntity;
import br.com.pawproteticare.api.model.entity.Proprietario;
import br.com.pawproteticare.api.model.entity.SolicitacaoAdocaoEntity;
import br.com.pawproteticare.api.model.enums.Role;
import br.com.pawproteticare.api.model.service.ISolicitacaoAdocaoService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/solicitacao-adocao")
public class SolicitacaoAdocaoController {

    private final ISolicitacaoAdocaoService solicitacaoAdocaoService;

    public SolicitacaoAdocaoController(ISolicitacaoAdocaoService solicitacaoAdocaoService) {
        this.solicitacaoAdocaoService = solicitacaoAdocaoService;
    }

    @GetMapping
    public ResponseEntity<List<SolicitacaoAdocaoEntity>> listarTodas() {
        return ResponseEntity.ok(solicitacaoAdocaoService.listarTodos());
    }

    @PostMapping
    public ResponseEntity<SolicitacaoAdocaoEntity> salvarSolicitacao(@RequestBody SolicitacaoAdocaoRequest solicitacaoAdocaoRequest) {
       SolicitacaoAdocaoEntity solicitacaoAdocaoEntity = new SolicitacaoAdocaoEntity();
       solicitacaoAdocaoEntity.setDataSolicitacao(solicitacaoAdocaoRequest.getDataSolicitacao());
       solicitacaoAdocaoEntity.setMotivacao(solicitacaoAdocaoRequest.getMotivacao());
       if(solicitacaoAdocaoRequest.getAnimachadoId() != null){
           AnimachadoEntity animachadoEntity = new AnimachadoEntity();
           animachadoEntity.setId(solicitacaoAdocaoRequest.getAnimachadoId());
           solicitacaoAdocaoEntity.setAnimachado(animachadoEntity);
       }
       if(solicitacaoAdocaoRequest.getProprietarioId()!= null){
           Proprietario proprietario = new Proprietario();
           proprietario.setRole(Role.PROPRIETARIO);
           proprietario.setId(solicitacaoAdocaoRequest.getProprietarioId());
           solicitacaoAdocaoEntity.setProprietario(proprietario);
       }
        return ResponseEntity.status(HttpStatus.CREATED).body(solicitacaoAdocaoService.salvar(solicitacaoAdocaoEntity));

    }
}
