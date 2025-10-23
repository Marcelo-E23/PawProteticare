package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.AnimadotadoEntity;
import br.com.pawproteticare.api.model.repository.IAnimadotado;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class AnimadotadoServiceImpl implements IAnimadotadoService {
    private final IAnimadotado animadotadoRepository;

    public AnimadotadoServiceImpl(IAnimadotado animadotadoRepository) {
        this.animadotadoRepository = animadotadoRepository;
    }

    @Override
    public List<AnimadotadoEntity> listarTodos() {
        return animadotadoRepository.findAll();
    }

    @Override
    public Optional<AnimadotadoEntity> buscarPorId(Long id) {
        return animadotadoRepository.findById(id);
    }

}
