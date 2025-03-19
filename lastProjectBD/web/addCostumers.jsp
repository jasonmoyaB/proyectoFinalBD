<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles/styleaddCostumers.css"/>
    <title>Agregar Clientes</title>
</head>
<body>
    <header>
        <nav class="nav">
            <ul>
                <a class="logo" href="">CODINGRAPH;</a>
                <a class="nav-link" href="login.jsp">Log-out</a>
                <a class="nav-link" href="bienvenido.jsp">Atras</a>
            </ul>
        </nav>
    </header>

    <div class="container">
        <h2>Agregar Clientes</h2>

        <!-- Mostrar el mensaje de éxito si existe -->
        <c:if test="${not empty param.msg}">
            <div class="message success">${param.msg}</div>
        </c:if>
        
        <!-- Mostrar mensaje de error si existe -->
        <c:if test="${not empty requestScope.error}">
            <div class="message error">${requestScope.error}</div>
        </c:if>

        <form action="AgregarClientesServlet" method="post">
            <table>
                <tr>
                    <th>ID Cliente</th>
                    <th>Nombre</th>
                    <th>Correo</th>
                    <th>Telefono</th>
                    <th>ID Proyecto (ID)</th>
                    <th>Acciones</th>
                </tr>
                <tr>
                    <td><input type="number" name="id_cliente" required></td>
                    <td><input type="text" name="nombre" required></td>
                    <td><input type="email" name="correo" required></td>
                    <td><input type="tel" name="telefono" required></td>
                    <td><input type="number" name="id_proyecto" required></td>
                    <td><button type="submit">Agregar Cliente</button></td>
                </tr>
            </table>
        </form>

        <h2>Clientes Registrados</h2>
        <table>
            <tr>
                <th>ID Cliente</th>
                <th>Nombre</th>
                <th>Correo</th>
                <th>Telefono</th>
                <th>ID Proyecto (ID)</th>
            </tr>

            <!-- Mostrar clientes desde el Servlet -->
            <c:forEach var="cliente" items="${clientes}">
                <tr>
                    <td>${cliente.id_cliente}</td>
                    <td>${cliente.nombre}</td>  <!-- Corregido de nombre_cliente a nombre -->
                    <td>${cliente.correo}</td>  <!-- Corregido de correo_cliente a correo -->
                    <td>${cliente.telefono}</td>
                    <td>${cliente.id_proyecto}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>


