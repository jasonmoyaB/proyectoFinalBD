<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Agregar Tarea</title>
        <link rel="stylesheet" href="styles/styleSuppliers.css"> <!-- Cambia el archivo CSS si es necesario -->
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
                    <a class="nav-link" href="addProjects.jsp">Agregar Proyectos</a>
                    <a class="nav-link" href="calendar.jsp">Calendario</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>

        <div class="container">
            <h2>Agregar Tarea</h2>

            <!-- Mostrar mensaje de éxito si existe -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>

            <!-- Mostrar mensaje de error si existe -->
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <!-- Formulario para agregar tarea -->
            <form action="AgregarTareasServlet" method="POST">
                <table>
                    <tr>
                        <th>Nombre Tarea</th>
                        <th>Descripción</th>
                        <th>Fecha Límite</th>
                        <th>Acciones</th>
                    </tr>
                    <tr>
                        <td><input type="text" name="taskName" required></td>
                        <td><textarea name="taskDescription" rows="2" required></textarea></td>
                        <td><input type="date" name="taskDeadline" required></td>
                        <td><button type="submit">Agregar Tarea</button></td>
                    </tr>
                </table>
            </form>

            <h2>Lista de Tareas</h2>

            <!-- Tabla para mostrar tareas -->
            <table>
                <tr>
                    <th>Nombre Tarea</th>
                    <th>Descripción</th>
                    <th>Fecha Límite</th>
                    <th>Acciones</th>
                </tr>

                <!-- Mostrar tareas dinámicamente -->
                <c:forEach var="tarea" items="${tareas}">
                    <tr>
                        <td>${tarea.nombre}</td>
                        <td>${tarea.descripcion}</td>
                        <td>${tarea.fechaLimite}</td>
                        <td>
                            <a href="EditarTareaServlet?id=${tarea.id}" class="btn">Editar</a>
                            <a href="EliminarTareaServlet?id=${tarea.id}" class="btn" onclick="return confirm('¿Estás seguro de eliminar esta tarea?')">Eliminar</a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>
