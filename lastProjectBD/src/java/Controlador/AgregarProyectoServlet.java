<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/styleSuppliers.css"/>
        <title>Agregar Proyecto</title>
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
                    <a class="nav-link" href="addTask.jsp">Agregar Tareas</a>
                    <a class="nav-link" href="calendar.jsp">Calendar</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>

        <div class="container">
            <h2>Agregar Proyecto</h2>

            <!-- Mostrar mensaje de éxito si existe -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>

            <!-- Mostrar mensaje de error si existe -->
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <form action="AgregarProyectoServlet" method="post">
                <table>
                    <tr>
                        <th>Auto-generado</th>
                        <th>Nombre Proyecto</th>
                        <th>Descripcion</th>
                        <th>Acciones</th>
                    </tr>
                    <tr>
                        <td>Auto-generado</td>
                        <td><input type="text" name="nombre_proyecto" required></td>
                        <td><input type="text" name="descripcion" required></td>
                        <td><button type="submit">Agregar Proyecto</button></td>
                    </tr>
                </table>
            </form>

            <h2>Proyectos Registrados</h2>
            <!-- From Uiverse.io by ZAKARIAE48CHELLE --> 
            <div class="input-wrapper">
                <form action="AgregarProyectoServlet" method="get">
                    <input type="text" name="search" class="input" placeholder="Buscar proyectos..." />
                    <button type="submit">Buscar</button>
                </form>
            </div>
            <table>
                <tr>
                    <th>Nombre Proyecto</th>
                    <th>Descripcion</th>
                </tr>

                <!-- Mostrar proveedores desde el Servlet -->
                <c:forEach var="proyecto" items="${proyectos}">
                    <tr>

                        <td>${proyecto.nombre}</td>
                        <td>${proyecto.descripcion}</td>
                        <td>
                            <!-- Botón de editar -->
                            <a href="EditarProyectoServlet?id_proyecto=${proyecto.id_proyecto}">
                                <button>Editar</button>
                            </a>
                            <!-- Botón de eliminar -->
                            <a href="EliminarProyectoServlet?id_proyecto=${proyecto.id_proyecto}" onclick="return confirm('¿Estás seguro de eliminar este proyecto?')">
                                <button>Eliminar</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>
