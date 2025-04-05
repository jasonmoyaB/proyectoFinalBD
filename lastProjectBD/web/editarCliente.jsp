<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Cliente</title>
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
            <h2>Editar Cliente</h2>

            <!-- Mostrar mensajes de éxito o error -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <!-- Formulario de edición -->
            <form action="EditarClienteServlet" method="post">
                <input type="hidden" name="id_cliente" value="${cliente.id_cliente}" />

                <label for="nombre">Nombre:</label>
                <input type="text" name="nombre" value="${cliente.nombre}" required />

                <label for="correo">Correo:</label>
                <input type="email" name="correo" value="${cliente.correo}" required />

                <label for="telefono">Teléfono:</label>
                <input type="text" name="telefono" value="${cliente.telefono}" required />

                <label for="nombre_proyecto">Proyecto:</label>
                <select name="nombre_proyecto" required>
                    <option value="">Seleccione un proyecto</option>
                    <option value="Desarrollo API" ${cliente.nombre_proyecto == 'Desarrollo API' ? 'selected' : ''}>Desarrollo API</option>
                    <option value="Web E-Commerce" ${cliente.nombre_proyecto == 'Web E-Commerce' ? 'selected' : ''}>Web E-Commerce</option>
                    <option value="Mantenimiento DB" ${cliente.nombre_proyecto == 'Mantenimiento DB' ? 'selected' : ''}>Mantenimiento DB</option>
                    <option value="Chatbot Soporte" ${cliente.nombre_proyecto == 'Chatbot Soporte' ? 'selected' : ''}>Chatbot Soporte</option>
                </select>

                <button type="submit">Actualizar Cliente</button>
            </form>
        </div>
    </body>
</html>
