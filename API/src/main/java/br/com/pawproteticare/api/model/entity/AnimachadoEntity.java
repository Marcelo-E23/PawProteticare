package br.com.pawproteticare.api.model.entity;

import br.com.pawproteticare.api.model.enums.StatusAnimal;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Entity
@Table(name = "Animachado")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class AnimachadoEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nome", length = 100, nullable = false)
    private String nome;

    @Column(name = "especie", length = 100, nullable = false)
    private String especie;

    @Column(name = "historia", nullable = false)
    private String historia;

    @Column(name = "status", length = 30)
    @Enumerated(EnumType.STRING)
    private StatusAnimal status;

    @Column(name = "idade", nullable = false)
    private Integer idade;

    @Lob
    @Column(name = "imagem", columnDefinition = "VARBINARY(MAX)")
     private byte[]  imagem;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "protese_id", referencedColumnName = "id", nullable = true)
    private ProteseEntity proteseEntity;


}
