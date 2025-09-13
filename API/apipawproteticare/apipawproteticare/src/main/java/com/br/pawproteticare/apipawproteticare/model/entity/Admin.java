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
@Table(name = "ADM")
public class Admin {
   
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private Long id;

   @Column(name = "tipo",length = 50, nullable = false, unique = true)
   String login;
  
   @Column(name = "fabricante", length = 50, nullable = false, unique = true)
   String senha;
     
//Constructor
    public Admin(String login, String senha) {
        this.login = login;
        this.senha = senha;
    

    }

    public Admin(){
        
    }


}
