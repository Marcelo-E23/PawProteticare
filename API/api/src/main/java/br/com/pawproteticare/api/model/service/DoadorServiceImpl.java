package br.com.pawproteticare.api.model.service;

import br.com.pawproteticare.api.model.entity.Doador;
import br.com.pawproteticare.api.model.enums.Role;
import br.com.pawproteticare.api.model.repository.IDoador;
import org.springframework.stereotype.Service;


@Service
public class DoadorServiceImpl implements IDoadorService {

    private final IDoador iDoador;

    public DoadorServiceImpl(IDoador iDoador) {
        this.iDoador = iDoador;
    }

}
