package br.com.pawproteticare.api.exception;

public class Forbidden extends RuntimeException{

    public Forbidden(String message){
         super(message);
    }
}
