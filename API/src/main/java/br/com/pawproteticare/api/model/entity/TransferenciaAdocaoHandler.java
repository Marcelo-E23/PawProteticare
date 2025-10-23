package br.com.pawproteticare.api.model.entity;

import br.com.pawproteticare.api.model.repository.IAnimachado;
import br.com.pawproteticare.api.model.repository.IAnimadotado;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.event.TransactionalEventListener;
import org.springframework.transaction.event.TransactionPhase;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class TransferenciaAdocaoHandler {

    private final IAnimadotado adotadoRepository;
    private final IAnimachado achadoRepository;

    @TransactionalEventListener(phase = TransactionPhase.AFTER_COMMIT)
    @Transactional(propagation = Propagation.REQUIRES_NEW)
    public void handleTransfer(AnimalAprovadoEvent event) {
        AnimachadoEntity animal = event.getAnimal();

        System.out.println("🔄 Pós-commit: transferindo animal ID " + animal.getId() + " para Animadotado...");

        AnimadotadoEntity adotado = new AnimadotadoEntity();
        adotado.setNome(animal.getNome());
        adotado.setIdade(animal.getIdade());
        adotado.setEspecie(animal.getEspecie());
        adotado.setHistoria(animal.getHistoria());
        adotado.setImagem(animal.getImagem());
        adotado.setProteseEntity(animal.getProteseEntity());
        adotado.setStatus(animal.getStatus());
        adotado.setAnimachado(animal.getId());

        adotadoRepository.save(adotado);

        System.out.println("✅ Transferência concluída com sucesso!");
    }
}
