<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Proyecto</title>
        <link rel="stylesheet" href="styles/styleaddUsers.css"/>
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
                    <a class="nav-link" href="addProjects.jsp">Agregar Proyecto</a>
                    <a class="nav-link" href="addTask.jsp">Agregar Tareas</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>
        <br><br><br><br><br>
        <div class="container">
            <h2>Editar Proyecto</h2>

            <!-- Mostrar mensajes de éxito o error -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <!-- Formulario de edición -->
            <form action="EditarProyectoServlet" method="post">
                <input type="hidden" name="id_proveedor" value="${proyecto.id_proyecto}" />
                <label for="nombreProyecto">Nombre del Proyecto:</label>
                <input type="text" name="nombre" value="${proyecto.nombre_proyecto}" />  <!-- Cambié 'nombre_proveedor' a 'nombre' -->

                <label for="descripcion">Descripcion:</label>
                <input type="text" name="contacto" value="${proyecto.descripcion}" />

                <label for="fecha_creacion">Fecha Creacion:</label>
                <input type="date" name="telefono" value="${proyecto.fecha_creacion}" />

                <button type="submit">Actualizar</button>
            </form>
        </div>
    </body>
</html>
