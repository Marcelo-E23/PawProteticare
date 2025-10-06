package br.com.pawproteticare.api.model.repository;

import br.com.pawproteticare.api.model.entity.AnimadotadoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface IAnimadotado extends JpaRepository<AnimadotadoEntity, Long> {
}
