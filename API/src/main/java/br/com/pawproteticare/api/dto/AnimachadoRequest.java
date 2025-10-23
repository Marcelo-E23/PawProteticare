package br.com.pawproteticare.api.dto;
import br.com.pawproteticare.api.model.enums.StatusAnimal;
import lombok.Data;


@Data
public class AnimachadoRequest {

    private String nome;
    private String especie;
    private String historia;
    private StatusAnimal status;
    private Integer idade;
    private byte[]  imagem;
    private Long proteseId;

}
