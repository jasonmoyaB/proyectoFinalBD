<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/styleaddUsers.css"/>
        <title>Agregar Usuarios</title>
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

        <div class="container">
            <h2>Agregar Usuario</h2>

            <!-- Mostrar el mensaje de éxito si existe -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>

            <!-- Mostrar mensaje de error si existe -->
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <form action="AgregarUsuarioServlet" method="post">
                <table>
                    <tr>
                        <th>ID Usuario</th>
                        <th>Nombre</th>
                        <th>Correo</th>
                        <th>Contraseña</th>
                        <th>Rol (ID)</th>
                        <th>Departamento (ID)</th>
                        <th>Acciones</th>
                    </tr>
                    <tr>
                        <td><input type="number" name="id_usuario" required></td>
                        <td><input type="text" name="nombre" required></td>
                        <td><input type="email" name="correo" required></td>
                        <td><input type="password" name="password" required></td>
                        <td><input type="number" name="rol" required></td>
                        <td><input type="number" name="departamento" required></td>
                        <td><button type="submit">Agregar Usuario</button></td>
                    </tr>
                </table>
            </form>

            <h2>Usuarios Registrados</h2>
            <table>
                <tr>
                    <th>ID Usuario</th>
                    <th>Nombre</th>
                    <th>Correo</th>
                    <th>Contraseña</th>
                    <th>Rol</th>
                    <th>Departamento</th>
                    <th>Acciones</th>
                </tr>

                <!-- Mostrar usuarios desde el Servlet -->
                <c:forEach var="usuario" items="${usuarios}">
                    <tr>
                        <td>${usuario.id_usuario}</td>
                        <td>${usuario.nombre}</td>
                        <td>${usuario.correo}</td>
                        <td>******</td>
                        <td>${usuario.nombreRol}</td>  <!-- Cambio aquí -->
                        <td>${usuario.nombreDepartamento}</td> <!-- Cambio aquí -->
                        
                        <td><!-- Botón de editar -->
                            <a href="EditarUsuarioServlet?id_usuario=${usuario.id_usuario}">
                                <button>Editar</button>
                            </a>
                            <!-- Botón de eliminar -->
                            <a href="EliminarUsuarioServlet?id_usuario=${usuario.id_usuario}" onclick="return confirm('¿Estás seguro de eliminar este usuario?')">
                                <button>Eliminar</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>




