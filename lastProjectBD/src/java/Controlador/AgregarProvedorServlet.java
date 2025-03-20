
package Controlador;

import Modelo.Proveedor;
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

@WebServlet("/AgregarProvedorServlet")
public class AgregarProvedorServlet extends HttpServlet {

    private List<Proveedor> obtenerProveedores() {
        List<Proveedor> proveedores = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT * FROM fide_proveedores_tb";
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Proveedor proveedor = new Proveedor();
                proveedor.setId_proveedor(rs.getInt("id_proveedor"));
                proveedor.setNombre(rs.getString("nombre_proveedor"));
                proveedor.setContacto(rs.getString("contacto"));
                proveedor.setTelefono(rs.getString("telefono"));
                proveedores.add(proveedor);
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
        return proveedores;
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idProveedorStr = request.getParameter("id_proveedor");
        String nombre = request.getParameter("nombre");
        String contacto = request.getParameter("contacto");
        String telefono = request.getParameter("telefono");

        Integer idProveedor = null;
        if (idProveedorStr != null && !idProveedorStr.trim().isEmpty()) {
            try {
                idProveedor = Integer.parseInt(idProveedorStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID Proveedor debe ser un número válido");
                request.getRequestDispatcher("addSuppliers.jsp").forward(request, response);
                return;
            }
        }

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call insertar_proveedores(?, ?, ?, ?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, idProveedor != null ? idProveedor : 0);
                cs.setString(2, nombre);
                cs.setString(3, contacto);
                cs.setString(4, telefono);

                cs.execute();
                request.setAttribute("msg", "Proveedor agregado");


            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "No se pudo agregar el proveedor");
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

        List<Proveedor> proveedores = obtenerProveedores();
        request.setAttribute("proveedores", proveedores);
        request.getRequestDispatcher("addSuppliers.jsp").forward(request, response);
    }
}
