package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.UsuarioEntity;

import java.util.List;
import java.util.Optional;

public interface IUsuarioService {
    List<UsuarioEntity> listarTodos();

    Optional<UsuarioEntity> buscarPorId(Long id);

    UsuarioEntity salvar(UsuarioEntity usuarioEntity);

    UsuarioEntity atualizar(Long id, UsuarioEntity usuarioEntity);

    void deletar(Long id);

    Optional<UsuarioEntity> buscarPorEmail(String email);
}
