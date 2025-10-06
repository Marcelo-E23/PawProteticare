package br.com.pawproteticare.api.model.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "Doacao")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DoacaoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "tipodoacao", nullable = false, length = 50)
    private String tipodoacao;

    @Column(name = "datadoacao", nullable = false)
    private LocalDateTime datadoacao;

    @Column(name = "valor", nullable = false, length = 30)
    private String valor;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "doador_id", referencedColumnName = "id", nullable = true)
    private Doador doador;


}
