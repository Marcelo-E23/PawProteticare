package com.br.pawproteticare.apipawproteticare;
import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import java.util.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.br.pawproteticare.apipawproteticare.model.entity.Animal;
import com.br.pawproteticare.apipawproteticare.model.entity.Protese;
import com.br.pawproteticare.apipawproteticare.model.entity.Usuario;
import com.br.pawproteticare.apipawproteticare.model.repository.AnimalRepository;
import com.br.pawproteticare.apipawproteticare.model.service.AnimalServiceImpl;

@ExtendWith(MockitoExtension.class)
public class AnimalTest {

    @Mock
    private AnimalRepository animalRepository;

    @InjectMocks
    private AnimalServiceImpl animalServiceImpl;

    private Protese protese;
    private Usuario usuario;

    @BeforeEach
    void setUp() {
        protese = new Protese();
        usuario = new Usuario();
    }

    @Test
    void deveListarTodosAnimais() {
        List<Animal> animais = Arrays.asList(
            new Animal("Rex", "Cachorro", "História 1", "Prótese pata", "Ativo", 3, "img1.png", protese, usuario)
        );
        when(animalRepository.findAll()).thenReturn(animais);

        List<Animal> result = animalServiceImpl.listarTodos();

        assertEquals(1, result.size());
        assertEquals("Rex", result.get(0).getNome());
        verify(animalRepository, times(1)).findAll();
    }

    @Test
    void deveBuscarAnimalPorId() {
        Animal animal = new Animal("Mia", "Gato", "História 2", "Prótese cauda", "Inativo", 2, "img2.png", protese, usuario);
        when(animalRepository.findById(1L)).thenReturn(Optional.of(animal));

        Optional<Animal> result = animalServiceImpl.buscarPorId(1L);

        assertTrue(result.isPresent());
        assertEquals("Mia", result.get().getNome());
        verify(animalRepository, times(1)).findById(1L);
    }

    @Test
    void deveSalvarAnimal() {
        Animal animal = new Animal("Thor", "Cachorro", "História 3", "Prótese perna", "Ativo", 4, "img3.png", protese, usuario);
        when(animalRepository.save(animal)).thenReturn(animal);

        Animal salvo = animalServiceImpl.salvar(animal);

        assertNotNull(salvo);
        assertEquals("Thor", salvo.getNome());
        verify(animalRepository, times(1)).save(animal);
    }

    @Test
    void deveAtualizarAnimalQuandoExistente() {
        Animal animalExistente = new Animal("Luna", "Gato", "História antiga", "Prótese antiga", "Inativo", 5, "old.png", protese, usuario);
        animalExistente.setId(1L);

        Animal animalAtualizado = new Animal("Luna Atualizada", "Gato", "História nova", "Prótese nova", "Ativo", 6, "new.png", protese, usuario);

        when(animalRepository.findById(1L)).thenReturn(Optional.of(animalExistente));
        when(animalRepository.save(any(Animal.class))).thenAnswer(invocation -> invocation.getArgument(0));

        Animal result = animalServiceImpl.atualizar(1L, animalAtualizado);

        assertEquals("Luna Atualizada", result.getNome());
        assertEquals("História nova", result.getHistoria());
        assertEquals("Prótese nova", result.getProteseDescription());
        assertEquals("Ativo", result.getStatus());
        assertEquals(6, result.getIdade());
        assertEquals("new.png", result.getImagem());
        verify(animalRepository, times(1)).findById(1L);
        verify(animalRepository, times(1)).save(animalExistente);
    }

    @Test
    void deveLancarExcecaoAoAtualizarAnimalInexistente() {
        Animal animalAtualizado = new Animal("Luna", "Gato", "História nova", "Prótese nova", "Ativo", 6, "img.png", protese, usuario);

        when(animalRepository.findById(1L)).thenReturn(Optional.empty());

        RuntimeException exception = assertThrows(RuntimeException.class,
                () -> animalServiceImpl.atualizar(1L, animalAtualizado));

        assertEquals("Animal não encontrado", exception.getMessage());
        verify(animalRepository, times(1)).findById(1L);
        verify(animalRepository, never()).save(any());
    }

    @Test
    void deveDeletarAnimalPorId() {
        doNothing().when(animalRepository).deleteById(1L);

        animalServiceImpl.deletar(1L);

        verify(animalRepository, times(1)).deleteById(1L);
    }

    @Test
    void deveBuscarAnimalPorStatus() {
        List<Animal> animais = Arrays.asList(
            new Animal("Bolt", "Cachorro", "História", "Prótese", "Ativo", 2, "imgBolt.png", protese, usuario)
        );
        when(animalRepository.findByStatus("Ativo")).thenReturn(animais);

        List<Animal> result = animalServiceImpl.buscarPorStatus("Ativo");

        assertEquals(1, result.size());
        assertEquals("Bolt", result.get(0).getNome());
        verify(animalRepository, times(1)).findByStatus("Ativo");
    }

    @Test
    void deveBuscarAnimalPorNome() {
        List<Animal> animais = Arrays.asList(
            new Animal("Bobby", "Cachorro", "História", "Prótese", "Ativo", 3, "imgBobby.png", protese, usuario)
        );
        when(animalRepository.findByNomeContainingIgnoreCase("Bobby")).thenReturn(animais);

        List<Animal> result = animalServiceImpl.buscarPorNome("Bobby");

        assertEquals(1, result.size());
        assertEquals("Bobby", result.get(0).getNome());
        verify(animalRepository, times(1)).findByNomeContainingIgnoreCase("Bobby");
    }
}