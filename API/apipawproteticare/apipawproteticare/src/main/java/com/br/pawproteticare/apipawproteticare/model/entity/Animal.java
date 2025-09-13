package com.br.pawproteticare.apipawproteticare.model.entity;

import org.springframework.data.annotation.Id;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.Lob;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Table(name = "Animal")
@Entity
public class Animal {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nome", length = 100, nullable = false)
    private String nome;

    @Column(name = "nome", length = 100, nullable = false)
    private String especie;

    @Column(name = "historia", length = 255)
    private String historia;

    @Column(name = "protese", length = 255)
    private String proteseDescription;

    @Column(name = "status", length = 50)
    private String status;

    private Integer idade;

    @Lob
    private String imagem; // pode armazenar base64 ou URL

    // ===== RELACIONAMENTOS =====

    @ManyToOne
    @JoinColumn(name = "fk_Protese_Id")
    private Protese proteseEntity;

    @ManyToOne
    @JoinColumn(name = "fk_Usuario_Id")
    private Usuario usuario;

    // ===== CONSTRUTORES =====

    public Animal(String nome, String especie, String historia, String proteseDescription,
                  String status, Integer idade, String imagem,
                  Protese proteseEntity, Usuario usuario) {
        this.nome = nome;
        this.especie = especie;
        this.historia = historia;
        this.proteseDescription = proteseDescription;
        this.status = status;
        this.idade = idade;
        this.imagem = imagem;
        this.proteseEntity = proteseEntity;
        this.usuario = usuario;
    }

    public Animal(){
        
    }
}
