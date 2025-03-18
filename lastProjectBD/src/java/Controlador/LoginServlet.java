package Controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    // Datos de usuario "quemados" para admin y user
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "1234";
    private static final String USER_USERNAME = "jorge";
    private static final String USER_PASSWORD = "123";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("usuario");
        String password = request.getParameter("clave");

        String role = null;

        // Validar el login
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            role = "admin"; // Asignar rol de administrador
        } else if (USER_USERNAME.equals(username) && USER_PASSWORD.equals(password)) {
            role = "user";  // Asignar rol de usuario regular
        }

        if (role != null) {
            // Si el login es exitoso, guardamos la sesión con el rol
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            session.setAttribute("role", role); // Guardamos el rol del usuario

            // Redirigir a la página de bienvenida
            response.sendRedirect("bienvenido.jsp");
        } else {
            // Si las credenciales son incorrectas, redirigir al login con un mensaje de error
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}







