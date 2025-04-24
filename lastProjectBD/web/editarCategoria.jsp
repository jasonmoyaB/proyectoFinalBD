<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Categoría</title>
        <link rel="stylesheet" href="styles/styleaddUsers.css"/>
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
                    <a class="nav-link" href="addCategoria.jsp">Agregar Categorías</a>
                    <a class="nav-link" href="addCostumers.jsp">Agregar Clientes</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>
        <br><br><br><br><br>
        <div class="container">
            <h2>Editar Categoría</h2>

            <!-- Mostrar mensajes de éxito o error -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <!-- Formulario de edición -->
            <form action="EditarCategoriaServlet" method="post">
                <input type="hidden" name="id_categoria" value="${categoria.id_categoria}" />

                <label for="nombre">Nombre de la Categoría:</label>
                <input type="text" name="nombre" value="${categoria.nombre_categoria}" required />

                <label for="nombre_proyecto">Proyecto:</label>
                <select name="nombre_proyecto" required>
                    <option value="">Seleccione un proyecto</option>
                    <option value="Desarrollo API" ${categoria.nombre_proyecto == 'Desarrollo API' ? 'selected' : ''}>Desarrollo API</option>
                    <option value="Web E-Commerce" ${categoria.nombre_proyecto == 'Web E-Commerce' ? 'selected' : ''}>Web E-Commerce</option>
                    <option value="Mantenimiento DB" ${categoria.nombre_proyecto == 'Mantenimiento DB' ? 'selected' : ''}>Mantenimiento DB</option>
                    <option value="Chatbot Soporte" ${categoria.nombre_proyecto == 'Chatbot Soporte' ? 'selected' : ''}>Chatbot Soporte</option>
                </select>

                <button type="submit">Actualizar Categoría</button>
            </form>
        </div>
    </body>
</html>
