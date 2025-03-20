<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles/styleSuppliers.css"/>
    <title>Agregar Proveedor</title>
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
        <h2>Agregar Proveedor</h2>

        <!-- Mostrar mensaje de éxito si existe -->
        <c:if test="${not empty param.msg}">
            <div class="message success">${param.msg}</div>
        </c:if>

        <!-- Mostrar mensaje de error si existe -->
        <c:if test="${not empty requestScope.error}">
            <div class="message error">${requestScope.error}</div>
        </c:if>

        <form action="AgregarProvedorServlet" method="post">
            <table>
                <tr>
                    <th>ID Proveedor</th>
                    <th>Nombre</th>
                    <th>Contacto</th>
                    <th>Teléfono</th>
                    <th>Acciones</th>
                </tr>
                <tr>
                    <td><input type="number" name="id_proveedor" required></td>
                    <td><input type="text" name="nombre" required></td>
                    <td><input type="text" name="contacto" required></td>
                    <td><input type="text" name="telefono" required></td>
                    <td><button type="submit">Agregar Proveedor</button></td>
                </tr>
            </table>
        </form>

        <h2>Proveedores Registrados</h2>
        <table>
            <tr>
                <th>ID Proveedor</th>
                <th>Nombre</th>
                <th>Contacto</th>
                <th>Teléfono</th>
            </tr>

            <!-- Mostrar proveedores desde el Servlet -->
            <c:forEach var="proveedor" items="${proveedores}">
                <tr>
                    <td>${proveedor.id_proveedor}</td>
                    <td>${proveedor.nombre}</td>
                    <td>${proveedor.contacto}</td>
                    <td>${proveedor.telefono}</td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>

</html>

