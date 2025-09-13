package com.br.pawproteticare.apipawproteticare.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.br.pawproteticare.apipawproteticare.model.entity.PawProteticare;
import com.br.pawproteticare.apipawproteticare.model.service.PawProteticareServiceImpl;

@RestController
@RequestMapping("/api/pawproteticare")
@CrossOrigin(origins = "http://localhost:5173")
public class PawProteticareController {

    private final PawProteticareServiceImpl pawProteticareServiceImpl;

    @Autowired
    public PawProteticareController(PawProteticareServiceImpl pawProteticareServiceImpl) {
        this.pawProteticareServiceImpl = pawProteticareServiceImpl;
    }

    // Listar todos
    @GetMapping
    public List<PawProteticare> mostrarDados() {
        return pawProteticareServiceImpl.mostrarDados();
    }
}
