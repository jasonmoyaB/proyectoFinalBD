/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.Conexion;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/EditarProyectoServlet")
public class EditarProyectoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idProyecto = Integer.parseInt(request.getParameter("id_proyecto"));
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String fechaInicio = request.getParameter("fechaInicio");
        String fechaFin = request.getParameter("fechaFin");
        String estado = request.getParameter("estado");

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call proyectomain_pck.editar_proyecto(?, ?, ?, ?, ?, ?)}"; // Procedimiento almacenado
                cs = conn.prepareCall(sql);
                cs.setInt(1, idProyecto);
                cs.setString(2, nombre);
                cs.setString(3, descripcion);
                cs.setString(4, fechaInicio);
                cs.setString(5, fechaFin);
                cs.setString(6, estado);
                cs.execute();
                request.setAttribute("msg", "Proyecto editado correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al editar el proyecto");
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

        request.getRequestDispatcher("listarProyectos.jsp").forward(request, response);
    }
}
