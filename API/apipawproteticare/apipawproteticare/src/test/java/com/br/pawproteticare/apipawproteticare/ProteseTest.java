package com.br.pawproteticare.apipawproteticare;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.br.pawproteticare.apipawproteticare.model.entity.Protese;
import com.br.pawproteticare.apipawproteticare.model.repository.ProteseRepository;
import com.br.pawproteticare.apipawproteticare.model.service.ProteseServiceImpl;

@ExtendWith(MockitoExtension.class)
public class ProteseTest {

    @Mock
    private ProteseRepository proteseRepository;

    @InjectMocks
    private ProteseServiceImpl proteseService;

    @Test
    void deveListarTodasProteses() {
        List<Protese> proteses = Arrays.asList(
            new Protese("Perna", 1500.0, "OrtoTech")
        );
        when(proteseRepository.findAll()).thenReturn(proteses);

        List<Protese> result = proteseService.listarTodos();

        assertEquals(1, result.size());
        assertEquals("Perna", result.get(0).getTipo());
        verify(proteseRepository, times(1)).findAll();
    }

    @Test
    void deveBuscarProtesePorId() {
        Protese protese = new Protese("Braço", 1200.0, "BioMove");
        when(proteseRepository.findById(1L)).thenReturn(Optional.of(protese));

        Optional<Protese> result = proteseService.buscarPorId(1L);

        assertTrue(result.isPresent());
        assertEquals("Braço", result.get().getTipo());
        verify(proteseRepository, times(1)).findById(1L);
    }

    @Test
    void deveSalvarProtese() {
        Protese protese = new Protese("Mão", 800.0, "FlexPro");
        when(proteseRepository.save(protese)).thenReturn(protese);

        Protese salvo = proteseService.salvar(protese);

        assertNotNull(salvo);
        assertEquals("Mão", salvo.getTipo());
        verify(proteseRepository, times(1)).save(protese);
    }

    @Test
    void deveAtualizarProteseExistente() {
        Protese existente = new Protese("Joelho", 1000.0, "MoveTech");
        existente.setId(1L);

        Protese atualizada = new Protese("Joelho Avançado", 1800.0, "MoveTech Pro");

        when(proteseRepository.findById(1L)).thenReturn(Optional.of(existente));
        when(proteseRepository.save(any(Protese.class))).thenAnswer(inv -> inv.getArgument(0));

        Protese result = proteseService.atualizar(1L, atualizada);

        assertEquals("Joelho Avançado", result.getTipo());
        assertEquals(1800.0, result.getCusto());
        assertEquals("MoveTech Pro", result.getFabricante());
        verify(proteseRepository, times(1)).findById(1L);
        verify(proteseRepository, times(1)).save(existente);
    }

    @Test
    void deveLancarExcecaoAoAtualizarProteseInexistente() {
        Protese atualizada = new Protese("Joelho Avançado", 1800.0, "MoveTech Pro");

        when(proteseRepository.findById(1L)).thenReturn(Optional.empty());

        RuntimeException exception = assertThrows(RuntimeException.class,
            () -> proteseService.atualizar(1L, atualizada));

        assertEquals("Prótese não encontrada", exception.getMessage());
        verify(proteseRepository, times(1)).findById(1L);
        verify(proteseRepository, never()).save(any());
    }

    @Test
    void deveDeletarProtesePorId() {
        doNothing().when(proteseRepository).deleteById(1L);

        proteseService.deletar(1L);

        verify(proteseRepository, times(1)).deleteById(1L);
    }

    @Test
    void deveBuscarProtesePorTipo() {
        Protese protese = new Protese("Tornozelo", 950.0, "OrtoFlex");
        when(proteseRepository.findByTipo("Tornozelo")).thenReturn(Optional.of(protese));

        Optional<Protese> result = proteseService.buscarPorTipo("Tornozelo");

        assertTrue(result.isPresent());
        assertEquals("OrtoFlex", result.get().getFabricante());
        verify(proteseRepository, times(1)).findByTipo("Tornozelo");
    }
}
