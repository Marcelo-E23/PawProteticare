package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.ProteseEntity;
import br.com.pawproteticare.api.model.repository.IProtese;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProteseServiceImpl implements IProteseService {
    private final IProtese proteseRepository;

    @Autowired
    public ProteseServiceImpl(IProtese proteseRepository) {
        this.proteseRepository = proteseRepository;
    }

    @Override
    public List<ProteseEntity> listarTodos() {
        return proteseRepository.findAll();
    }

    @Override
    public Optional<ProteseEntity> buscarPorId(Long id) {
        return proteseRepository.findById(id);
    }

    @Override
    public ProteseEntity salvar(ProteseEntity proteseEntity) {
        return proteseRepository.save(proteseEntity);
    }

    @Override
    public ProteseEntity atualizar(Long id, ProteseEntity proteseEntity) {
        return proteseRepository.findById(id).map(protese -> {
            protese.setTipo(proteseEntity.getTipo());
            protese.setNome(proteseEntity.getNome());
            protese.setCusto(proteseEntity.getCusto());
            protese.setFabricante(proteseEntity.getFabricante());
            return proteseRepository.save(protese);
        }).orElseThrow(() -> new RuntimeException("Prótese não encontrada"));
    }

    @Override
    public void deletar(Long id) {
        proteseRepository.deleteById(id);
    }

    @Override
    public Optional<ProteseEntity> buscarPorTipo(String tipo) {
        return proteseRepository.findByTipo(tipo);
    }
}
