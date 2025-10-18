package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.DoacaoEntity;

import java.util.List;
import java.util.Optional;

public interface IDoacaoService {
    List<DoacaoEntity> listarTodos();

    Optional<DoacaoEntity> listarDoacaoPorId(Long id);

    DoacaoEntity salvarDoacao(DoacaoEntity doacaoEntity);
}
