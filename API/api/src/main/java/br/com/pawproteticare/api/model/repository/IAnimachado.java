package br.com.pawproteticare.api.model.repository;

import br.com.pawproteticare.api.model.entity.AnimachadoEntity;
import br.com.pawproteticare.api.model.enums.StatusAdocao;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IAnimachado extends JpaRepository<AnimachadoEntity, Long> {
    Optional<AnimachadoEntity> findById(Long id);

    void deleteById(Long Id);

    Optional<AnimachadoEntity> findByStatus(StatusAdocao status);

    Optional<AnimachadoEntity> findByNomeContainingIgnoreCase(String nome);
}
