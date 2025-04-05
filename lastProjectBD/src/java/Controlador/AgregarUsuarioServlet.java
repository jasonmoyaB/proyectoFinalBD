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
    private List<Usuario> obtenerUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT * FROM usuario_completo_CRUD_V"; // Usando la vista en lugar de la tabla
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
        try {
            // Obtener parámetros del formulario
            String idUsuarioParam = request.getParameter("id_usuario");
            String rolParam = request.getParameter("rol");
            String departamentoParam = request.getParameter("departamento");

            // Comprobar si los parámetros son nulos o vacíos antes de parsearlos
            int idUsuario = (idUsuarioParam != null && !idUsuarioParam.isEmpty()) ? Integer.parseInt(idUsuarioParam) : 0;
            String nombre = request.getParameter("nombre");
            String correo = request.getParameter("correo");
            String contraseña = request.getParameter("password");
            int idRol = (rolParam != null && !rolParam.isEmpty()) ? Integer.parseInt(rolParam) : 0;
            int idDepartamento = (departamentoParam != null && !departamentoParam.isEmpty()) ? Integer.parseInt(departamentoParam) : 0;

            // Conectar a la BD
            Conexion conexion = new Conexion();
            Connection conn = conexion.conectar();

            if (conn != null) {
                CallableStatement cs = null;
                try {
                    // Llamar al procedimiento almacenado
                    String sql = "{call proyectomain_pck.INSERTAR_USUARIOS(?, ?, ?, ?, ?)}";
                    cs = conn.prepareCall(sql);

                    cs.setString(1, nombre);
                    cs.setString(2, correo);
                    cs.setString(3, contraseña);
                    cs.setInt(4, idRol);
                    cs.setInt(5, idDepartamento);

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

        } catch (NumberFormatException e) {
            // Manejar el caso en que no se pueda parsear un número
            e.printStackTrace();
            request.setAttribute("error", "Hubo un error con los datos proporcionados.");
            request.getRequestDispatcher("addUsers.jsp").forward(request, response);
        }
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
