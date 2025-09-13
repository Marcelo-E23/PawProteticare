package com.br.pawproteticare.apipawproteticare.model.service;

import java.util.List;
import java.util.Optional;

import com.br.pawproteticare.apipawproteticare.model.entity.Usuario;

public interface UsuarioService {
    List<Usuario> listarTodos();

    Optional<Usuario> buscarPorId(Long id);

    Usuario salvar(Usuario usuario);

    Usuario atualizar(Long id, Usuario usuarioAtualizado);

    void deletar(Long id);

    Optional<Usuario> buscarPorEmail(String email);
}
