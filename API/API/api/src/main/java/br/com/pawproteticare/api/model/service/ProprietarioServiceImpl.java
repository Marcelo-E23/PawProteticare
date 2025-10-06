package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.Doador;
import br.com.pawproteticare.api.model.entity.SolicitacaoAdocaoEntity;
import br.com.pawproteticare.api.model.entity.UsuarioEntity;
import br.com.pawproteticare.api.model.enums.Role;
import br.com.pawproteticare.api.model.repository.IDoador;
import br.com.pawproteticare.api.model.repository.IProprietario;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class ProprietarioServiceImpl implements IProprietarioService {

    private final IProprietario iProprietario;

    public ProprietarioServiceImpl(IProprietario iProprietario) {
        this.iProprietario = iProprietario;
    }

    @Override
    public List<SolicitacaoAdocaoEntity> findAllSolicitacaoByProprietarioId(Long proprietarioId) {

        UsuarioEntity proprietario = iProprietario.findById(proprietarioId).get();
        List<SolicitacaoAdocaoEntity> solicitacaoAdocaoEntities = iProprietario.findAllSolicitacaoByProprietarioId(proprietario.getId());
        return solicitacaoAdocaoEntities;
    }
}
