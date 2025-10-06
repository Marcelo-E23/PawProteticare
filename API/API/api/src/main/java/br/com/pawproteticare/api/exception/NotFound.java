package br.com.pawproteticare.api.exception;



public class NotFound extends RuntimeException{

    public NotFound(String message){
         super(message);
    }
}
