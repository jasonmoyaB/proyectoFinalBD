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

@WebServlet("/EditarUsuarioServlet")
public class EditarUsuarioServlet extends HttpServlet {

    // Método doGet para obtener los datos del usuario a editar
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idUsuarioParam = request.getParameter("id_usuario");

        // Verificar si el parámetro id_usuario está presente y no es vacío
        if (idUsuarioParam == null || idUsuarioParam.isEmpty()) {
            request.setAttribute("error", "El ID del usuario no está disponible.");
            request.getRequestDispatcher("addUsers.jsp").forward(request, response);
            return;
        }

        int idUsuario = Integer.parseInt(idUsuarioParam);

        // Obtener los datos del usuario desde la base de datos
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();
        String sql = "SELECT * FROM usuario_completo_CRUD WHERE ID_USUARIO = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Llenamos los datos del usuario en el request
                Usuario usuario = new Usuario();
                usuario.setId_usuario(rs.getInt("ID_USUARIO"));
                usuario.setNombre(rs.getString("NOMBRE"));
                usuario.setCorreo(rs.getString("CORREO"));
                usuario.setContraseña(rs.getString("CONTRASEÑA"));
                usuario.setNombreRol(rs.getString("NOMBRE_ROL"));
                usuario.setNombreDepartamento(rs.getString("NOMBRE_DEPARTAMENTO"));

                request.setAttribute("usuario", usuario);
                request.getRequestDispatcher("editarUsuario.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Usuario no encontrado.");
                request.getRequestDispatcher("addUsers.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar los datos del usuario.");
            request.getRequestDispatcher("addUsers.jsp").forward(request, response);
        }
    }

    // Método doPost para actualizar los datos del usuario
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String contraseña = request.getParameter("password");
        String nombreRol = request.getParameter("rol");  // Aquí usamos el nombre del rol
        String nombreDepartamento = request.getParameter("departamento");  // Usamos el nombre del departamento

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamamos al procedimiento almacenado para actualizar el usuario
                String sql = "{call proyectomain_pck.actualizar_usuario(?, ?, ?, ?, ?, ?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, idUsuario);
                cs.setString(2, nombre);
                cs.setString(3, correo);
                cs.setString(4, contraseña);
                cs.setString(5, nombreRol);  // Actualizamos con el nombre del rol
                cs.setString(6, nombreDepartamento);  // Usamos el nombre del departamento
                cs.execute();

                request.setAttribute("msg", "Usuario actualizado correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al actualizar el usuario");
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

        // Recargar los usuarios actualizados
        List<Usuario> usuarios = obtenerUsuarios();
        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("addUsers.jsp").forward(request, response);
    }

    // Método auxiliar para obtener los usuarios desde la base de datos
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
                    usuario.setId_usuario(rs.getInt("ID_USUARIO"));
                    usuario.setNombre(rs.getString("NOMBRE"));
                    usuario.setCorreo(rs.getString("CORREO"));
                    usuario.setContraseña(rs.getString("CONTRASEÑA"));
                    usuario.setNombreRol(rs.getString("NOMBRE_ROL"));
                    usuario.setNombreDepartamento(rs.getString("NOMBRE_DEPARTAMENTO"));
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
