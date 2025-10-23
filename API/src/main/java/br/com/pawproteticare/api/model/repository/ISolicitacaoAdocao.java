package br.com.pawproteticare.api.model.repository;

import br.com.pawproteticare.api.model.entity.SolicitacaoAdocaoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface ISolicitacaoAdocao extends JpaRepository<SolicitacaoAdocaoEntity, Long> {

}
