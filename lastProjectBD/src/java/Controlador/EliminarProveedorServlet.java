package Controlador;

import Modelo.Conexion;
import Modelo.Proveedor;  // Asegúrate de tener la clase Proveedor
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/EliminarProveedorServlet")
public class EliminarProveedorServlet extends HttpServlet {

    // Método para eliminar el proveedor
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProveedor = Integer.parseInt(request.getParameter("id_proveedor"));

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamamos al procedimiento almacenado para eliminar el proveedor
                String sql = "{call eliminar_proveedor(?)}";  // Asegúrate de que el procedimiento almacenado esté disponible
                cs = conn.prepareCall(sql);
                cs.setInt(1, idProveedor);
                cs.execute();
                request.setAttribute("msg", "Proveedor eliminado correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al eliminar el proveedor");
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

        // Obtener los proveedores actualizados y pasarlos a la vista
        List<Proveedor> proveedores = obtenerProveedores();
        request.setAttribute("proveedores", proveedores);
        request.getRequestDispatcher("addSuppliers.jsp").forward(request, response);
    }

    // Método auxiliar para obtener los proveedores actualizados desde la base de datos
    private List<Proveedor> obtenerProveedores() {
        List<Proveedor> proveedores = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT ID_PROVEEDOR, NOMBRE_PROVEEDOR, CONTACTO, TELEFONO FROM fide_proveedores_tb";
        try {
            conn = conexion.conectar();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Proveedor proveedor = new Proveedor();  // Asegúrate de tener la clase Proveedor
                    proveedor.setId_proveedor(rs.getInt("id_proveedor"));
                    proveedor.setNombre(rs.getString("nombre_proveedor"));
                    proveedor.setContacto(rs.getString("contacto"));
                    proveedor.setTelefono(rs.getString("telefono"));
                    proveedores.add(proveedor);
                }
            } else {
                System.out.println("No se pudo establecer la conexión a la base de datos.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Asegúrate de cerrar los recursos correctamente
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
        return proveedores;
    }
}
