package com.br.pawproteticare.apipawproteticare.model.service;

import java.util.List;
import java.util.Optional;

import com.br.pawproteticare.apipawproteticare.model.entity.Animal;

public interface AnimalService {

    List<Animal> listarTodos();

    Optional<Animal> buscarPorId(Long id);

    Animal salvar(Animal animal);

    Animal atualizar(Long id, Animal animalAtualizado);

    void deletar(Long id);

    List<Animal> buscarPorStatus(String status);

    List<Animal> buscarPorNome(String nome);
    
}
