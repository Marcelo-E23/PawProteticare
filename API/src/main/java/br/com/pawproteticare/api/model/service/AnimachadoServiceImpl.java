package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.AnimachadoEntity;
import br.com.pawproteticare.api.model.enums.StatusAnimal;
import br.com.pawproteticare.api.model.repository.IAnimachado;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@Service
public class AnimachadoServiceImpl implements IAnimachadoService {
    private final IAnimachado animachadoRepository;

    public AnimachadoServiceImpl(IAnimachado animachadoRepository) {
        this.animachadoRepository = animachadoRepository;
    }

    @Override
    public List<AnimachadoEntity> listarTodos() {
        return animachadoRepository.findAll();
    }

    @Override
    public Optional<AnimachadoEntity> buscarPorId(Long Id) {
        return animachadoRepository.findById(Id);
    }

    @Override
    public AnimachadoEntity salvar(AnimachadoEntity animal) {
        //try {
            // Se "imagem" for um caminho de arquivo, converte para Base64
          //  if (animal.getImagem() != null && new File(animal.getImagem()).exists()) {
            //    String base64Img = FileBase64Service.encodeFileToBase64(new File(animal.getImagem()));
           //     animal.setImagem(base64Img);
          //  }
      //  } catch (IOException e) {
         //   throw new RuntimeException("Erro ao converter imagem para Base64", e);
      //  }
        animal.setStatus(StatusAnimal.ANALISE_SITUACAO);
        return animachadoRepository.save(animal);
    }


    @Override
    public AnimachadoEntity atualizar(Long Id, AnimachadoEntity animalAtualizado) {
        return animachadoRepository.findById(Id).map(animal -> {
            animal.setNome(animalAtualizado.getNome());
            animal.setEspecie(animalAtualizado.getEspecie());
            animal.setHistoria(animalAtualizado.getHistoria());
            //animal.setProtese(animalAtualizado.getProtese());
            animal.setStatus(animalAtualizado.getStatus());
            animal.setIdade(animalAtualizado.getIdade());

            // Converte imagem para Base64 antes de atualizar
        //    try {
          //      if (animalAtualizado.getImagem() != null && new File(animalAtualizado.getImagem()).exists()) {
           //         String base64Img = FileBase64Service.encodeFileToBase64(new File(animalAtualizado.getImagem()));
           //         animal.setImagem(base64Img);
          //      } else {
             //       animal.setImagem(animalAtualizado.getImagem()); // caso já venha como Base64
             //   }
          //  } catch (IOException e) {
           //     throw new RuntimeException("Erro ao atualizar imagem para Base64", e);
          //  }

            //animal.setDoado(animalAtualizado.getDoado());
           // animal.setFk_Protese_Id(animalAtualizado.getFk_Protese_Id());
           // animal.setFk_Usuario_Id(animalAtualizado.getFk_Usuario_Id());
            return animachadoRepository.save(animal);
        }).orElseThrow(() -> new RuntimeException("Animal não encontrado"));
    }

    @Override
    public void deletar(Long Id) {
        animachadoRepository.deleteById(Id);
    }

    @Override
    public Optional<AnimachadoEntity> buscarPorStatus(StatusAnimal status) {
        return animachadoRepository.findByStatus(status);
    }

    @Override
    public Optional<AnimachadoEntity> buscarPorNome(String nome) {
        return animachadoRepository.findByNomeContainingIgnoreCase(nome);
    }

    @Override
    public Optional<AnimachadoEntity> findByNomeContainingIgnoreCase(String nome) {
        return Optional.empty();
    }


}
