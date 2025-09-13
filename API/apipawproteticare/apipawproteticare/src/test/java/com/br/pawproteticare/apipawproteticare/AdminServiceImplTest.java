package com.br.pawproteticare.apipawproteticare;

import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import com.br.pawproteticare.apipawproteticare.model.entity.Admin;
import com.br.pawproteticare.apipawproteticare.model.repository.AdminRepository;
import com.br.pawproteticare.apipawproteticare.model.service.AdminServiceImpl;

@ExtendWith(MockitoExtension.class)
public class AdminServiceImplTest {

    @Mock
    private AdminRepository adminRepository;

    @InjectMocks
    private AdminServiceImpl adminService;

    private Admin admin;

    @BeforeEach
    void setUp() {
        admin = new Admin();
        admin.setId(1L);
        admin.setLogin("admin");
        admin.setSenha("1234");
    }

    @Test
    void deveListarTodosOsAdmins() {
        List<Admin> admins = List.of(admin);
        Mockito.when(adminRepository.findAll()).thenReturn(admins);

        List<Admin> resultado = adminService.listarTodos();

        Assertions.assertEquals(1, resultado.size());
        Assertions.assertEquals(admins.get(0), resultado.get(0));
        verify(adminRepository,times(1)).findAll();
    }

    @Test
    void deveBuscarAdminPorId() {
        Mockito.when(adminRepository.findById(1L)).thenReturn(Optional.of(admin));

        Optional<Admin> resultado = adminService.buscarPorId(1L);

        Assertions.assertTrue(resultado.isPresent());
        Assertions.assertEquals("admin", resultado.get().getLogin());
        verify(adminRepository,times(1)).findById(resultado.get().getId());
    }

    @Test
    void deveBuscarAdminPorLogin() {
        Mockito.when(adminRepository.findByLogin("admin")).thenReturn(Optional.of(admin));

        Optional<Admin> resultado = adminService.buscarPorLogin("admin");

        Assertions.assertTrue(resultado.isPresent());
        Assertions.assertEquals("admin", resultado.get().getLogin());
        verify(adminRepository,times(1)).findByLogin(resultado.get().getLogin());
    }

    @Test
    void deveSalvarAdmin() {
        Mockito.when(adminRepository.save(admin)).thenReturn(admin);

        Admin resultado = adminService.salvar(admin);

        Assertions.assertNotNull(resultado);
        Assertions.assertEquals("admin", resultado.getLogin());
        verify(adminRepository, times(1)).save(admin);
    }

    @Test
    void deveAtualizarAdminExistente() {
        Admin atualizado = new Admin();
        atualizado.setLogin("novoLogin");
        atualizado.setSenha("novaSenha");

        Mockito.when(adminRepository.findById(1L)).thenReturn(Optional.of(admin));
        Mockito.when(adminRepository.save(Mockito.any(Admin.class))).thenAnswer(inv -> inv.getArgument(0));

        Admin resultado = adminService.atualizar(1L, atualizado);

        Assertions.assertEquals("novoLogin", resultado.getLogin());
        Assertions.assertEquals("novaSenha", resultado.getSenha());
        verify(adminRepository, times(1)).findById(1L);
        verify(adminRepository, times(1)).save(admin);
    }

    @Test
    void deveLancarExcecaoAoAtualizarAdminInexistente() {
        Mockito.when(adminRepository.findById(99L)).thenReturn(Optional.empty());

        Admin atualizado = new Admin();
        atualizado.setLogin("x");
        atualizado.setSenha("y");

        Assertions.assertThrows(RuntimeException.class, () -> {
            adminService.atualizar(99L, atualizado);
        });
        verify(adminRepository,times(0)).save(admin);
    }

    @Test
    void deveDeletarAdminPorId() {
        adminService.deletar(1L);
        Mockito.verify(adminRepository,times(1)).deleteById(1L);
    }
}
