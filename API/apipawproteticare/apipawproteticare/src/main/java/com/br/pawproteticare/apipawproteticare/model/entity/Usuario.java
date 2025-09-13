package com.br.pawproteticare.apipawproteticare.model.entity;


import org.springframework.data.annotation.Id;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "Usuario")
public class Usuario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Integer animalId;

    private Long cpf;

    @Column(name = "email", length = 50, nullable = false, unique = true)
    private String email;

    @Column(name = "senha", length = 50, nullable = false)
    private String senha;

    @Column(name = "nome", length = 50, nullable = false)
    private String nome;

    @Column(name = "bairro", length = 40)
    private String bairro;

    private Integer numeroend;

    @Column(name = "uf", length = 2)
    private String uf;

    @Column(name = "complemento", length = 30)
    private String complemento;

    @Column(name = "cep", length = 8)
    private String cep;

    @Column(name = "logradouro", length = 50)
    private String logradouro;

    @Column(name = "telefone", length = 11)
    private String telefone;

    public Usuario(String nome, String email, String senha, String telefone){
        this.nome = nome;
        this.email = email;
        this.senha = senha;
        this.telefone = telefone;
    }

    public Usuario(){
        
    }
}
