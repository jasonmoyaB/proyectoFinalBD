/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.Conexion;
import Modelo.Proyecto;
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
        // Obtener parámetros del formulario
        String idProyectoStr = request.getParameter("id_proyecto");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        // Validar parámetros
        if (idProyectoStr == null || nombre == null || descripcion == null || 
            idProyectoStr.isEmpty() || nombre.isEmpty() || descripcion.isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios.");
            request.getRequestDispatcher("editarProyecto.jsp").forward(request, response);
            return;
        }

        int idProyecto;

        try {
            idProyecto = Integer.parseInt(idProyectoStr);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID de proyecto inválido.");
            request.getRequestDispatcher("editarProyecto.jsp").forward(request, response);
            return;
        }

        // Crear objeto Proyecto
        Proyecto proyecto = new Proyecto();
        proyecto.setId_proyecto(idProyecto);
        proyecto.setNombre(nombre);
        proyecto.setDescripcion(descripcion);

        // Conexión a la base de datos
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call actualizar_proyecto(?, ?, ?)}"; // Procedimiento almacenado
                cs = conn.prepareCall(sql);

                // Mapear los datos del proyecto al procedimiento almacenado
                cs.setInt(1, proyecto.getId_proyecto());
                cs.setString(2, proyecto.getNombre());
                cs.setString(3, proyecto.getDescripcion());

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

        // Redirigir a la lista de proyectos
        response.sendRedirect("addProjects.jsp");
    }
}
