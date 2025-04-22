package Controlador;

import Modelo.Comentario;
import Modelo.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AgregarComentarioServlet")
public class AgregarComentarioServlet extends HttpServlet {

    // Maneja las peticiones POST (agregar comentarios)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String contenido = request.getParameter("contenido");

        if (contenido == null || contenido.trim().isEmpty()) {
            request.setAttribute("error", "El comentario no puede estar vacío");
            request.getRequestDispatcher("comentarios.jsp").forward(request, response);
            return;
        }

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call proyectomain_pck.INSERTAR_COMENTARIO_SP(?)}";
                cs = conn.prepareCall(sql);
                cs.setString(1, contenido);
                cs.execute();

                // Mensaje de éxito
                request.setAttribute("success", "Comentario agregado correctamente.");

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al agregar el comentario");
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
            request.setAttribute("error", "No se pudo conectar a la base de datos");
        }

        // Obtener los comentarios actualizados desde la vista
        List<Comentario> comentarios = obtenerComentarios();
        request.setAttribute("comentarios", comentarios);

        // Redirigir a comentarios.jsp con los datos cargados
        request.getRequestDispatcher("contacto.jsp").forward(request, response);
    }

    // Maneja las peticiones GET (ver comentarios)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener los comentarios desde la base de datos
        List<Comentario> comentarios = obtenerComentarios();

        // Colocar los comentarios en el request para ser mostrados en el JSP
        request.setAttribute("comentarios", comentarios);

        // Redirigir a la página de comentarios (comentarios.jsp)
        request.getRequestDispatcher("comentarios.jsp").forward(request, response);
    }

    private List<Comentario> obtenerComentarios() {
        List<Comentario> comentarios = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT contenido, fecha_comentario FROM comentarios_View";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Comentario comentario = new Comentario();
                comentario.setContenido(rs.getString("contenido"));
                comentario.setFechaComentario(rs.getDate("fecha_comentario"));
                comentarios.add(comentario);
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
        return comentarios;
    }
}
