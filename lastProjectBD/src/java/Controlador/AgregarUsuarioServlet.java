package Controlador;

import Modelo.Conexion;
import Modelo.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/AgregarUsuarioServlet")
public class AgregarUsuarioServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener parámetros del formulario
        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
        String nombre = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String contraseña = request.getParameter("password");
        int idRol = Integer.parseInt(request.getParameter("rol"));
        int idDepartamento = Integer.parseInt(request.getParameter("departamento"));

        // Conectar a la BD
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                // Llamar al procedimiento almacenado
                String sql = "{call INSERTAR_USUARIOS(?, ?, ?, ?, ?, ?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, idUsuario);
                cs.setString(2, nombre);
                cs.setString(3, correo);
                cs.setString(4, contraseña);
                cs.setInt(5, idRol);
                cs.setInt(6, idDepartamento);

                // Ejecutar el procedimiento
                cs.execute();


                // Redirigir al formulario con mensaje de éxito
                response.sendRedirect("addUsers.jsp?msg=Usuario agregado");

            } catch (SQLException e) {
                e.printStackTrace();
                response.sendRedirect("addUsers.jsp?error=No se pudo agregar el usuario");
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
            response.sendRedirect("addUsers.jsp?error=No hay conexión con la base de datos");
        }
    }

    
    }


