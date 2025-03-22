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
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
                    <a class="nav-link" href="addSuppliers.jsp">Agregar Proveedores</a>
                    <a class="nav-link" href="addUsers.jsp">Agregar Usuarios</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
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
                        <td><input type="number" name="id_proyecto" required></td> <!-- Se solicita el id_proyecto -->
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
                    <th>Nombre Proyecto</th> <!-- Cambiado de "ID Proyecto" a "Nombre Proyecto" -->
                </tr>

                <!-- Mostrar clientes desde el Servlet -->
                <c:forEach var="cliente" items="${clientes}">
                    <tr>
                        <td>${cliente.id_cliente}</td>
                        <td>${cliente.nombre}</td>
                        <td>${cliente.correo}</td>
                        <td>${cliente.telefono}</td>
                        <td>${cliente.nombre_proyecto}</td> <!-- Usando nombre_proyecto en lugar de id_proyecto -->
                    </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>


