package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import Modelo.UsuarioDAO;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UsuarioDAO usuarioDAO = new UsuarioDAO();
        
        if (usuarioDAO.validarUsuario(username, password)) {
            System.out.println("Usuario validado correctamente: " + username);
            String rol = usuarioDAO.obtenerRolUsuario(username, password);
            System.out.println("Rol obtenido: " + rol);

            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            session.setAttribute("role", rol);

            System.out.println("Guardando en sesión -> Usuario: " + session.getAttribute("user"));
            System.out.println("Guardando en sesión -> Rol: " + session.getAttribute("role"));

            response.sendRedirect("bienvenido.jsp");
        } else {
            System.out.println("Error: Usuario o contraseña incorrectos");
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}

