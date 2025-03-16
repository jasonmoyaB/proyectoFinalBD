package Controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Modelo.RolDAO;

@WebServlet({"/AgregarRolServlet"})
public class AgregarRolServlet extends HttpServlet {
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String nombreRol = request.getParameter("nombre_rol");
      if (nombreRol != null && !nombreRol.trim().isEmpty()) {
         RolDAO rolDAO = new RolDAO();
         if (rolDAO.agregarRol(nombreRol)) {
            response.sendRedirect("bienvenido.jsp");
         } else {
            response.sendRedirect("bienvenido.jsp?error=rol");
         }
      } else {
         response.sendRedirect("bienvenido.jsp?error=rol_vacio");
      }
   }
}
