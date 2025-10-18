package br.com.pawproteticare.api.model.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "SolicitacaoAdocao")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SolicitacaoAdocaoEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(nullable = true)
    private LocalDateTime dataSolicitacao;
    @Column(nullable = true, length = 255)
    private String motivacao;


    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "proprietario_id", referencedColumnName = "id", nullable = true)
    private Proprietario proprietario;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "animachado_id", referencedColumnName = "id", nullable = true)
    private AnimachadoEntity animachado;

}
