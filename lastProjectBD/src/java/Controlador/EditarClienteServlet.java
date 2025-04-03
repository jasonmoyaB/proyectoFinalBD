package Controlador;

import Modelo.Cliente;
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

@WebServlet("/EditarClienteServlet")
public class EditarClienteServlet extends HttpServlet {

    // Método doGet para obtener los datos del cliente a editar
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idClienteParam = request.getParameter("id_cliente");

        if (idClienteParam == null || idClienteParam.isEmpty()) {
            request.setAttribute("error", "El ID del cliente no está disponible.");
            request.getRequestDispatcher("addCostumers.jsp").forward(request, response);
            return;
        }

        int idCliente = Integer.parseInt(idClienteParam);

        // Obtener los datos del cliente desde la base de datos
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();
        String sql = "SELECT ID_CLIENTE, NOMBRE_CLIENTE, CORREO_CLIENTE, TELEFONO, ID_PROYECTO "
                + "FROM fide_clientes_tb WHERE ID_CLIENTE = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idCliente);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Crear objeto cliente y asignar valores
                Cliente cliente = new Cliente();
                cliente.setId_cliente(rs.getInt("ID_CLIENTE"));
                cliente.setNombre(rs.getString("NOMBRE_CLIENTE"));
                cliente.setCorreo(rs.getString("CORREO_CLIENTE"));
                cliente.setTelefono(rs.getString("TELEFONO"));

                // Establecer el cliente como atributo de la solicitud
                request.setAttribute("cliente", cliente);
                request.getRequestDispatcher("editarCliente.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Cliente no encontrado.");
                request.getRequestDispatcher("addCostumers.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar los datos del cliente.");
            request.getRequestDispatcher("addCostumers.jsp").forward(request, response);
        }
    }

    // Método doPost para actualizar los datos del cliente
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idCliente = Integer.parseInt(request.getParameter("id_cliente"));
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String nombreProyecto = request.getParameter("nombre_proyecto");

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamamos al procedimiento almacenado para actualizar el cliente
                String sql = "{call proyectomain_pck.actualizar_cliente(?, ?, ?, ?, ?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, idCliente);
                cs.setString(2, nombre);
                cs.setString(3, correo);
                cs.setString(4, telefono);
                cs.setString(5, nombreProyecto);
                cs.execute();

                request.setAttribute("msg", "Cliente actualizado correctamente.");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al actualizar el cliente.");
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
            request.setAttribute("error", "No se pudo conectar a la base de datos.");
        }

        // Recargar los clientes actualizados
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

        // Usamos la vista cliente_completo_CRUD
        String sql = "SELECT ID_CLIENTE, NOMBRE_CLIENTE, CORREO_CLIENTE, TELEFONO, NOMBRE_PROYECTO FROM cliente_completo_CRUD";  //para asegurar mis clumnas

        try {
            conn = conexion.conectar();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Cliente cliente = new Cliente();
                    // Asignar valores a los objetos Cliente desde los resultados de la consulta
                    cliente.setId_cliente(rs.getInt("ID_CLIENTE"));
                    cliente.setNombre(rs.getString("NOMBRE_CLIENTE"));
                    cliente.setCorreo(rs.getString("CORREO_CLIENTE"));
                    cliente.setTelefono(rs.getString("TELEFONO"));
                    cliente.setNombre_proyecto(rs.getString("NOMBRE_PROYECTO"));
                    clientes.add(cliente);
                }
            } else {
                System.out.println("No se pudo establecer la conexión a la base de datos.");
            }
        } catch (SQLException e) {
            // Imprimir el error en caso de que haya una excepción
            System.err.println("Error al obtener clientes: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Cerrar los recursos correctamente
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
                // Imprimir error al cerrar los recursos
                System.err.println("Error al cerrar los recursos: " + e.getMessage());
                e.printStackTrace();
            }
        }
        return clientes;
    }
}
