package br.com.pawproteticare.api.model.repository;


import br.com.pawproteticare.api.model.entity.Admin;
import br.com.pawproteticare.api.model.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface IAdmin extends JpaRepository<Admin, Long> {
    Optional<UsuarioEntity> findByEmail(String email);
}
