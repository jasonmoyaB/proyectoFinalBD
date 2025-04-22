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

@WebServlet("/AgregarClientesServlet")
public class AgregarClientesServlet extends HttpServlet {

    // Obtener todos los clientes
    private List<Cliente> obtenerClientes() {
        List<Cliente> clientes = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT id_cliente, nombre_cliente, correo_cliente, telefono, nombre_proyecto FROM cliente_completo_CRUD";
        try (PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setId_cliente(rs.getInt("id_cliente"));
                cliente.setNombre(rs.getString("nombre_cliente"));
                cliente.setCorreo(rs.getString("correo_cliente"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setNombre_proyecto(rs.getString("nombre_proyecto"));
                clientes.add(cliente);
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
        return clientes;
    }

    
    private List<Cliente> buscarClientes(String search) {
        List<Cliente> clientes = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        String sql = "SELECT id_cliente, nombre_cliente, correo_cliente, telefono, nombre_proyecto FROM cliente_completo_CRUD WHERE LOWER(nombre_cliente) LIKE ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + search.toLowerCase() + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cliente cliente = new Cliente();
                cliente.setId_cliente(rs.getInt("id_cliente"));
                cliente.setNombre(rs.getString("nombre_cliente"));
                cliente.setCorreo(rs.getString("correo_cliente"));
                cliente.setTelefono(rs.getString("telefono"));
                cliente.setNombre_proyecto(rs.getString("nombre_proyecto"));
                clientes.add(cliente);
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
        return clientes;
    }

    // Manejar búsqueda de clientes
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String search = request.getParameter("search");

        List<Cliente> clientes;
        if (search != null && !search.trim().isEmpty()) {
            clientes = buscarClientes(search);
        } else {
            clientes = obtenerClientes();
        }

        request.setAttribute("clientes", clientes);
        request.getRequestDispatcher("addCostumers.jsp").forward(request, response);
    }

    // Agregar cliente
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idClienteStr = request.getParameter("id_cliente");
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String idProyectoStr = request.getParameter("id_proyecto");

        Integer idCliente = null;
        Integer idProyecto = null;

        if (idClienteStr != null && !idClienteStr.trim().isEmpty()) {
            try {
                idCliente = Integer.parseInt(idClienteStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID Cliente debe ser un número válido");
                request.getRequestDispatcher("addCostumers.jsp").forward(request, response);
                return;
            }
        }

        if (idProyectoStr != null && !idProyectoStr.trim().isEmpty()) {
            try {
                idProyecto = Integer.parseInt(idProyectoStr);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID Proyecto debe ser un número válido");
                request.getRequestDispatcher("addCostumers.jsp").forward(request, response);
                return;
            }
        }

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call proyectomain_pck.insertar_clientes(?, ?, ?, ?)}";
                cs = conn.prepareCall(sql);

                cs.setString(1, nombre);
                cs.setString(2, correo);
                cs.setString(3, telefono);
                cs.setInt(4, idProyecto != null ? idProyecto : 0);

                cs.execute();
                request.setAttribute("msg", "Cliente agregado");

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "No se pudo agregar el cliente");
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

        // Obtener todos los clientes después de agregar uno
        List<Cliente> clientes = obtenerClientes();
        request.setAttribute("clientes", clientes);
        request.getRequestDispatcher("addCostumers.jsp").forward(request, response);
    }
}
