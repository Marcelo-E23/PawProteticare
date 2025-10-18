package br.com.pawproteticare.api.model.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue(value = "PROPRIETARIO")
public class Proprietario extends UsuarioEntity {
}
