package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioDAO {
    Conexion conexion = new Conexion();

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

    public boolean agregarUsuario(String nombreUsuario, String correo, String contraseña, String rol) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}


