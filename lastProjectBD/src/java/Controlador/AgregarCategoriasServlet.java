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

@WebServlet("/AgregarCategoriasServlet")
public class AgregarCategoriasServlet extends HttpServlet {

    private List<Categoria> obtenerCategorias() {
        List<Categoria> categorias = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT id_categoria, nombre_categoria, nombre_proyecto FROM categoria_proyecto_crud_V";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Categoria categoria = new Categoria();
                categoria.setId_categoria(rs.getInt("id_categoria"));
                categoria.setNombre_categoria(rs.getString("nombre_categoria"));
                categoria.setNombre_proyecto(rs.getString("nombre_proyecto"));
                categorias.add(categoria);
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
        return categorias;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Categoria> categorias = obtenerCategorias();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("addCategoria.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String idProyectoStr = request.getParameter("id_proyecto");

        Integer idProyecto = null;

        if (idProyectoStr != null && !idProyectoStr.trim().isEmpty()) {
            try {
                idProyecto = Integer.parseInt(idProyectoStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID Proyecto debe ser un número válido");
                request.getRequestDispatcher("addCategoria.jsp").forward(request, response);
                return;
            }
        }

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call proyectoMain_pck.insertar_categoria(?, ?)}";
                cs = conn.prepareCall(sql);

                cs.setString(1, nombre);
                cs.setInt(2, idProyecto != null ? idProyecto : 0);

                cs.execute();
                

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "No se pudo agregar la categoría");
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

        List<Categoria> categorias = obtenerCategorias();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("addCategoria.jsp").forward(request, response);
    }
}
