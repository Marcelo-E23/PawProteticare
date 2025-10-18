package br.com.pawproteticare.api.model.repository;

import br.com.pawproteticare.api.model.entity.ProteseEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IProtese extends JpaRepository<ProteseEntity, Long> {
    Optional<ProteseEntity> findByTipo(String tipo);
}
