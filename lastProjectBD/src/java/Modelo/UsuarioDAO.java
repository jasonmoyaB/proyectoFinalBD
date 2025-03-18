package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UsuarioDAO {
    Conexion conexion = new Conexion();

    // Método para agregar un nuevo usuario con un INSERT INTO normal
    public boolean agregarUsuario(int idUsuario, String nombreUsuario, String correo, String contraseña, int idRol, int idDepartamento) {
        String sql = "INSERT INTO fide_usuarios_tb (id_usuario, usuario, correo, contraseña, id_rol, id_departamento) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Establecer los valores para la inserción en la base de datos
            ps.setInt(1, idUsuario);           // ID Usuario
            ps.setString(2, nombreUsuario);    // Nombre de usuario
            ps.setString(3, correo);           // Correo
            ps.setString(4, contraseña);       // Contraseña
            ps.setInt(5, idRol);               // ID Rol
            ps.setInt(6, idDepartamento);      // ID Departamento

            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                System.out.println("Usuario agregado exitosamente: " + nombreUsuario);
                return true;
            } else {
                System.out.println("Error al agregar usuario.");
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("Error al agregar el usuario: " + e.getMessage());
            return false;
        }
    }
}











