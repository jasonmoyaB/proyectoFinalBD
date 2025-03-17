package Modelo;


import java.util.ArrayList;
import java.util.List;

public class RolDAO {
    // Este es un ejemplo con datos "quemados", puedes adaptarlo a tu base de datos si es necesario

    public List<String> obtenerRoles() {
        // En un escenario real, aquí iría el código para consultar la base de datos
        List<String> roles = new ArrayList<>();
        roles.add("Administrador");
        roles.add("Editor");
        roles.add("Usuario");
        return roles;
    }

    public boolean agregarRol(String nombreRol) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}

