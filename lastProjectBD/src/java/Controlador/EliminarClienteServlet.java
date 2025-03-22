package Controlador;

import Modelo.Conexion;
import Modelo.Cliente;  // Asegúrate de que la clase Cliente esté definida correctamente
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/EliminarClienteServlet")
public class EliminarClienteServlet extends HttpServlet {

    // Método para eliminar el cliente
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCliente = Integer.parseInt(request.getParameter("id_cliente"));

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamamos al procedimiento almacenado para eliminar el cliente
                String sql = "{call eliminar_cliente(?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, idCliente);  // Pasamos el idCliente como parámetro
                cs.execute();  // Ejecutamos el procedimiento almacenado

                request.setAttribute("msg", "Cliente eliminado correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al eliminar el cliente: " + e.getMessage());
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

        // Obtener los clientes actualizados y pasarlos a la vista
        List<Cliente> clientes = obtenerClientes();
        request.setAttribute("clientes", clientes);
        request.getRequestDispatcher("addCostumers.jsp").forward(request, response);
    }

    // Método auxiliar para obtener los clientes desde la base de datos
    private List<Cliente> obtenerClientes() {
        List<Cliente> clientes = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "select * from cliente_completo_CRUD"; // Asegúrate de que el nombre de la vista sea correcto
        try {
            conn = conexion.conectar();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Cliente cliente = new Cliente();
                    cliente.setId_cliente(rs.getInt("ID_CLIENTE"));  // Columna ID_CLIENTE
                    cliente.setNombre(rs.getString("NOMBRE_CLIENTE"));  // Columna NOMBRE_CLIENTE
                    cliente.setCorreo(rs.getString("CORREO_CLIENTE"));  // Columna CORREO_CLIENTE
                    cliente.setTelefono(rs.getString("TELEFONO"));  // Columna TELEFONO
                    cliente.setNombre_proyecto(rs.getString("NOMBRE_PROYECTO"));  // Columna NOMBRE_PROYECTO
                    clientes.add(cliente);
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
        return clientes;
    }
}
