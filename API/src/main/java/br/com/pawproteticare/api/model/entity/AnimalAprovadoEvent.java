package br.com.pawproteticare.api.model.entity;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

@Getter
public class AnimalAprovadoEvent extends ApplicationEvent {

    private final AnimachadoEntity animal;

    public AnimalAprovadoEvent(AnimachadoEntity animal) {
        super(animal);
        this.animal = animal;
    }
}
