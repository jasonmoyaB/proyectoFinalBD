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
                <th>Rol</th>
                <th>Departamento</th>
                <th>Acciones</th>
            </tr>
            <tr>
                <td>Auto-generado</td>
                <td><input type="text" name="nombre" required></td>
                <td><input type="email" name="correo" required></td>
                <td><input type="password" name="password" required></td>
                <td>
                    <select name="rol" required>
                        <!-- Roles fijos -->
                        <option value="1">admin</option>
                        <option value="2">usuario</option>
                        <option value="3">gerente</option>
                        <option value="4">supervisor</option>
                        <option value="5">empleado</option>
                        <option value="6">cliente</option>
                        <option value="7">vendedor</option>
                        <option value="8">desarrollador</option>
                        <option value="9">tester</option>
                        <option value="10">administrador de base de datos</option>
                        <option value="11">analista</option>
                        <option value="12">soporte</option>
                        <option value="13">director</option>
                        <option value="14">product owner</option>
                        <option value="15">scrum master</option>
                        <option value="16">coordinador</option>
                        <option value="17">administrador de sistema</option>
                        <option value="18">analista de datos</option>
                        <option value="19">ingeniero de software</option>
                        <option value="20">jefe de proyecto</option>
                        <option value="21">programador junior</option>
                        <option value="22">programador senior</option>
                        <option value="23">arquitecto de software</option>
                        <option value="24">consultor</option>
                        <option value="25">diseñador de interfaz</option>
                        <option value="26">ingeniero de calidad</option>
                        <option value="27">administrador de infraestructura</option>
                        <option value="28">gestor de proyectos</option>
                        <option value="29">auditor de seguridad</option>
                        <option value="30">analista de soporte técnico</option>
                    </select>
                </td>
                <td>
                    <select name="departamento" required>
                        <!-- Departamentos fijos -->
                        <option value="1">IT</option>
                        <option value="2">Recursos Humanos</option>
                        <option value="3">Ventas</option>
                        <option value="4">Marketing</option>
                        <option value="5">Finanzas</option>
                        <option value="6">Legal</option>
                        <option value="7">Producción</option>
                        <option value="8">Investigación y Desarrollo</option>
                        <option value="9">Atención al Cliente</option>
                        <option value="10">Logística</option>
                        <option value="11">Administración</option>
                        <option value="12">Soporte Técnico</option>
                        <option value="13">Planificación</option>
                        <option value="14">Calidad</option>
                        <option value="15">Relaciones Públicas</option>
                        <option value="16">Seguridad</option>
                        <option value="17">Innovación</option>
                        <option value="18">Desarrollo de Producto</option>
                        <option value="19">Comunicación Corporativa</option>
                        <option value="20">Gestión de Proyectos</option>
                        <option value="21">Redes y Comunicaciones</option>
                        <option value="22">Gestión de Talento</option>
                        <option value="23">Servicio al Cliente</option>
                        <option value="24">Expansión de Mercado</option>
                        <option value="25">Auditoría Interna</option>
                        <option value="26">Relaciones Internacionales</option>
                        <option value="27">Estrategia y Planeación</option>
                        <option value="28">Alianzas Estratégicas</option>
                        <option value="29">Desarrollo de Negocios</option>
                        <option value="30">Customer Success</option>
                    </select>
                </td>
                <td><button type="submit">Agregar Usuario</button></td>
            </tr>
        </table>
    </form>

    <h2>Usuarios Registrados</h2>
    <table>
        <tr>
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
                <td>${usuario.nombre}</td>
                <td>${usuario.correo}</td>
                <td>******</td>
                <td>${usuario.nombreRol}</td>
                <td>${usuario.nombreDepartamento}</td>
                <td>
                    <a href="EditarUsuarioServlet?id_usuario=${usuario.id_usuario}">
                        <button>Editar</button>
                    </a>
                    <a href="EliminarUsuarioServlet?id_usuario=${usuario.id_usuario}"
                       onclick="return confirm('¿Estás seguro de eliminar este usuario?')">
                        <button>Eliminar</button>
                    </a>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>
</html>





