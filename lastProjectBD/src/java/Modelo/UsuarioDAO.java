package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {
    Conexion conexion = new Conexion();

    // Método para validar usuario
    public boolean validarUsuario(String username, String password) {
        String sql = "SELECT * FROM fide_usuarios_tb WHERE usuario = ? AND contraseña = ?";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                System.out.println("Usuario validado correctamente: " + username);
                return true;
            } else {
                System.out.println("Error: Usuario o contraseña incorrectos.");
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error en la validación del usuario: " + e.getMessage());
            return false;
        }
    }

    // Método para obtener el rol de un usuario
    public String obtenerRolUsuario(String username, String password) {
        String sql = "SELECT r.nombre_rol FROM fide_usuarios_tb u " +
                     "JOIN fide_roles_tb r ON u.id_rol = r.id_rol " +
                     "WHERE u.usuario = ? AND u.contraseña = ?";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
             
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String rol = rs.getString("nombre_rol");
                System.out.println("Rol obtenido: " + rol);
                return rol;
            } else {
                System.out.println("No se encontró rol para el usuario: " + username);
                return null;
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error al obtener el rol del usuario: " + e.getMessage());
            return null;
        }
    }

    // Método para agregar un nuevo usuario
    public boolean agregarUsuario(String nombreUsuario, String correo, String contraseña, String rol, int idRol, int idDepartamento) {
        String sql = "INSERT INTO fide_usuarios_tb (usuario, correo, contraseña, id_rol, id_departamento) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Establecer los valores para la inserción en la base de datos
            ps.setString(1, nombreUsuario);      // Nombre de usuario
            ps.setString(2, correo);             // Correo
            ps.setString(3, contraseña);        // Contraseña
            ps.setInt(4, idRol);                // ID Rol
            ps.setInt(5, idDepartamento);       // ID Departamento
            
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











