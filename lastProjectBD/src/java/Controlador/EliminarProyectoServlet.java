/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controlador;

import Modelo.ProyectoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/EliminarProyectoServlet")
public class EliminarProyectoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Recoger el ID del proyecto
            int proyectoId = Integer.parseInt(request.getParameter("idProyecto"));

            // Llamar al DAO para eliminar el proyecto
            ProyectoDAO proyectoDAO = new ProyectoDAO();
            boolean resultado = proyectoDAO.eliminarProyecto(proyectoId);

            if (resultado) {
                request.setAttribute("msg", "Proyecto eliminado correctamente");
            } else {
                request.setAttribute("error", "Error al eliminar el proyecto");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error al procesar la solicitud");
        }

        request.getRequestDispatcher("listarProyectos.jsp").forward(request, response);
    }
}
