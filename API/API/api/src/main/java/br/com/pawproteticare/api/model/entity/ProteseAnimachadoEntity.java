package br.com.pawproteticare.api.model.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


import java.time.LocalDateTime;

@Entity
@Table(name = "ProteseAnimachado")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProteseAnimachadoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = true)
    private LocalDateTime dataAplicacaoProtese;

    @Column(length = 255, nullable = true)
    private String observacao;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "animachado_id", referencedColumnName = "id", nullable = true)
    private AnimachadoEntity animachado;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "proteseEntity_id", referencedColumnName = "id", nullable = true)
    private ProteseEntity proteseEntity;
}
