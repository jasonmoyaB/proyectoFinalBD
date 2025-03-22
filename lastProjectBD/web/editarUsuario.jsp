<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Usuario</title>
        <link rel="stylesheet" href="styles/styleaddUsers.css"/>
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
                    <a class="nav-link" href="addSuppliers.jsp">Agregar Proveedores</a>
                    <a class="nav-link" href="addCostumers.jsp">Agregar Clientes</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>
<br><br><br><br><br>
        <div class="container">
            <h2>Editar Usuario</h2>

            <!-- Mostrar mensajes de éxito o error -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <!-- Formulario de edición -->
            <form action="EditarUsuarioServlet" method="post">
                <input type="hidden" name="id_usuario" value="${usuario.id_usuario}" />
                <label for="nombre">Nombre:</label>
                <input type="text" name="nombre" value="${usuario.nombre}" />

                <label for="correo">Correo:</label>
                <input type="email" name="correo" value="${usuario.correo}" />

                <label for="password">Contraseña:</label>
                <input type="password" name="password" value="${usuario.contraseña}" />

                <label for="rol">Rol (ID):</label>
                <!-- Cambié el tipo a number para asegurarnos de que se envíen valores numéricos -->
                <input type="number" name="rol" value="${usuario.nombreRol}" />

                <label for="departamento">Departamento (ID):</label>
                <!-- Cambié el tipo a number para asegurarnos de que se envíen valores numéricos -->
                <input type="number" name="departamento" value="${usuario.nombreDepartamento}" />

                <button type="submit">Actualizar</button>
            </form>
        </div>
    </body>
</html>


