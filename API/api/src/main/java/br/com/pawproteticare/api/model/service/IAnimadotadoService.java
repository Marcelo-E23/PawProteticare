package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.AnimadotadoEntity;

import java.util.List;
import java.util.Optional;

public interface IAnimadotadoService {
    List<AnimadotadoEntity> listarTodos();
    Optional<AnimadotadoEntity> buscarPorId(Long id);
}
