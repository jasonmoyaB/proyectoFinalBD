<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="modelo.RolDAO" %>

<%
    // Obtener la sesión
    HttpSession sesion = request.getSession(false);  // Obtiene la sesión sin crear una nueva si no existe
    if (sesion == null || sesion.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");  // Si no hay sesión o no se ha iniciado sesión, redirige al login
        return;
    }

    // Obtener los datos del usuario desde la sesión
    String username = (String) sesion.getAttribute("user");
    String rol = (String) sesion.getAttribute("role"); // Obtener el rol desde la sesión

    // Lista de roles solo disponible para administradores
    List<String> roles = null;
    if ("admin".equals(rol)) {
        RolDAO rolDAO = new RolDAO();
        roles = rolDAO.obtenerRoles();  // Obtener la lista de roles desde la base de datos
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenida</title>
    <link rel="stylesheet" href="styles/styleBienvenida.css"/>
</head>
<body>
    <header>
        <nav class="nav">
            <ul>
                <a class="logo" href="">CODINGRAPH;</a>
                <a class="nav-link" href="index.jsp">Log-out</a>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h1>Bienvenido, <%= username %>!</h1>
        <h2>
            <% if ("admin".equals(rol)) { %>
                Bienvenido al panel de administración.
            <% } else if ("user".equals(rol)) { %>
                Bienvenido, usuario regular.
            <% } %>
        </h2>

        <% if ("admin".equals(rol)) { %>
        <!-- Contenido exclusivo para administradores -->
        <h3>Administrar roles</h3>
        <form action="AgregarRolServlet" method="post" id="rolForm">
            <label for="nombre_rol">Nombre del Rol:</label>
            <input type="text" id="nombre_rol" name="nombre_rol" required>
            <button type="submit">Agregar Rol</button>
        </form>

        <h3>Agregar un nuevo usuario</h3>
        <form action="AgregarUsuarioServlet" method="post">
            <label for="nombre_usuario">Nombre:</label>
            <input type="text" id="nombre_usuario" name="nombre_usuario" required>

            <label for="correo">Correo:</label>
            <input type="email" id="correo" name="correo" required>

            <label for="contraseña">Contraseña:</label>
            <input type="password" id="contraseña" name="contraseña" required>

            <label for="id_rol">Seleccionar Rol:</label>
            <select id="id_rol" name="id_rol" required>
                <option value="admin">Administrador</option>
                <option value="user">Usuario</option>
            </select>

            <button type="submit">Agregar Usuario</button>
        </form>
        <% } else if ("user".equals(rol)) { %>
        <!-- Contenido exclusivo para usuarios -->
        <h3>Contenido exclusivo para usuarios.</h3>
        <% } %>
    </div>

    <footer>
        <div class="footer-content">
            <div class="footer-logo">
                <h2>CODINGRAPH;</h2>
            </div>
        </div>
    </footer>

</body>
</html>





