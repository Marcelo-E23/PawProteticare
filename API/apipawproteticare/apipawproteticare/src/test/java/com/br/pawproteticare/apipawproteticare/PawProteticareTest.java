package com.br.pawproteticare.apipawproteticare;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.br.pawproteticare.apipawproteticare.model.entity.PawProteticare;
import com.br.pawproteticare.apipawproteticare.model.repository.PawProteticareRepository;
import com.br.pawproteticare.apipawproteticare.model.service.PawProteticareServiceImpl;

@ExtendWith(MockitoExtension.class)
public class PawProteticareTest {

    @Mock
    private PawProteticareRepository pawProteticareRepository;

    @InjectMocks
    private PawProteticareServiceImpl pawProteticareService;

    @Test
    void deveRetornarListaDePawProteticare() {
        PawProteticare usuario1 = new PawProteticare();
        usuario1.setId(1L);
        usuario1.setEmail("pawproteticare@gmail.com");
        usuario1.setSenha("senha123");
        usuario1.setTelefone("11999999999");
        usuario1.setContaBancaria("123456-7");
        usuario1.setBairro("Centro");
        usuario1.setNumeroend(100);
        usuario1.setUf("SP");
        usuario1.setComplemento("Apto 12");
        usuario1.setLogradouro("Rua das Patas");
        usuario1.setCep("06000000");

        List<PawProteticare> listaMockada = Arrays.asList(usuario1);

        when(pawProteticareRepository.findAll()).thenReturn(listaMockada);

        List<PawProteticare> resultado = pawProteticareService.mostrarDados();

        assertEquals(1, resultado.size());
        assertEquals("pawproteticare@gmail.com", resultado.get(0).getEmail());
        verify(pawProteticareRepository, times(1)).findAll();
    }
}