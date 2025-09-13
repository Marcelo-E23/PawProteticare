package com.br.pawproteticare.apipawproteticare;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.br.pawproteticare.apipawproteticare.model.entity.Usuario;
import com.br.pawproteticare.apipawproteticare.model.repository.UsuarioRepository;
import com.br.pawproteticare.apipawproteticare.model.service.UsuarioServiceImpl;

@ExtendWith(MockitoExtension.class)
public class UsuarioTest {

    @Mock
    private UsuarioRepository usuarioRepository;

    @InjectMocks
    private UsuarioServiceImpl usuarioService;

    @Test
    void deveListarTodosUsuarios() {
        List<Usuario> usuarios = Arrays.asList(
            new Usuario("João", "joao@email.com", "123", "999999999")
        );
        when(usuarioRepository.findAll()).thenReturn(usuarios);

        List<Usuario> result = usuarioService.listarTodos();

        assertEquals(1, result.size());
        assertEquals("João", result.get(0).getNome());
        verify(usuarioRepository, times(1)).findAll();
    }

    @Test
    void deveBuscarUsuarioPorId() {
        Usuario usuario = new Usuario("Maria", "maria@email.com", "senha", "888888888");
        when(usuarioRepository.findById(1L)).thenReturn(Optional.of(usuario));

        Optional<Usuario> result = usuarioService.buscarPorId(1L);

        assertTrue(result.isPresent());
        assertEquals("Maria", result.get().getNome());
        verify(usuarioRepository, times(1)).findById(1L);
    }

    @Test
    void deveSalvarUsuario() {
        Usuario usuario = new Usuario("Pedro", "pedro@email.com", "1234", "777777777");
        when(usuarioRepository.save(usuario)).thenReturn(usuario);

        Usuario salvo = usuarioService.salvar(usuario);

        assertNotNull(salvo);
        assertEquals("Pedro", salvo.getNome());
        verify(usuarioRepository, times(1)).save(usuario);
    }

    @Test
    void deveAtualizarUsuarioQuandoExistente() {
        Usuario usuarioExistente = new Usuario("Carlos", "carlos@email.com", "123", "666666666");
        usuarioExistente.setId(1L);

        Usuario usuarioAtualizado = new Usuario("Carlos Silva", "carlos@email.com", "senhaNova", "999999999");

        when(usuarioRepository.findById(1L)).thenReturn(Optional.of(usuarioExistente));
        when(usuarioRepository.save(any(Usuario.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Usuario result = usuarioService.atualizar(1L, usuarioAtualizado);

        assertEquals("Carlos Silva", result.getNome());
        assertEquals("senhaNova", result.getSenha());
        assertEquals("999999999", result.getTelefone());
        verify(usuarioRepository, times(1)).findById(1L);
        verify(usuarioRepository, times(1)).save(usuarioExistente);
    }

    @Test
    void deveLancarExcecaoAoAtualizarUsuarioInexistente() {
        Usuario usuarioAtualizado = new Usuario("Carlos Silva", "carlos@email.com", "senhaNova", "999999999");

        when(usuarioRepository.findById(1L)).thenReturn(Optional.empty());

        RuntimeException exception = assertThrows(RuntimeException.class,
                () -> usuarioService.atualizar(1L, usuarioAtualizado));

        assertEquals("Usuário não encontrado", exception.getMessage());
        verify(usuarioRepository, times(1)).findById(1L);
        verify(usuarioRepository, never()).save(any());
    }

    @Test
    void deveDeletarUsuarioPorId() {
        doNothing().when(usuarioRepository).deleteById(1L);

        usuarioService.deletar(1L);

        verify(usuarioRepository, times(1)).deleteById(1L);
    }

    @Test
    void deveBuscarUsuarioPorEmail() {
        Usuario usuario = new Usuario("Ana", "ana@email.com", "123", "555555555");
        when(usuarioRepository.findByEmail("ana@email.com")).thenReturn(Optional.of(usuario));

        Optional<Usuario> result = usuarioService.buscarPorEmail("ana@email.com");

        assertTrue(result.isPresent());
        assertEquals("Ana", result.get().getNome());
        verify(usuarioRepository, times(1)).findByEmail("ana@email.com");
    }
}
