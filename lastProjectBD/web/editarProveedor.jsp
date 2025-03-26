<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Proveedor</title>
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
            <h2>Editar Proveedor</h2>

            <!-- Mostrar mensajes de éxito o error -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <!-- Formulario de edición -->
            <form action="EditarProveedorServlet" method="post">
                <input type="hidden" name="id_proveedor" value="${proveedor.id_proveedor}" />
                <label for="nombreProveedor">Nombre del Proveedor:</label>
                <input type="text" name="nombre" value="${proveedor.nombre}" />  <!-- Cambié 'nombre_proveedor' a 'nombre' -->

                <label for="contacto">Contacto:</label>
                <input type="text" name="contacto" value="${proveedor.contacto}" />

                <label for="telefono">Teléfono:</label>
                <input type="text" name="telefono" value="${proveedor.telefono}" />

                <button type="submit">Actualizar</button>
            </form>
        </div>
    </body>
</html>
