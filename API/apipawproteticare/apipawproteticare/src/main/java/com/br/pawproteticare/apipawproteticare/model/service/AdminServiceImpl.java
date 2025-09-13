package com.br.pawproteticare.apipawproteticare.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.br.pawproteticare.apipawproteticare.model.entity.Admin;
import com.br.pawproteticare.apipawproteticare.model.repository.AdminRepository;

import java.util.List;
import java.util.Optional;
//PRINCIPALMENTE AQUI NATHAN

@Service
public class AdminServiceImpl implements AdminService{

    private final AdminRepository adminRepository;

    @Autowired
    public AdminServiceImpl(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }

    @Override
    public List<Admin> listarTodos() {
        return adminRepository.findAll();
    }

    @Override
    public Optional<Admin> buscarPorId(Long id) {
        return adminRepository.findById(id);
    }

    @Override
    public Optional<Admin> buscarPorLogin(String login) {
        return adminRepository.findByLogin(login);
    }

    @Override
    public Admin salvar(Admin admin) {
        return adminRepository.save(admin);
    }

    @Override
    public Admin atualizar(Long id, Admin adminAtualizado) {
        Admin adminExistente = adminRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Admin não encontrado"));

        adminExistente.setLogin(adminAtualizado.getLogin());
        adminExistente.setSenha(adminAtualizado.getSenha());

        return adminRepository.save(adminExistente);
    }

    @Override
    public void deletar(Long id) {
        adminRepository.deleteById(id);
    }
}
