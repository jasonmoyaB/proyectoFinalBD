<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelo.RolDAO" %>  <!-- Aquí importamos RolDAO desde el paquete modelo -->

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
            <div class="submenu">
                <a class="comentariosTap" href="comentarios.jsp">Ver Comentarios</a>
                <a class="comentariosTap" href="upload.jsp">Subir Archivo</a>
            </div>
            <div class="parent">
                <div class="box addC"><a class="addCustomers" href="addCostumers.jsp">Agregar Clientes</a>
                    <p class="text-box">Aquí puedes gestionar los clientes:<br> agregar, editar o eliminar.</p>
                </div>
                <div class="box addP"><a class="addCustomers" href="addSuppliers.jsp">Agregar Proveedores</a>
                    <p class="text-box">Aquí puedes gestionar los proveedores:<br> agregar nuevos proveedores <br> y mantener su información actualizada.</p>

                </div>
                <div class="box addU"> <a class="addCustomers" href="addUsers.jsp">Agregar Usuarios</a>
                    <p class="text-box">
                        Aquí puedes agregar nuevos usuarios, <br> 
                        asignarles roles y <br> 
                        mantener su información actualizada.
                    </p>

                </div>
            </div>



            <% } else if ("user".equals(rol)) { %>
            <!-- Contenido exclusivo para usuarios -->
            <h3>Contenido exclusivo para usuarios.</h3>
            <div class="parent">
                <div class="box addProject">
                    <a class="addProjects" href="addProjects.jsp">Agregar Proyectos</a>
                    <p class="text-box">
                        Aquí puedes gestionar tus proyectos:<br>
                        agregar nuevos proyectos y<br>
                        mantenerlos organizados.
                    </p>
                </div>
                <div class="box addTask">
                    <a class="addTasks" href="styles/addTask.jsp">Agregar Tareas</a>
                    <p class="text-box">
                        Aquí puedes gestionar tus tareas:<br>
                        agregar nuevas tareas y<br>
                        asignarlas a tus proyectos.
                    </p>
                </div>
                <div class="box calendar">
                    <a class="viewCalendar" href="calendar.jsp">Calendario</a>
                    <p class="text-box">
                        Consulta el calendario para<br>
                        ver las fechas de tus tareas y<br>
                        mantenerte al día.
                    </p>
                </div>
            </div>
            <% } %>
        </div>

        <footer>
            <div class="footer-content">
                <div class="footer-logo">
                    <h2>CODINGRAPH;</h2>
                </div>

            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 CODINGRAPH;. Todos los derechos reservados.</p>
            </div>
        </footer>

    </body>
</html>







