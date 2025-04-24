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

@WebServlet("/AgregarProyectoServlet")
public class AgregarProyectoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Recoger parámetros del formulario
            String nombreProyecto = request.getParameter("nombre");
            String descripcion = request.getParameter("descripcion");
            String fechaInicioStr = request.getParameter("fechaInicio");
            String createdBy = request.getParameter("createdBy");
            String accion = request.getParameter("accion");

            int usuarioId;
            try {
                usuarioId = Integer.parseInt(request.getParameter("idUsuario"));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID de usuario inválido");
                request.getRequestDispatcher("addProjects.jsp").forward(request, response);
                return;
            }

            Date fechaInicio = Date.valueOf(fechaInicioStr); // Formato yyyy-MM-dd

            // Crear objeto Proyecto
            Proyecto proyecto = new Proyecto();
            proyecto.setNombreProyecto(nombreProyecto);
            proyecto.setDescripcion(descripcion);
            proyecto.setFechaCreacion(fechaInicio);
            proyecto.setUsuarioId(usuarioId);
            proyecto.setCreatedBy(createdBy);
            proyecto.setAccion(accion);

            // Llamar al DAO para agregar el proyecto
            ProyectoDAO proyectoDAO = new ProyectoDAO();
            boolean resultado = proyectoDAO.agregarProyecto(proyecto);

            if (resultado) {
                request.setAttribute("msg", "Proyecto agregado correctamente");
            } else {
                request.setAttribute("error", "Error al agregar el proyecto");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al procesar la solicitud");
        }

        request.getRequestDispatcher("addProjects.jsp").forward(request, response);
    }
}
