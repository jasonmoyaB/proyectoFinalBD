/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

/**
 *
 * @author adria
 */
import Modelo.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/EliminarTareaServlet")
public class EliminarTareaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tareaIdStr = request.getParameter("tareaId");
        String proyectoIdStr = request.getParameter("projectId");

        if (tareaIdStr == null || proyectoIdStr == null) {
            request.setAttribute("error", "ID de tarea o proyecto no proporcionado.");
            request.getRequestDispatcher("taskList.jsp").forward(request, response);
            return;
        }

        int tareaId = Integer.parseInt(tareaIdStr);
        int proyectoId = Integer.parseInt(proyectoIdStr);

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call proyectomain_pck.eliminar_tarea(?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, tareaId);
                cs.execute();

                request.setAttribute("msg", "Tarea eliminada correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al eliminar la tarea");
            } finally {
                try {
                    if (cs != null) cs.close();
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        response.sendRedirect("taskList.jsp?projectId=" + proyectoId);
    }
}

