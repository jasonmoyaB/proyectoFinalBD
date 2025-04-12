package Controlador;

import Modelo.Proyecto;
import Modelo.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AgregarProyectoServlet")
public class AgregarProyectoServlet extends HttpServlet {

    // Método para obtener los proyectos desde la base de datos
    private List<Proyecto> obtenerProyectos() {
        List<Proyecto> proyectos = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT id_proyecto, nombre_proyecto, descripcion_proyecto, fechaInicio_p, fechaFin_p, estado_p, fechaCreacion_p FROM proyecto_completo_CRUD";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Proyecto proyecto = new Proyecto();
                proyecto.setId_proyecto(rs.getInt("id_proyecto"));
                proyecto.setNombre_proyecto(rs.getString("nombre_proyecto"));
                proyecto.setDescripcion_proyecto(rs.getString("descripcion_proyecto"));
                proyecto.setFechaInicio_p(rs.getDate("fechaInicio_p"));
                proyecto.setFechaFin_p(rs.getDate("fechaFin_p"));
                proyecto.setEstado_p(rs.getString("estado_p"));
                proyecto.setFechaCreacion_p(rs.getDate("fechaCreacion_p"));
                proyectos.add(proyecto);
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
        return proyectos;
    }

    // Método para manejar la solicitud POST (agregar un proyecto)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener parámetros del formulario
        String idProyectoStr = request.getParameter("id_proyecto");
        String nombre = request.getParameter("nombre_proyecto");
        String descripcion = request.getParameter("descripcion_proyecto");
        String fechaInicioStr = request.getParameter("fechaInicio_p");
        String fechaFinStr = request.getParameter("fechaFin_p");
        String estado = request.getParameter("estado_p");

        // Verificar si los parámetros son nulos o vacíos
        Integer idProyecto = null;

        if (idProyectoStr != null && !idProyectoStr.trim().isEmpty()) {
            try {
                idProyecto = Integer.parseInt(idProyectoStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID Proyecto debe ser un número válido");
                request.getRequestDispatcher("addProjects.jsp").forward(request, response);
                return;
            }
        }

        // Convertir fechas de String a java.sql.Date
        java.sql.Date fechaInicio = null;
        java.sql.Date fechaFin = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        
        try {
            if (fechaInicioStr != null && !fechaInicioStr.trim().isEmpty()) {
                fechaInicio = new java.sql.Date(sdf.parse(fechaInicioStr).getTime());
            }
            
            if (fechaFinStr != null && !fechaFinStr.trim().isEmpty()) {
                fechaFin = new java.sql.Date(sdf.parse(fechaFinStr).getTime());
            }
        } catch (ParseException e) {
            request.setAttribute("error", "Formato de fecha incorrecto. Use YYYY-MM-DD");
            request.getRequestDispatcher("addProjects.jsp").forward(request, response);
            return;
        }

        // Conectar a la BD
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamar al procedimiento almacenado
                String sql = "{call proyectomain_pck.insertar_proyecto(?, ?, ?, ?, ?)}";
                cs = conn.prepareCall(sql);
                
                cs.setString(1, nombre);
                cs.setString(2, descripcion);
                cs.setDate(3, fechaInicio);
                cs.setDate(4, fechaFin);
                cs.setString(5, estado);

                // Ejecutar el procedimiento
                cs.execute();

                // Agregar el mensaje de éxito
                request.setAttribute("msg", "Proyecto agregado");

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "No se pudo agregar el proyecto");
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

        // Obtener los proyectos de la base de datos y agregar al request
        List<Proyecto> proyectos = obtenerProyectos();
        request.setAttribute("proyectos", proyectos);

        // Redirigir al JSP con los datos actualizados
        request.getRequestDispatcher("addProjects.jsp").forward(request, response);
    }
}