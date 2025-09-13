package com.br.pawproteticare.apipawproteticare.model.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.br.pawproteticare.apipawproteticare.model.entity.Usuario;
import com.br.pawproteticare.apipawproteticare.model.repository.UsuarioRepository;

@Service
public class UsuarioServiceImpl implements UsuarioService{
    private final UsuarioRepository usuarioRepository;

    @Autowired
    public UsuarioServiceImpl(UsuarioRepository usuarioRepository) {
        this.usuarioRepository = usuarioRepository;
    }

    @Override
    public List<Usuario> listarTodos() {
        return usuarioRepository.findAll();
    }

    @Override
    public Optional<Usuario> buscarPorId(Long id) {
        return usuarioRepository.findById(id);
    }

    @Override
    public Usuario salvar(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    @Override
    public Usuario atualizar(Long id, Usuario usuarioAtualizado) {
        return usuarioRepository.findById(id).map(usuario -> {
            usuario.setNome(usuarioAtualizado.getNome());
            usuario.setEmail(usuarioAtualizado.getEmail());
            usuario.setSenha(usuarioAtualizado.getSenha());
            usuario.setTelefone(usuarioAtualizado.getTelefone());
            usuario.setAnimalId(usuarioAtualizado.getAnimalId());
            usuario.setCpf(usuarioAtualizado.getCpf());
            usuario.setBairro(usuarioAtualizado.getBairro());
            usuario.setNumeroend(usuarioAtualizado.getNumeroend());
            usuario.setUf(usuarioAtualizado.getUf());
            usuario.setComplemento(usuarioAtualizado.getComplemento());
            usuario.setCep(usuarioAtualizado.getCep());
            usuario.setLogradouro(usuarioAtualizado.getLogradouro());
            return usuarioRepository.save(usuario);
        }).orElseThrow(() -> new RuntimeException("Usuário não encontrado"));
    }

    @Override
    public void deletar(Long id) {
        usuarioRepository.deleteById(id);
    }

    @Override
    public Optional<Usuario> buscarPorEmail(String email) {
        return usuarioRepository.findByEmail(email);
    }

}
