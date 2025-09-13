package com.br.pawproteticare.apipawproteticare.model.service;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Base64;

public class ImageUtils {

    // Converte imagem (arquivo) para Base64
    public static String encodeFileToBase64(File file) throws IOException {
        byte[] fileContent = Files.readAllBytes(file.toPath());
        return Base64.getEncoder().encodeToString(fileContent);
    }

    // Converte Base64 de volta para bytes (caso queira reconstruir a imagem depois)
    public static byte[] decodeBase64ToFile(String base64) {
        return Base64.getDecoder().decode(base64);
    }
}
