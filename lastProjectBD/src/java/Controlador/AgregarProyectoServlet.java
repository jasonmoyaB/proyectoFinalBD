package Controlador;

import Modelo.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/AgregarProyectoServlet")
public class AgregarProyectoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String fechaInicio = request.getParameter("fechaInicio");
        String fechaFin = request.getParameter("fechaFin");
        String estado = request.getParameter("estado");

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call proyectomain_pck.agregar_proyecto(?, ?, ?, ?, ?)}"; // Procedimiento almacenado
                cs = conn.prepareCall(sql);
                cs.setString(1, nombre);
                cs.setString(2, descripcion);
                cs.setString(3, fechaInicio);
                cs.setString(4, fechaFin);
                cs.setString(5, estado);
                cs.execute();
                request.setAttribute("msg", "Proyecto agregado correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al agregar el proyecto");
            } finally {
                try {
                    if (cs != null) cs.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            request.setAttribute("error", "No hay conexión con la base de datos");
        }

        request.getRequestDispatcher("addProjects.jsp").forward(request, response);
    }
}