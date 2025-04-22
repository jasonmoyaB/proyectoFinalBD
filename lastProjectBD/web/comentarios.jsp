<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/styleVerComentarios.css"/>
        <title>Comentarios</title>
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
                    <a class="nav-link" href="addCostumers.jsp">Agregar Clientes</a>
                    <a class="nav-link" href="addUsers.jsp">Agregar Usuarios</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>

        <div class="container">
            <h2>Comentarios Registrados</h2>

            <!-- Mostrar mensaje de éxito si existe -->
            <c:if test="${not empty requestScope.success}">
                <div class="message success">${requestScope.success}</div>
            </c:if>

            <!-- Mostrar mensaje de error si existe -->
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <table>
                <div class="input-wrapper">
                    <form action="AgregarComentarioServlet" method="get">
                        <button type="submit">Ver Comentarios</button>
                    </form>
                </div>
                <thead>
                    <tr>
                        <th>Contenido</th>
                        <th>Fecha</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Mostrar comentarios desde el Servlet -->
                    <c:forEach var="comentario" items="${comentarios}">
                        <tr>
                            <td>${comentario.contenido}</td>
                            <td>${comentario.fechaComentario}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
