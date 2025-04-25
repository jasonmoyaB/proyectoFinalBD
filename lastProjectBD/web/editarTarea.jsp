<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Editar Tarea</title>
        <link rel="stylesheet" href="styles/styleaddUsers.css"/>
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>
        <br><br><br><br><br>
        <div class="container">
            <h2>Editar Tarea</h2>

            <!-- Mensajes de éxito o error -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <!-- Formulario de edición de tarea -->
            <form action="EditarTareaServlet" method="post">
                <input type="hidden" name="id_tarea" value="${tarea.idTarea}" />

                <label for="nombre_tarea">Nombre de la Tarea:</label>
                <input type="text" name="nombre_tarea" value="${tarea.nombreTarea}" required />

                <label for="descripcion">Descripción:</label>
                <textarea name="descripcion" rows="4">${tarea.descripcion}</textarea>

                <label for="estado">Estado:</label>
                <select name="estado">
                    <option value="Pendiente" ${tarea.estado == 'Pendiente' ? 'selected' : ''}>Pendiente</option>
                    <option value="En progreso" ${tarea.estado == 'En progreso' ? 'selected' : ''}>En progreso</option>
                    <option value="Completada" ${tarea.estado == 'Completada' ? 'selected' : ''}>Completada</option>
                </select>

                <label for="fecha_limite">Fecha Límite:</label>
                <input type="date" name="fecha_limite" value="${tarea.fechaLimite}" />

                <button type="submit">Actualizar</button>
            </form>
        </div>
    </body>
</html>