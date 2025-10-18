package br.com.pawproteticare.api.exception;

public class Unauthorized extends RuntimeException{

    public Unauthorized(String message){
         super(message);
    }
}
