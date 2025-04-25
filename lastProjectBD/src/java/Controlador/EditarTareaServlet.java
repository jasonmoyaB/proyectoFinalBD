package Controlador;

import Modelo.Conexion;
import Modelo.Tarea;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/EditarTareaServlet")
public class EditarTareaServlet extends HttpServlet {

    // GET: Carga la tarea seleccionada para edición
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idTareaParam = request.getParameter("id_tarea");

        if (idTareaParam == null || idTareaParam.isEmpty()) {
            request.setAttribute("error", "El ID de la tarea no está disponible.");
            request.getRequestDispatcher("addTarea.jsp").forward(request, response);
            return;
        }

        int idTarea = Integer.parseInt(idTareaParam);
        Conexion conexion = new Conexion();

        String sql = "SELECT ID_TAREA, NOMBRE_TAREA, DESCRIPCION, ESTADO, FECHA_LIMITE FROM tarea_completa_crud_V WHERE ID_TAREA = ?";

        try (Connection conn = conexion.conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idTarea);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Tarea tarea = new Tarea();
                tarea.setIdTarea(rs.getInt("ID_TAREA"));
                tarea.setNombreTarea(rs.getString("NOMBRE_TAREA"));
                tarea.setDescripcion(rs.getString("DESCRIPCION"));
                tarea.setEstado(rs.getString("ESTADO"));
                tarea.setFechaLimite(rs.getDate("FECHA_LIMITE"));

                request.setAttribute("tarea", tarea);
                request.getRequestDispatcher("editarTarea.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Tarea no encontrada.");
                request.getRequestDispatcher("addTarea.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar la tarea.");
            request.getRequestDispatcher("addTarea.jsp").forward(request, response);
        }
    }

    // POST: Actualiza la tarea
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idTarea = Integer.parseInt(request.getParameter("id_tarea"));
        String nombreTarea = request.getParameter("nombre_tarea");
        String descripcion = request.getParameter("descripcion");
        String estado = request.getParameter("estado");
        String fechaLimiteStr = request.getParameter("fecha_limite");

        Date fechaLimite = null;
        if (fechaLimiteStr != null && !fechaLimiteStr.trim().isEmpty()) {
            try {
                fechaLimite = Date.valueOf(fechaLimiteStr);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Fecha límite inválida.");
                request.getRequestDispatcher("editarTarea.jsp").forward(request, response);
                return;
            }
        }

        Conexion conexion = new Conexion();
        try (Connection conn = conexion.conectar()) {
            if (conn != null) {
                String sql = "{call proyectomain_pck.actualizar_tarea(?, ?, ?, ?, ?)}";
                try (CallableStatement cs = conn.prepareCall(sql)) {
                    cs.setInt(1, idTarea);
                    cs.setString(2, nombreTarea);
                    cs.setString(3, descripcion);
                    cs.setString(4, estado);
                    cs.setDate(5, fechaLimite);
                    cs.execute();
                    request.setAttribute("msg", "Tarea actualizada correctamente.");
                }
            } else {
                request.setAttribute("error", "No se pudo conectar a la base de datos.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al actualizar la tarea.");
        }

        List<Tarea> tareas = obtenerTareas();
        request.setAttribute("tareas", tareas);
        request.getRequestDispatcher("addTask.jsp").forward(request, response);
    }

    private List<Tarea> obtenerTareas() {
        List<Tarea> tareas = new ArrayList<>();
        String sql = "SELECT ID_TAREA, NOMBRE_TAREA, DESCRIPCION, ESTADO, FECHA_LIMITE FROM tarea_completa_crud_V";
        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Tarea tarea = new Tarea();
                tarea.setIdTarea(rs.getInt("ID_TAREA"));
                tarea.setNombreTarea(rs.getString("NOMBRE_TAREA"));
                tarea.setDescripcion(rs.getString("DESCRIPCION"));
                tarea.setEstado(rs.getString("ESTADO"));
                tarea.setFechaLimite(rs.getDate("FECHA_LIMITE"));
                tareas.add(tarea);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tareas;
    }
}
