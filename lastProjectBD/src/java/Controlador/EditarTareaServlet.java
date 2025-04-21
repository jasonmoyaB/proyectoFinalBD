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
import Modelo.Tarea;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/EditarTareaServlet")
public class EditarTareaServlet extends HttpServlet {

    // GET: Carga los datos de la tarea y redirige al formulario
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        Tarea tarea = null;

        try {
            String sql = "SELECT * FROM tarea WHERE tarea_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, tareaId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                tarea = new Tarea();
                tarea.setTareaId(rs.getInt("tarea_id"));
                tarea.setNombre(rs.getString("nombre_tarea"));
                tarea.setDescripcion(rs.getString("descripcion"));
                tarea.setEstado(rs.getString("estado"));
                tarea.setFechaLimite(rs.getDate("fecha_limite"));
                tarea.setProyectoId(rs.getInt("proyecto_id"));
                tarea.setUsuarioId(rs.getInt("usuario_id"));
            }

            ps.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (tarea != null) {
            request.setAttribute("tarea", tarea);
            request.getRequestDispatcher("editarTarea.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "No se encontró la tarea con ID: " + tareaId);
            request.getRequestDispatcher("taskList.jsp").forward(request, response);
        }
    }

    // POST: Guarda los cambios hechos a la tarea
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int tareaId = Integer.parseInt(request.getParameter("tareaId"));
        int proyectoId = Integer.parseInt(request.getParameter("projectId"));
        String nombre = request.getParameter("taskName");
        String descripcion = request.getParameter("description");
        String estado = request.getParameter("estado");
        String fechaLimiteStr = request.getParameter("fechaLimite");

        java.sql.Date fechaLimite;
        try {
            fechaLimite = java.sql.Date.valueOf(fechaLimiteStr);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Fecha límite inválida");
            request.getRequestDispatcher("editarTarea.jsp").forward(request, response);
            return;
        }

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call proyectomain_pck.actualizar_tarea(?, ?, ?, ?, ?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, tareaId);
                cs.setString(2, nombre);
                cs.setString(3, descripcion);
                cs.setString(4, estado);
                cs.setDate(5, fechaLimite);

                cs.execute();
                request.setAttribute("msg", "Tarea actualizada correctamente");

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al actualizar la tarea");
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
