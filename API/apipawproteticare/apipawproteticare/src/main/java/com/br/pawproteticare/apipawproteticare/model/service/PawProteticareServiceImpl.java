package com.br.pawproteticare.apipawproteticare.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.br.pawproteticare.apipawproteticare.model.entity.PawProteticare;
import com.br.pawproteticare.apipawproteticare.model.repository.PawProteticareRepository;

@Service
public class PawProteticareServiceImpl implements PawProteticareService{

    private final PawProteticareRepository pawProteticareRepository;

    @Autowired
    public PawProteticareServiceImpl(PawProteticareRepository pawProteticareRepository){
        this.pawProteticareRepository = pawProteticareRepository;
    }

    @Override
    public List<PawProteticare> mostrarDados() {
        return pawProteticareRepository.findAll();
    }

    
}
