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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AgregarProyectoServlet")
public class AgregarProyectoServlet extends HttpServlet {

    private List<Proyecto> obtenerProyectos() {
        List<Proyecto> proyectos = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT * FROM fide_proyectos_tb";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Proyecto proyecto = new Proyecto();
                proyecto.setId_proyecto(rs.getInt("id_proyecto"));
                proyecto.setNombre(rs.getString("nombre_proyecto"));
                proyecto.setDescripcion(rs.getString("descripcion"));
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

    private List<Proyecto> buscarProyectos(String search) {
        List<Proyecto> proyectos = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT * FROM fide_proyectos_tb WHERE LOWER(nombre_proyecto) LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + search.toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Proyecto proyecto = new Proyecto();
                proyecto.setId_proyecto(rs.getInt("id_proyecto"));
                proyecto.setNombre(rs.getString("nombre_proyecto"));
                proyecto.setDescripcion(rs.getString("descripcion"));
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

    // Buscar proyectos con GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");

        List<Proyecto> proyectos;
        if (search != null && !search.trim().isEmpty()) {
            proyectos = buscarProyectos(search);
        } else {
            proyectos = obtenerProyectos();
        }

        request.setAttribute("proyectos", proyectos);
        request.getRequestDispatcher("addProyects.jsp").forward(request, response);
    }

    // Agregar proyecto con POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idProyectoStr = request.getParameter("id_proyecto");
        String nombre = request.getParameter("nombre_proyecto");
        String descripcion = request.getParameter("descripcion");
        
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

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call insertar_proyectos(?, ?)}";
                cs = conn.prepareCall(sql);

                cs.setString(1, nombre);
                cs.setString(2, descripcion);
                

                cs.execute();
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

        List<Proyecto> proyectos = obtenerProyectos();
        request.setAttribute("proyectos", proyectos);
        request.getRequestDispatcher("addProjects.jsp").forward(request, response);
    }
}
