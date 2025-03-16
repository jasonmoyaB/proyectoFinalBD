package Controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.*;

import java.sql.*;
import Modelo.UsuarioDAO;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("usuario");
        String password = request.getParameter("clave");
        UsuarioDAO usuarioDAO = new UsuarioDAO();

        // Validar usuario y contraseña
        if (usuarioDAO.validarUsuario(username, password)) {
            String rol = usuarioDAO.obtenerRolUsuario(username, password);
            HttpSession session = request.getSession();  // Usar la sesión actual
            session.setAttribute("user", username);
            session.setAttribute("role", rol);
            response.sendRedirect("bienvenido.jsp");  // Redirigir al usuario a la página de bienvenida
        } else {
            response.sendRedirect("login.jsp?error=invalid");  // Error de usuario o contraseña incorrectos
        }
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lógica para redirigir si el usuario ya tiene sesión activa
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect("bienvenido.jsp");  // Redirige si ya está logueado
        } else {
            response.sendRedirect("login.jsp");  // Redirige a la página de login si no tiene sesión
        }
    }
}
