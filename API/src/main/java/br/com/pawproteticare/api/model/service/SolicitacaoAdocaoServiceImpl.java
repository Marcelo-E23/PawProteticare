package br.com.pawproteticare.api.model.service;


import br.com.pawproteticare.api.model.entity.SolicitacaoAdocaoEntity;
import br.com.pawproteticare.api.model.repository.ISolicitacaoAdocao;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SolicitacaoAdocaoServiceImpl implements ISolicitacaoAdocaoService {

    private final ISolicitacaoAdocao solicitacaoAdocaoRepository;

    public SolicitacaoAdocaoServiceImpl(ISolicitacaoAdocao solicitacaoAdocaoRepository) {
        this.solicitacaoAdocaoRepository = solicitacaoAdocaoRepository;
    }

    @Override
    public List<SolicitacaoAdocaoEntity> listarTodos() {
        return solicitacaoAdocaoRepository.findAll();
    }

    @Override
    public Optional<SolicitacaoAdocaoEntity> buscarPorId(Long id) {
        return solicitacaoAdocaoRepository.findById(id);
    }

    @Override
    public SolicitacaoAdocaoEntity salvar(SolicitacaoAdocaoEntity solicitacaoAdocaoEntity) {
        return solicitacaoAdocaoRepository.save(solicitacaoAdocaoEntity);
    }

    @Override
    public SolicitacaoAdocaoEntity atualizar(Long id, SolicitacaoAdocaoEntity solicitacaoAdocaoEntity) {
        return null;
    }

    @Override
    public void deletar(Long id) {
        solicitacaoAdocaoRepository.deleteById(id);
    }

}
