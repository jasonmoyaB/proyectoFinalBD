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
        // Obtener los parámetros del formulario
        String nombreUsuario = request.getParameter("nombre");
        String correo = request.getParameter("correo");
        String contraseña = request.getParameter("contraseña");

        // Obtener el ID de rol y departamento, asegurándose de que no sean nulos o vacíos
        String rolParam = request.getParameter("rol");
        String departamentoParam = request.getParameter("departamento");
        
        if (rolParam == null || rolParam.isEmpty() || departamentoParam == null || departamentoParam.isEmpty()) {
            response.sendRedirect("error.jsp?message=Faltan+datos+de+rol+o+departamento");
            return;  // Salir del servlet si los parámetros son inválidos
        }
        
        // Convertir los parámetros a enteros
        int idRol = Integer.parseInt(rolParam);
        int idDepartamento = Integer.parseInt(departamentoParam);
        
        // Crear una instancia del DAO de Usuario
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        
        // Llamar al método agregarUsuario para insertar el usuario en la base de datos
        boolean usuarioAgregado = usuarioDAO.agregarUsuario(nombreUsuario, correo, contraseña, "usuario", idRol, idDepartamento);
        
        // Redirigir según el resultado
        if (usuarioAgregado) {
            response.sendRedirect("bienvenido.jsp");
        } else {
            response.sendRedirect("bienvenido.jsp?error=usuario");
        }
    }
}



