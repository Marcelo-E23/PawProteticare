package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.AnimachadoEntity;

import br.com.pawproteticare.api.model.enums.StatusAnimal;

import java.util.Base64;
import java.util.List;
import java.util.Optional;

public interface IAnimachadoService {

    List<AnimachadoEntity> listarTodos();

    Optional<AnimachadoEntity> buscarPorId(Long id);

    AnimachadoEntity salvar(AnimachadoEntity animal);

    AnimachadoEntity atualizar(Long id, AnimachadoEntity animalAtualizado);

    void deletar(Long id);

    Optional<AnimachadoEntity> buscarPorStatus(StatusAnimal status);

    Optional<AnimachadoEntity> buscarPorNome(String nome);

    Optional<AnimachadoEntity> findByNomeContainingIgnoreCase(String nome);
}
