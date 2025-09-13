package com.br.pawproteticare.apipawproteticare.model.service;

import java.util.List;
import java.util.Optional;

import com.br.pawproteticare.apipawproteticare.model.entity.Admin;

public interface AdminService {

    List<Admin> listarTodos();

    Optional<Admin> buscarPorId(Long id);

    Optional<Admin> buscarPorLogin(String login);

    Admin salvar(Admin animal);

    Admin atualizar(Long id, Admin adminAtualizado);

    void deletar(Long id);

    
}