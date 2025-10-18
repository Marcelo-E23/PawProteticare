package br.com.pawproteticare.api.model.enums;

public enum Permission {

    ADMIN_READ("ADMIN_READ"),
    ADMIN_UPDATE("ADMIN_UPDATE"),
    ADMIN_CREATE("ADMIN_CREATE"),
    ADMIN_DELETE("ADMIN_DELETE"),
    PROPRIETARIO_READ("PROPRIETARIO_READ"),
    PROPRIETARIO_UPDATE("PROPRIETARIO_UPDATE"),
    PROPRIETARIO_CREATE("PROPRIETARIO_CREATE"),
    PROPRIETARIO_DELETE("PROPRIETARIO_DELETE"),
    DOADOR_READ("DOADOR_READ"),
    DOADOR_UPDATE("DOADOR_UPDATE"),
    DOADOR_CREATE("DOADOR_CREATE"),
    DOADOR_DELETE("DOADOR_DELETE")
    ;

    private final String permission;

    Permission(String permission) {
        this.permission = permission;
    }
    public String getPermission() {return permission;}
}
