package Controlador;

import Modelo.Conexion;
import Modelo.Categoria;  // Asegúrate de que la clase Categoria esté definida correctamente
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/EliminarCategoriaServlet")
public class EliminarCategoriaServlet extends HttpServlet {

    // Método para eliminar la categoría
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCategoria = Integer.parseInt(request.getParameter("id_categoria"));

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamamos al procedimiento almacenado para eliminar la categoría
                String sql = "{call proyectomain_pck.eliminar_categoria(?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, idCategoria);  // Pasamos el idCategoria como parámetro
                cs.execute();  // Ejecutamos el procedimiento almacenado

                request.setAttribute("msg", "Categoría eliminada correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al eliminar la categoría: " + e.getMessage());
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

        // Obtener las categorías actualizadas y pasarlas a la vista
        List<Categoria> categorias = obtenerCategorias();
        request.setAttribute("categorias", categorias);
        request.getRequestDispatcher("addCategoria.jsp").forward(request, response);
    }

    // Método auxiliar para obtener las categorías desde la base de datos
    private List<Categoria> obtenerCategorias() {
        List<Categoria> categorias = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT ID_CATEGORIA, NOMBRE_CATEGORIA, NOMBRE_PROYECTO FROM categoria_proyecto_crud_V"; // Asegúrate de que el nombre de la vista sea correcto
        try {
            conn = conexion.conectar();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Categoria categoria = new Categoria();
                    categoria.setId_categoria(rs.getInt("ID_CATEGORIA"));  // Columna ID_CATEGORIA
                    categoria.setNombre_categoria(rs.getString("NOMBRE_CATEGORIA"));  // Columna NOMBRE_CATEGORIA
                    categoria.setNombre_proyecto(rs.getString("NOMBRE_PROYECTO"));  // Columna NOMBRE_PROYECTO
                    categorias.add(categoria);
                }
            } else {
                System.out.println("No se pudo establecer la conexión a la base de datos.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return categorias;
    }
}