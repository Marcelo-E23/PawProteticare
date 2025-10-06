package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.SolicitacaoAdocaoEntity;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface ISolicitacaoAdocaoService {

    List<SolicitacaoAdocaoEntity> listarTodos();

    Optional<SolicitacaoAdocaoEntity> buscarPorId(Long id);

    SolicitacaoAdocaoEntity salvar(SolicitacaoAdocaoEntity solicitacaoAdocaoEntity);

    SolicitacaoAdocaoEntity atualizar(Long id, SolicitacaoAdocaoEntity solicitacaoAdocaoEntity);

    void deletar(Long id);



}
