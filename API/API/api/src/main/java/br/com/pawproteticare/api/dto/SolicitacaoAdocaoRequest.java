package br.com.pawproteticare.api.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class SolicitacaoAdocaoRequest {

    private Long id;
    private LocalDateTime dataSolicitacao;
    private String motivacao;
    private Long proprietarioId;
    private Long animachadoId;
}
