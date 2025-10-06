package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.DoacaoEntity;
import br.com.pawproteticare.api.model.repository.IDoacao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DoacaoServiceImpl implements IDoacaoService{
    private final IDoacao doacaoRepository;

    @Autowired
    public DoacaoServiceImpl(IDoacao doacaoRepository) {
        this.doacaoRepository = doacaoRepository;
    }

    @Override
    public List<DoacaoEntity> listarTodos() {
        return doacaoRepository.findAll();
    }

    @Override
    public Optional<DoacaoEntity> listarDoacaoPorId(Long id) {
        return doacaoRepository.findById(id);
    }

    @Override
    public DoacaoEntity salvarDoacao(DoacaoEntity doacaoEntity) {
        return doacaoRepository.save(doacaoEntity);
    }
}
