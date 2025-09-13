package com.br.pawproteticare.apipawproteticare.model.entity;

import org.springframework.data.annotation.Id;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Table(name = "PawProteticare")
@NoArgsConstructor
@AllArgsConstructor
public class PawProteticare {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "telefone", length = 11)
    private String telefone;

    @Column(name = "email", length = 50, nullable = false, unique = true)
    private String email;

    @Column(name = "senha", length = 50, nullable = false)
    private String senha;

    @Column(name = "contabancaria", length = 50)
    private String contaBancaria;

    @Column(name = "bairro", length = 40)
    private String bairro;

    private Integer numeroend;

    @Column(name = "uf", length = 2)
    private String uf;

    @Column(name = "complemento", length = 30)
    private String complemento;

    @Column(name = "logradouro", length = 50)
    private String logradouro;

    @Column(name = "cep", length = 8)
    private String cep;

}