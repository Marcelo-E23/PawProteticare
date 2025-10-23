package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.UsuarioEntity;
import br.com.pawproteticare.api.model.enums.Role;
import br.com.pawproteticare.api.model.repository.IUsuario;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UsuarioServiceImpl implements IUsuarioService {
    private final IUsuario usuarioRepository;

    @Autowired
    public UsuarioServiceImpl(IUsuario usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Override
    public List<UsuarioEntity> listarTodos() {
        return usuarioRepository.findAll();
    }

    @Override
    public Optional<UsuarioEntity> buscarPorId(Long id) {
        return usuarioRepository.findById(id);
    }

    @Override
    public UsuarioEntity salvar(UsuarioEntity usuarioEntity) {
        return usuarioRepository.save(usuarioEntity);
    }

    @Override
    public UsuarioEntity atualizar(Long id, UsuarioEntity usuarioEntity) {
        return usuarioRepository.findById(id).map(usuario -> {
            usuario.setNome(usuarioEntity.getNome());
            usuario.setEmail(usuarioEntity.getEmail());
            usuario.setPassword(usuarioEntity.getPassword());
            usuario.setTelefone(usuarioEntity.getTelefone());
            usuario.setCpf(usuarioEntity.getCpf());
            usuario.setBairro(usuarioEntity.getBairro());
            usuario.setUf(usuarioEntity.getUf());
            usuario.setComplemento(usuarioEntity.getComplemento());
            usuario.setCep(usuarioEntity.getCep());
            usuario.setLogradouro(usuarioEntity.getLogradouro());
            return usuarioRepository.save(usuario);
        }).orElseThrow(() -> new RuntimeException("Usuário não encontrado"));
    }

    @Override
    public void deletar(Long id) {
        usuarioRepository.deleteById(id);
    }

    @Override
    public Optional<UsuarioEntity> buscarPorEmail(String email) {
        return usuarioRepository.findByEmail(email);
    }
}
