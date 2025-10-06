package br.com.pawproteticare.api.model.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Entity
@Table(name = "Protese")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProteseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "tipo",length = 40, nullable = false)
    private String tipo;

    @Column(name = "codigo",length = 40, nullable = true)
    private String codigo;

    @Column(name = "descricao",length = 40, nullable = true)
    private String descricao;

    @Column(name = "nome",length = 100, nullable = false)
    private String nome;

    @Column(name = "custo", precision = 10, scale = 2, nullable = false)
    private BigDecimal custo;

    @Column(name = "fabricante", length = 100, nullable = false)
    private String fabricante;


}
