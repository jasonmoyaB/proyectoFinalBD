<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/styleCategoria.css"/>
        <title>Categorías</title>
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
            <h2>Agregar Categorías</h2>

            <!-- Mostrar mensaje de éxito si existe -->
            <c:if test="${not empty msg}">
                <div class="message success">${msg}</div>
            </c:if>

            <!-- Mostrar mensaje de error si existe -->
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>

            <form action="AgregarCategoriasServlet" method="post">
                <table>
                    <tr>
                        <th>Auto-generado</th>
                        <th>Nombre</th>
                        <th>Proyecto</th>
                        <th>Acciones</th>
                    </tr>
                    <tr>
                        <td>Auto-generado</td>
                        <td><input type="text" name="nombre" required></td>
                        <td>
                            <select name="id_proyecto" required>
                                <option value="">Seleccione un proyecto</option>
                                <option value="1">Desarrollo API</option>
                                <option value="2">Web E-Commerce</option>
                                <option value="3">Mantenimiento DB</option>
                                <option value="4">Chatbot Soporte</option>
                            </select>
                        </td>
                        <td><button type="submit">Agregar Categoría</button></td>
                    </tr>
                </table>
            </form>

            <h2>Categorías Registradas</h2>
            <div class="input-wrapper">
                <form action="AgregarCategoriasServlet" method="get">
                    <input type="text" name="search" class="input" placeholder="Buscar categorías..." />
                    <button type="submit">Buscar</button>
                </form>
            </div>

            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Nombre del Proyecto</th>
                    <th>Acciones</th>
                </tr>

                <!-- Mostrar categorías desde el Servlet -->
                <c:forEach var="categoria" items="${categorias}">
                    <tr>
                        <td>${categoria.nombre_categoria}</td>
                        <td>${categoria.nombre_proyecto}</td>
                        <td>
                            <a href="EditarCategoriaServlet?id_categoria=${categoria.id_categoria}">
                                <button>Editar</button>
                            </a>
                            <a href="EliminarCategoriaServlet?id_categoria=${categoria.id_categoria}" onclick="return confirm('¿Estás seguro de eliminar esta categoría?')">
                                <button>Eliminar</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>
