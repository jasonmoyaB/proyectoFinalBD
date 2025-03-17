package Controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import Modelo.UsuarioDAO;

@WebServlet("/AgregarUsuarioServlet")
public class AgregarUsuarioServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreUsuario = request.getParameter("nombre_usuario");
        String correo = request.getParameter("correo");
        String contraseña = request.getParameter("contraseña");
        String rol = request.getParameter("id_rol");
        
        // Crear una instancia del DAO de Usuario
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        
        // Llamar al método agregarUsuario para insertar el usuario en la base de datos
        boolean usuarioAgregado = usuarioDAO.agregarUsuario(nombreUsuario, correo, contraseña, rol);
        
        // Redirigir según el resultado
        if (usuarioAgregado) {
            response.sendRedirect("bienvenido.jsp");
        } else {
            response.sendRedirect("bienvenido.jsp?error=usuario");
        }
    }
}




