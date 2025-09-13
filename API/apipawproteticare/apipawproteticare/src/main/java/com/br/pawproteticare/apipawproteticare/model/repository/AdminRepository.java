package com.br.pawproteticare.apipawproteticare.model.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.br.pawproteticare.apipawproteticare.model.entity.Admin;
import com.br.pawproteticare.apipawproteticare.model.entity.Animal;

//NÃO MEXE AQUI NATHAN
@Repository
public interface AdminRepository extends JpaRepository<Admin, Long> {
    Optional<Admin> findByLogin(String login);

    List<Animal> findByStatus(String status);

    List<Animal> findByEspecie(String especie);
    
}
