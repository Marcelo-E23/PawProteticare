package br.com.pawproteticare.api.model.repository;

import br.com.pawproteticare.api.model.entity.DoacaoEntity;
import br.com.pawproteticare.api.model.enums.StatusAdocao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;



@Repository
public interface IDoacao extends JpaRepository<DoacaoEntity, Long> {
   // Boolean existsByPetIdAndStatus(Long id, StatusAdocao statusAdocao);
    //Integer countByTutorIdAndStatus(Long id, StatusAdocao status);
}
