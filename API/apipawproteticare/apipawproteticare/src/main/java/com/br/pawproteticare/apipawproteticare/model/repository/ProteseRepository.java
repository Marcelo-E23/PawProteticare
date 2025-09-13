package com.br.pawproteticare.apipawproteticare.model.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.br.pawproteticare.apipawproteticare.model.entity.Protese;
import java.util.Optional;

@Repository
public interface ProteseRepository extends JpaRepository<Protese, Long> {

    Optional<Protese> findByTipo(String tipo);
    
}
