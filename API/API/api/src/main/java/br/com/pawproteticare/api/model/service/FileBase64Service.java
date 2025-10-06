package br.com.pawproteticare.api.model.service;

import org.springframework.stereotype.Service;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.Base64;

@Service
public class FileBase64Service {

    public static String encodeFileToBase64(File file) throws IOException {
        byte[] fileContent = Files.readAllBytes(file.toPath());
        return Base64.getEncoder().encodeToString(fileContent);
    }

    public byte[] decodeBase64ToBytes(String base64) {
        return Base64.getDecoder().decode(base64);
    }

    public void saveBytesToFile(byte[] bytes, String path) throws IOException {
        Files.write(new File(path).toPath(), bytes);
    }
}
