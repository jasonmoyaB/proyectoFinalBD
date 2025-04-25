package Controlador;

import Modelo.Tarea;
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

@WebServlet("/AgregarTareasServlet")
public class AgregarTareasServlet extends HttpServlet {

    private List<Tarea> obtenerTareas() {
        List<Tarea> tareas = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT id_tarea, nombre_tarea, descripcion, estado, fecha_limite FROM tarea_completa_crud_V";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Tarea tarea = new Tarea();
                tarea.setIdTarea(rs.getInt("id_tarea"));
                tarea.setNombreTarea(rs.getString("nombre_tarea"));
                tarea.setDescripcion(rs.getString("descripcion"));
                tarea.setEstado(rs.getString("estado"));
                tarea.setFechaLimite(rs.getDate("fecha_limite"));
                tareas.add(tarea);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return tareas;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Tarea> tareas = obtenerTareas();
        request.setAttribute("tareas", tareas);
        request.getRequestDispatcher("addTask.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreTarea = request.getParameter("nombre_tarea");
        String descripcion = request.getParameter("descripcion");
        String estado = request.getParameter("estado");
        String fechaLimiteStr = request.getParameter("fecha_limite");

        Date fechaLimite = null;

        // Validar y convertir la fecha
        if (fechaLimiteStr != null && !fechaLimiteStr.trim().isEmpty()) {
            try {
                fechaLimite = Date.valueOf(fechaLimiteStr);
            } catch (IllegalArgumentException e) {
                request.setAttribute("error", "Fecha límite no es válida");
                request.getRequestDispatcher("addTask.jsp").forward(request, response);
                return;
            }
        }

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamada al procedimiento almacenado
                String sql = "{call proyectoMain_pck.insertar_tarea(?, ?, ?, ?)}";
                cs = conn.prepareCall(sql);

                cs.setString(1, nombreTarea);
                cs.setString(2, descripcion);
                cs.setString(3, estado);
                cs.setDate(4, fechaLimite);

                cs.execute();

                // Redirigir con mensaje de éxito
                request.setAttribute("msg", "Tarea agregada con éxito");

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "No se pudo agregar la tarea");
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

        // Obtener nuevamente las tareas y redirigir al JSP con el mensaje
        List<Tarea> tareas = obtenerTareas();
        request.setAttribute("tareas", tareas);
        request.getRequestDispatcher("addTask.jsp").forward(request, response);
    }
}