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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AgregarTareasServlet")
public class AgregarTareasServlet extends HttpServlet {

    // Método para obtener tareas por proyecto
    private List<Tarea> obtenerTareas(int proyectoId) {
        List<Tarea> tareas = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT * FROM fide_tareas_tb";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, proyectoId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tarea tarea = new Tarea();
                tarea.setTareaId(rs.getInt("TAREA_ID"));
                tarea.setNombre(rs.getString("NOMBRE_TAREA"));
                tarea.setDescripcion(rs.getString("DESCRIPCION"));
                tarea.setFechaLimite(rs.getDate("FECHA_LIMITE"));
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

    // Método principal POST para agregar tarea
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener parámetros del formulario
        String nombre = request.getParameter("taskName");
        String descripcion = request.getParameter("description");
        String fechaLimiteStr = request.getParameter("fechaLimite");

        // Validar y convertir parámetros
        int proyectoId = 0;
        int usuarioId = 0;
        long tiempoDedicado = 0;
        Date fechaLimite = null;

        try {
            fechaLimite = Date.valueOf(fechaLimiteStr); // yyyy-MM-dd
        } catch (Exception e) {
            request.setAttribute("error", "Parámetros inválidos o incompletos.");
            request.getRequestDispatcher("addTask.jsp").forward(request, response);
            return;
        }

        // Conexión a la base de datos
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call insertar_tarea(?, ?, ?)}";
                cs = conn.prepareCall(sql);
                cs.setString(1, nombre);
                cs.setString(2, descripcion);
                cs.setDate(4, fechaLimite);

                cs.execute();

                request.setAttribute("msg", "Tarea agregada exitosamente");

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al insertar la tarea en la base de datos");
            } finally {
                try {
                    if (cs != null) cs.close();
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            request.setAttribute("error", "No se pudo conectar a la base de datos");
        }

        // Obtener tareas actualizadas y redirigir
        List<Tarea> tareas = obtenerTareas(proyectoId);
        request.setAttribute("tareas", tareas);
        request.setAttribute("proyectoId", proyectoId);

        request.getRequestDispatcher("addTask.jsp").forward(request, response);
    }
}

