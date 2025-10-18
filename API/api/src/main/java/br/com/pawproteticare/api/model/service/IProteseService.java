package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.ProteseEntity;

import java.util.List;
import java.util.Optional;

public interface IProteseService {
    List<ProteseEntity> listarTodos();

    Optional<ProteseEntity> buscarPorId(Long id);

    ProteseEntity salvar(ProteseEntity proteseEntity);

    ProteseEntity atualizar(Long id, ProteseEntity proteseEntity);

    void deletar(Long id);

    Optional<ProteseEntity> buscarPorTipo(String tipo);
}
