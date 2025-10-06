package br.com.pawproteticare.api.model.entity;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue(value = "DOADOR")
public class Doador extends UsuarioEntity{
}
