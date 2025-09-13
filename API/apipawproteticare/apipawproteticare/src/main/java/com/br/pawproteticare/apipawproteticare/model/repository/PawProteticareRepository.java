package com.br.pawproteticare.apipawproteticare.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.br.pawproteticare.apipawproteticare.model.entity.PawProteticare;

@Repository
public interface PawProteticareRepository extends JpaRepository<PawProteticare, Long>{
    
}
