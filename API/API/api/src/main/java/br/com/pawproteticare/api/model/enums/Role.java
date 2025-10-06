package br.com.pawproteticare.api.model.enums;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import static br.com.pawproteticare.api.model.enums.Permission.*;


public enum Role {
    USER(Collections.emptySet()),
    ADMIN(
            Set.of(
                    ADMIN_READ,
                    ADMIN_UPDATE,
                    ADMIN_DELETE,
                    ADMIN_CREATE
            )
    ),
    PROPRIETARIO(
            Set.of(
                    PROPRIETARIO_READ,
                    PROPRIETARIO_UPDATE,
                    PROPRIETARIO_DELETE,
                    PROPRIETARIO_CREATE
            )
    ),
    DOADOR(
            Set.of(
                    DOADOR_READ,
                    DOADOR_UPDATE,
                    DOADOR_DELETE,
                    DOADOR_CREATE
            )
    );

    private final Set<Permission> permissions;

    Role(Set<Permission> permissions) {
        this.permissions = permissions;
    }

    public List<SimpleGrantedAuthority> getAuthorities() {
        var authorities = getPermissions()
                .stream()
                .map(permission -> new SimpleGrantedAuthority(permission.getPermission()))
                .collect(Collectors.toList());
        authorities.add(new SimpleGrantedAuthority("ROLE_" + this.name()));
        return authorities;
    }

    public Set<Permission> getPermissions() {
        return permissions;
    }
}
