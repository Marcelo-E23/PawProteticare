package br.com.pawproteticare.api.model.entity;

import br.com.pawproteticare.api.model.enums.StatusAnimal;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Component;

import jakarta.persistence.PostUpdate;

@Component
public class AnimalStatusListener {

    @Autowired
    private ApplicationEventPublisher publisher;

    @PostUpdate
    public void onStatusChange(AnimachadoEntity animal) {
        if (animal.getStatus() == StatusAnimal.APROVADO ) {
            System.out.println("🐾 Listener: Animal ID " + animal.getId() + " aprovado — disparando evento pós-commit...");
            publisher.publishEvent(new AnimalAprovadoEvent(animal));
        }
    }
}
