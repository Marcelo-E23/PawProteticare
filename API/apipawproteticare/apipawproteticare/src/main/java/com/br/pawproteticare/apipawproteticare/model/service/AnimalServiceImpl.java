package com.br.pawproteticare.apipawproteticare.model.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.br.pawproteticare.apipawproteticare.model.entity.Animal;
import com.br.pawproteticare.apipawproteticare.model.repository.AnimalRepository;

@Service
public class AnimalServiceImpl implements AnimalService {
    private final AnimalRepository animalRepository;

    @Autowired
    public AnimalServiceImpl(AnimalRepository animalRepository) {
        this.animalRepository = animalRepository;
    }

    @Override
    public List<Animal> listarTodos() {
        return animalRepository.findAll();
    }

    @Override
    public Optional<Animal> buscarPorId(Long id) {
        return animalRepository.findById(id);
    }

    @Override
    public Animal salvar(Animal animal) {
        try {
            // Se "imagem" for um caminho de arquivo, converte para Base64
            if (animal.getImagem() != null && new File(animal.getImagem()).exists()) {
                String base64Img = ImageUtils.encodeFileToBase64(new File(animal.getImagem()));
                animal.setImagem(base64Img);
            }
        } catch (IOException e) {
            throw new RuntimeException("Erro ao converter imagem para Base64", e);
        }
        return animalRepository.save(animal);
    }

    @Override
    public Animal atualizar(Long id, Animal animalAtualizado) {
        return animalRepository.findById(id).map(animal -> {
            animal.setNome(animalAtualizado.getNome());
            animal.setEspecie(animalAtualizado.getEspecie());
            animal.setHistoria(animalAtualizado.getHistoria());
            animal.setProteseDescription(animalAtualizado.getProteseDescription());
            animal.setStatus(animalAtualizado.getStatus());
            animal.setIdade(animalAtualizado.getIdade());

            // Converte imagem para Base64 antes de atualizar
            try {
                if (animalAtualizado.getImagem() != null && new File(animalAtualizado.getImagem()).exists()) {
                    String base64Img = ImageUtils.encodeFileToBase64(new File(animalAtualizado.getImagem()));
                    animal.setImagem(base64Img);
                } else {
                    animal.setImagem(animalAtualizado.getImagem()); // caso já venha como Base64
                }
            } catch (IOException e) {
                throw new RuntimeException("Erro ao atualizar imagem para Base64", e);
            }

            animal.setProteseEntity(animalAtualizado.getProteseEntity());
            animal.setUsuario(animalAtualizado.getUsuario());
            return animalRepository.save(animal);
        }).orElseThrow(() -> new RuntimeException("Animal não encontrado"));
    }

    @Override
    public void deletar(Long id) {
        animalRepository.deleteById(id);
    }

    @Override
    public List<Animal> buscarPorStatus(String status) {
        return animalRepository.findByStatus(status);
    }

    @Override
    public List<Animal> buscarPorNome(String nome) {
        return animalRepository.findByNomeContainingIgnoreCase(nome);
    }
}