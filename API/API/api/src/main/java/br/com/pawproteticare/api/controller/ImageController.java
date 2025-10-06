package br.com.pawproteticare.api.controller;

import br.com.pawproteticare.api.model.service.FileBase64Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/imagem")
public class ImageController {

    @Autowired
    private FileBase64Service fileBase64Service;

    @PostMapping("/upload")
    public String uploadBase64Image(@RequestBody String base64) {
        try {
            byte[] imageBytes = fileBase64Service.decodeBase64ToBytes(base64);
            fileBase64Service.saveBytesToFile(imageBytes, "uploads/imagem_recebida.jpg");
            return "Imagem salva com sucesso!";
        } catch (Exception e) {
            return "Erro ao salvar imagem: " + e.getMessage();
        }
    }
}
