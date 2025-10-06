package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.Proprietario;
import br.com.pawproteticare.api.model.entity.SolicitacaoAdocaoEntity;
import org.springframework.data.repository.query.Param;

import java.util.List;


public interface IProprietarioService {

    List<SolicitacaoAdocaoEntity> findAllSolicitacaoByProprietarioId(@Param("proprietarioId") Long proprietarioId);


}
