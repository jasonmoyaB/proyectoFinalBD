/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.Proyecto;
import Modelo.ProyectoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/EditarProyectoServlet")
public class EditarProyectoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Recoger parámetros del formulario
            int proyectoId = Integer.parseInt(request.getParameter("idProyecto"));
            String nombreProyecto = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String fechaInicioStr = request.getParameter("fechaInicio");
            String lastUpdateBy = request.getParameter("lastUpdateBy");
            String accion = request.getParameter("accion");

            int usuarioId;
            try {
                usuarioId = Integer.parseInt(request.getParameter("idUsuario"));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID de usuario inválido");
                request.getRequestDispatcher("editProjects.jsp").forward(request, response);
                return;
            }

            Date fechaInicio = Date.valueOf(fechaInicioStr); // Formato yyyy-MM-dd

            // Crear objeto Proyecto
            Proyecto proyecto = new Proyecto();
            proyecto.setProyectoId(proyectoId);
            proyecto.setNombreProyecto(nombreProyecto);
            proyecto.setDescripcion(descripcion);
            proyecto.setFechaCreacion(fechaInicio);
            proyecto.setUsuarioId(usuarioId);
            proyecto.setLastUpdateBy(lastUpdateBy);
            proyecto.setAccion(accion);

            // Llamar al DAO para actualizar el proyecto
            ProyectoDAO proyectoDAO = new ProyectoDAO();
            boolean resultado = proyectoDAO.actualizarProyecto(proyecto);

            if (resultado) {
                request.setAttribute("msg", "Proyecto actualizado correctamente");
            } else {
                request.setAttribute("error", "Error al actualizar el proyecto");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al procesar la solicitud");
        }

        request.getRequestDispatcher("editProjects.jsp").forward(request, response);
    }
}

