package com.br.pawproteticare.apipawproteticare.model.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.br.pawproteticare.apipawproteticare.model.entity.Protese;
import com.br.pawproteticare.apipawproteticare.model.repository.ProteseRepository;

@Service
public class ProteseServiceImpl implements ProteseService{
    private final ProteseRepository proteseRepository;

    @Autowired
    public ProteseServiceImpl(ProteseRepository proteseRepository) {
        this.proteseRepository = proteseRepository;
    }

    @Override
    public List<Protese> listarTodos() {
        return proteseRepository.findAll();
    }

    @Override
    public Optional<Protese> buscarPorId(Long id) {
        return proteseRepository.findById(id);
    }

    @Override
    public Protese salvar(Protese protese) {
        return proteseRepository.save(protese);
    }

    @Override
    public Protese atualizar(Long id, Protese proteseAtualizada) {
        return proteseRepository.findById(id).map(protese -> {
            protese.setTipo(proteseAtualizada.getTipo());
            protese.setCusto(proteseAtualizada.getCusto());
            protese.setFabricante(proteseAtualizada.getFabricante());
            return proteseRepository.save(protese);
        }).orElseThrow(() -> new RuntimeException("Prótese não encontrada"));
    }

    @Override
    public void deletar(Long id) {
        proteseRepository.deleteById(id);
    }

    @Override
    public Optional<Protese> buscarPorTipo(String tipo) {
        return proteseRepository.findByTipo(tipo);
    }
}
