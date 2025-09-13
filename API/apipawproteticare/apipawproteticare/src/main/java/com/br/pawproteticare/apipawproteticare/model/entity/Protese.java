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
@Table(name = "Protese")
public class Protese {
   
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private Long id;

   @Column(name = "tipo",length = 100, nullable = false, unique = true)
   String tipo;
   @Column(name = "custo",precision = 10, scale = 2, nullable = false, unique = true )
   Double custo;
   @Column(name = "fabricante", length = 100, nullable = false, unique = true)
   String fabricante;

   public Protese(String tipo, double custo, String fabricante){

    this.tipo = tipo;
    this.custo = custo;
    this.fabricante = fabricante;

   }

   public Protese(){
    
   }
     
}
