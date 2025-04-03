package Controlador;

import Modelo.Conexion;
import Modelo.Proveedor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/EditarProveedorServlet")
public class EditarProveedorServlet extends HttpServlet {

    // Método doGet para obtener los datos del proveedor a editar
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idProveedorParam = request.getParameter("id_proveedor");

        // Verificar si el parámetro id_proveedor está presente y no es vacío
        if (idProveedorParam == null || idProveedorParam.isEmpty()) {
            request.setAttribute("error", "El ID del proveedor no está disponible.");
            request.getRequestDispatcher("addSuppliers.jsp").forward(request, response);
            return;
        }

        int idProveedor = -1;
        try {
            idProveedor = Integer.parseInt(idProveedorParam); // Validación de tipo de dato
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID del proveedor inválido.");
            request.getRequestDispatcher("addSuppliers.jsp").forward(request, response);
            return;
        }

        // Obtener los datos del proveedor desde la base de datos
        Conexion conexion = new Conexion();
        String sql = "SELECT * FROM fide_proveedores_tb WHERE ID_PROVEEDOR = ?";
        
        try (Connection conn = conexion.conectar(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idProveedor);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Llenamos los datos del proveedor en el request
                Proveedor proveedor = new Proveedor();
                proveedor.setId_proveedor(rs.getInt("ID_PROVEEDOR"));
                proveedor.setNombre(rs.getString("NOMBRE_PROVEEDOR"));
                proveedor.setContacto(rs.getString("CONTACTO"));
                proveedor.setTelefono(rs.getString("TELEFONO"));

                request.setAttribute("proveedor", proveedor);
                request.getRequestDispatcher("editarProveedor.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Proveedor no encontrado.");
                request.getRequestDispatcher("addSuppliers.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar los datos del proveedor.");
            request.getRequestDispatcher("addSuppliers.jsp").forward(request, response);
        }
    }

    // Método doPost para actualizar los datos del proveedor
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProveedor = Integer.parseInt(request.getParameter("id_proveedor"));
        String nombre = request.getParameter("nombre");
        String contacto = request.getParameter("contacto");
        String telefono = request.getParameter("telefono");

        Conexion conexion = new Conexion();

        // Validar la conexión
        try (Connection conn = conexion.conectar()) {
            if (conn != null) {
                try (CallableStatement cs = conn.prepareCall("{call proyectomain_pck.actualizar_proveedor(?, ?, ?, ?)}")) {
                    cs.setInt(1, idProveedor);
                    cs.setString(2, nombre);
                    cs.setString(3, contacto);
                    cs.setString(4, telefono);
                    cs.execute();
                    request.setAttribute("msg", "Proveedor actualizado correctamente");
                } catch (SQLException e) {
                    e.printStackTrace();
                    request.setAttribute("error", "Error al actualizar el proveedor");
                }
            } else {
                request.setAttribute("error", "No hay conexión con la base de datos");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error en la conexión a la base de datos");
        }

        // Recargar los proveedores actualizados
        List<Proveedor> proveedores = obtenerProveedores();
        request.setAttribute("proveedores", proveedores);
        request.getRequestDispatcher("addSuppliers.jsp").forward(request, response);
    }

    // Método auxiliar para obtener los proveedores desde la base de datos
    private List<Proveedor> obtenerProveedores() {
        List<Proveedor> proveedores = new ArrayList<>();
        Conexion conexion = new Conexion();
        String sql = "SELECT * FROM fide_proveedores_tb";
        
        try (Connection conn = conexion.conectar(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Proveedor proveedor = new Proveedor();
                proveedor.setId_proveedor(rs.getInt("ID_PROVEEDOR"));
                proveedor.setNombre(rs.getString("NOMBRE_PROVEEDOR"));
                proveedor.setContacto(rs.getString("CONTACTO"));
                proveedor.setTelefono(rs.getString("TELEFONO"));
                proveedores.add(proveedor);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return proveedores;
    }
}
