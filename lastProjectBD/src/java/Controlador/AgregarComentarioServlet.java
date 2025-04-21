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

@WebServlet("/AgregarComentarioServlet")
public class AgregarComentarioServlet extends HttpServlet {

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
                    if (cs != null) cs.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            request.setAttribute("error", "No se pudo conectar a la base de datos");
        }

        request.getRequestDispatcher("contacto.jsp").forward(request, response);
    }
}

