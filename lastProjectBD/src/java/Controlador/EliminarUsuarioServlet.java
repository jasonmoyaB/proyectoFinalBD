package Controlador;

import Modelo.Conexion;
import Modelo.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/EliminarUsuarioServlet")
public class EliminarUsuarioServlet extends HttpServlet {

    // Método para eliminar el usuario
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamamos al procedimiento almacenado para eliminar el usuario
                String sql = "{call proyectomain_pck.eliminar_usuario(?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, idUsuario);
                cs.execute();
                request.setAttribute("msg", "Usuario eliminado correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al eliminar el usuario");
            } finally {
                try {
                    if (cs != null) {
                        cs.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            request.setAttribute("error", "No hay conexión con la base de datos");
        }

        // Obtener los usuarios actualizados y pasarlos a la vista
        List<Usuario> usuarios = obtenerUsuarios();
        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("addUsers.jsp").forward(request, response);
    }

    // Método auxiliar para obtener los usuarios actualizados desde la base de datos
    private List<Usuario> obtenerUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM usuario_completo_CRUD"; // Usando la vista en lugar de la tabla
        try {
            conn = conexion.conectar();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setId_usuario(rs.getInt("id_usuario"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setCorreo(rs.getString("correo"));
                    usuario.setContraseña(rs.getString("contraseña"));
                    usuario.setNombreRol(rs.getString("nombre_rol"));
                    usuario.setNombreDepartamento(rs.getString("nombre_departamento"));
                    usuarios.add(usuario);
                }
            } else {
                System.out.println("No se pudo establecer la conexión a la base de datos.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Asegúrate de cerrar los recursos correctamente
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return usuarios;
    }
}
