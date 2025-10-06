package br.com.pawproteticare.api.model.entity;

import br.com.pawproteticare.api.model.enums.StatusAdocao;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "Animadotado")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnimadotadoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "doado", nullable = false)
    @Enumerated(EnumType.STRING)
    private StatusAdocao doado;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "proprietario_id", nullable = true)
    private Proprietario proprietario;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "animachado_id", nullable = true)
    private AnimachadoEntity animachado;

}
