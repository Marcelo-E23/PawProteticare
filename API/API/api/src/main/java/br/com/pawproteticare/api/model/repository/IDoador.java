package br.com.pawproteticare.api.model.repository;

import br.com.pawproteticare.api.model.entity.Doador;
import br.com.pawproteticare.api.model.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IDoador extends JpaRepository<Doador, Long> {
    Optional<UsuarioEntity> findByEmail(String email);
}
