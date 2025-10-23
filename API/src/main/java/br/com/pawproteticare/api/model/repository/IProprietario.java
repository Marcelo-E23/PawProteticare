package br.com.pawproteticare.api.model.repository;


import br.com.pawproteticare.api.model.entity.Proprietario;
import br.com.pawproteticare.api.model.entity.SolicitacaoAdocaoEntity;
import br.com.pawproteticare.api.model.entity.UsuarioEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface IProprietario extends JpaRepository<Proprietario, Long> {
    Optional<UsuarioEntity> findByEmail(String email);

    @Query("SELECT s FROM SolicitacaoAdocaoEntity s JOIN FETCH s.proprietario p WHERE p.id = :id")
    List<SolicitacaoAdocaoEntity> findAllSolicitacaoByProprietarioId(@Param("id") Long id);

}
