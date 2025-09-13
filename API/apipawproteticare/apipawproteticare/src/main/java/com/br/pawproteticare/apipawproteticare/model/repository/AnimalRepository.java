package com.br.pawproteticare.apipawproteticare.model.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.br.pawproteticare.apipawproteticare.model.entity.Animal;

@Repository
public interface AnimalRepository extends JpaRepository<Animal, Long> {

    List<Animal> findByStatus(String status);

    List<Animal> findByNomeContainingIgnoreCase(String nome);
    
}
