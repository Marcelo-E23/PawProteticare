package com.br.pawproteticare.apipawproteticare.model.service;

import java.util.List;
import java.util.Optional;

import com.br.pawproteticare.apipawproteticare.model.entity.Protese;

public interface ProteseService {
    List<Protese> listarTodos();

    Optional<Protese> buscarPorId(Long id);

    Protese salvar(Protese protese);

    Protese atualizar(Long id, Protese proteseAtualizada);

    void deletar(Long id);

    Optional<Protese> buscarPorTipo(String tipo);
}
