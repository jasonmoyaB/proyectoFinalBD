package Controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Modelo.UsuarioDAO;

@WebServlet({"/AgregarUsuarioServlet"})
public class AgregarUsuarioServlet extends HttpServlet {
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      String nombreUsuario = request.getParameter("nombre_usuario");
      String correo = request.getParameter("correo");
      String contraseña = request.getParameter("contraseña");
      String rol = request.getParameter("id_rol");
      UsuarioDAO usuarioDAO = new UsuarioDAO();
      if (usuarioDAO.agregarUsuario(nombreUsuario, correo, contraseña, rol)) {
         response.sendRedirect("bienvenido.jsp");
      } else {
         response.sendRedirect("bienvenido.jsp?error=usuario");
      }
   }
}
