
package Controlador;

import Modelo.Categoria;
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

@WebServlet("/EditarCategoriaServlet")
public class EditarCategoriaServlet extends HttpServlet {

    // GET: Carga la categoría seleccionada para edición
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idCategoriaParam = request.getParameter("id_categoria");

        if (idCategoriaParam == null || idCategoriaParam.isEmpty()) {
            request.setAttribute("error", "El ID de la categoría no está disponible.");
            request.getRequestDispatcher("addCategoria.jsp").forward(request, response);
            return;
        }

        int idCategoria = Integer.parseInt(idCategoriaParam);
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT ID_CATEGORIA, NOMBRE_CATEGORIA, NOMBRE_PROYECTO FROM categoria_proyecto_crud_V WHERE ID_CATEGORIA = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idCategoria);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId_categoria(rs.getInt("ID_CATEGORIA"));
                categoria.setNombre_categoria(rs.getString("NOMBRE_CATEGORIA"));
                categoria.setNombre_proyecto(rs.getString("NOMBRE_PROYECTO"));

                request.setAttribute("categoria", categoria);
                request.getRequestDispatcher("editarCategoria.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Categoría no encontrada.");
                request.getRequestDispatcher("addCategoria.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar la categoría.");
            request.getRequestDispatcher("addCategoria.jsp").forward(request, response);
        }
    }

    // POST: Actualiza la categoría
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));
        String nombreCategoria = request.getParameter("nombre");
        String nombreProyecto = request.getParameter("nombre_proyecto");

        int idProyecto = obtenerIdProyecto(nombreProyecto);

        Conexion conexion = new Conexion();
        try (Connection conn = conexion.conectar()) {
            if (conn != null) {
                String sql = "{call proyectomain_pck.actualizar_categoria(?, ?, ?)}";
                try (CallableStatement cs = conn.prepareCall(sql)) {
                    cs.setInt(1, idCategoria);
                    cs.setString(2, nombreCategoria);
                    cs.setInt(3, idProyecto);
                    cs.execute();
                    request.setAttribute("msg", "Categoría actualizada correctamente.");
                }
            } else {
                request.setAttribute("error", "No se pudo conectar a la base de datos.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al actualizar la categoría.");
        }

        List<Categoria> categorias = obtenerCategorias();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("addCategoria.jsp").forward(request, response);
    }

    private int obtenerIdProyecto(String nombreProyecto) {
        int idProyecto = -1;
        String sql = "SELECT ID_PROYECTO FROM fide_proyectos_tb WHERE NOMBRE_PROYECTO = ?";
        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, nombreProyecto);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                idProyecto = rs.getInt("ID_PROYECTO");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return idProyecto;
    }

    private List<Categoria> obtenerCategorias() {
        List<Categoria> categorias = new ArrayList<>();
        String sql = "SELECT ID_CATEGORIA, NOMBRE_CATEGORIA, NOMBRE_PROYECTO FROM categoria_proyecto_crud_V";
        try (Connection conn = new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId_categoria(rs.getInt("ID_CATEGORIA"));
                categoria.setNombre_categoria(rs.getString("NOMBRE_CATEGORIA"));
                categoria.setNombre_proyecto(rs.getString("NOMBRE_PROYECTO"));
                categorias.add(categoria);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categorias;
    }
}
