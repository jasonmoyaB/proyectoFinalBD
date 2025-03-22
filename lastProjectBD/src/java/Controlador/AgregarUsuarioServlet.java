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

@WebServlet("/AgregarUsuarioServlet")
public class AgregarUsuarioServlet extends HttpServlet {

    // Método para obtener los usuarios desde la base de datos
    // Método para obtener los usuarios desde la base de datos
    private List<Usuario> obtenerUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT * FROM usuario_completo_CRUD"; // Usando la vista en lugar de la tabla
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

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
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return usuarios;
    }

    // Método para manejar la solicitud POST (agregar un usuario)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener parámetros del formulario
        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String contraseña = request.getParameter("password");
        int idRol = Integer.parseInt(request.getParameter("rol"));
        int idDepartamento = Integer.parseInt(request.getParameter("departamento"));

        // Conectar a la BD
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamar al procedimiento almacenado
                String sql = "{call INSERTAR_USUARIOS(?, ?, ?, ?, ?, ?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, idUsuario);
                cs.setString(2, nombre);
                cs.setString(3, correo);
                cs.setString(4, contraseña);
                cs.setInt(5, idRol);
                cs.setInt(6, idDepartamento);

                // Ejecutar el procedimiento
                cs.execute();

                // Agregar el mensaje de éxito
                request.setAttribute("msg", "Usuario agregado");

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "No se pudo agregar el usuario");
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

        // Obtener los usuarios de la base de datos y agregar al request
        List<Usuario> usuarios = obtenerUsuarios();
        request.setAttribute("usuarios", usuarios);

        // Redirigir al JSP con los datos actualizados
        request.getRequestDispatcher("addUsers.jsp").forward(request, response);
    }

    // Método para manejar la solicitud GET (mostrar usuarios)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los usuarios de la base de datos y agregar al request
        List<Usuario> usuarios = obtenerUsuarios();
        request.setAttribute("usuarios", usuarios);

        // Redirigir al JSP
        request.getRequestDispatcher("addUsers.jsp").forward(request, response);
    }
}
