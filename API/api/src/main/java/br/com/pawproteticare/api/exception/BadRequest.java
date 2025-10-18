package br.com.pawproteticare.api.exception;



public class BadRequest extends RuntimeException{

    public BadRequest(String message){
         super(message);
    }
}
