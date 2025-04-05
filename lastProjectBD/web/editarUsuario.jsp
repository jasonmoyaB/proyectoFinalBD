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
                <select name="rol" required>
                    <option value="">Seleccione un rol</option>
                    <option value="1" ${usuario.nombreRol == '1' ? 'selected' : ''}>Admin</option>
                    <option value="2" ${usuario.nombreRol == '2' ? 'selected' : ''}>Usuario</option>
                    <option value="3" ${usuario.nombreRol == '3' ? 'selected' : ''}>Gerente</option>
                    <option value="4" ${usuario.nombreRol == '4' ? 'selected' : ''}>Supervisor</option>
                    <option value="5" ${usuario.nombreRol == '5' ? 'selected' : ''}>Empleado</option>
                    <option value="6" ${usuario.nombreRol == '6' ? 'selected' : ''}>Cliente</option>
                    <option value="7" ${usuario.nombreRol == '7' ? 'selected' : ''}>Vendedor</option>
                    <option value="8" ${usuario.nombreRol == '8' ? 'selected' : ''}>Desarrollador</option>
                    <option value="9" ${usuario.nombreRol == '9' ? 'selected' : ''}>Tester</option>
                    <option value="10" ${usuario.nombreRol == '10' ? 'selected' : ''}>Administrador de Base de Datos</option>
                    <option value="11" ${usuario.nombreRol == '11' ? 'selected' : ''}>Analista</option>
                    <option value="12" ${usuario.nombreRol == '12' ? 'selected' : ''}>Soporte</option>
                    <option value="13" ${usuario.nombreRol == '13' ? 'selected' : ''}>Director</option>
                    <option value="14" ${usuario.nombreRol == '14' ? 'selected' : ''}>Product Owner</option>
                    <option value="15" ${usuario.nombreRol == '15' ? 'selected' : ''}>Scrum Master</option>
                    <option value="16" ${usuario.nombreRol == '16' ? 'selected' : ''}>Coordinador</option>
                    <option value="17" ${usuario.nombreRol == '17' ? 'selected' : ''}>Administrador de Sistema</option>
                    <option value="18" ${usuario.nombreRol == '18' ? 'selected' : ''}>Analista de Datos</option>
                    <option value="19" ${usuario.nombreRol == '19' ? 'selected' : ''}>Ingeniero de Software</option>
                    <option value="20" ${usuario.nombreRol == '20' ? 'selected' : ''}>Jefe de Proyecto</option>
                    <option value="21" ${usuario.nombreRol == '21' ? 'selected' : ''}>Programador Junior</option>
                    <option value="22" ${usuario.nombreRol == '22' ? 'selected' : ''}>Programador Senior</option>
                    <option value="23" ${usuario.nombreRol == '23' ? 'selected' : ''}>Arquitecto de Software</option>
                    <option value="24" ${usuario.nombreRol == '24' ? 'selected' : ''}>Consultor</option>
                    <option value="25" ${usuario.nombreRol == '25' ? 'selected' : ''}>Diseñador de Interfaz</option>
                    <option value="26" ${usuario.nombreRol == '26' ? 'selected' : ''}>Ingeniero de Calidad</option>
                    <option value="27" ${usuario.nombreRol == '27' ? 'selected' : ''}>Administrador de Infraestructura</option>
                    <option value="28" ${usuario.nombreRol == '28' ? 'selected' : ''}>Gestor de Proyectos</option>
                    <option value="29" ${usuario.nombreRol == '29' ? 'selected' : ''}>Auditor de Seguridad</option>
                    <option value="30" ${usuario.nombreRol == '30' ? 'selected' : ''}>Analista de Soporte Técnico</option>
                </select>

                <label for="departamento">Departamento (ID):</label>
                <select name="departamento" required>
                    <option value="">Seleccione un departamento</option>
                    <option value="1" ${usuario.nombreDepartamento == '1' ? 'selected' : ''}>IT</option>
                    <option value="2" ${usuario.nombreDepartamento == '2' ? 'selected' : ''}>Recursos Humanos</option>
                    <option value="3" ${usuario.nombreDepartamento == '3' ? 'selected' : ''}>Ventas</option>
                    <option value="4" ${usuario.nombreDepartamento == '4' ? 'selected' : ''}>Marketing</option>
                    <option value="5" ${usuario.nombreDepartamento == '5' ? 'selected' : ''}>Finanzas</option>
                    <option value="6" ${usuario.nombreDepartamento == '6' ? 'selected' : ''}>Legal</option>
                    <option value="7" ${usuario.nombreDepartamento == '7' ? 'selected' : ''}>Producción</option>
                    <option value="8" ${usuario.nombreDepartamento == '8' ? 'selected' : ''}>Investigación y Desarrollo</option>
                    <option value="9" ${usuario.nombreDepartamento == '9' ? 'selected' : ''}>Atención al Cliente</option>
                    <option value="10" ${usuario.nombreDepartamento == '10' ? 'selected' : ''}>Logística</option>
                    <option value="11" ${usuario.nombreDepartamento == '11' ? 'selected' : ''}>Administración</option>
                    <option value="12" ${usuario.nombreDepartamento == '12' ? 'selected' : ''}>Soporte Técnico</option>
                    <option value="13" ${usuario.nombreDepartamento == '13' ? 'selected' : ''}>Planificación</option>
                    <option value="14" ${usuario.nombreDepartamento == '14' ? 'selected' : ''}>Calidad</option>
                    <option value="15" ${usuario.nombreDepartamento == '15' ? 'selected' : ''}>Relaciones Públicas</option>
                    <option value="16" ${usuario.nombreDepartamento == '16' ? 'selected' : ''}>Seguridad</option>
                    <option value="17" ${usuario.nombreDepartamento == '17' ? 'selected' : ''}>Innovación</option>
                    <option value="18" ${usuario.nombreDepartamento == '18' ? 'selected' : ''}>Desarrollo de Producto</option>
                    <option value="19" ${usuario.nombreDepartamento == '19' ? 'selected' : ''}>Comunicación Corporativa</option>
                    <option value="20" ${usuario.nombreDepartamento == '20' ? 'selected' : ''}>Gestión de Proyectos</option>
                    <option value="21" ${usuario.nombreDepartamento == '21' ? 'selected' : ''}>Redes y Comunicaciones</option>
                    <option value="22" ${usuario.nombreDepartamento == '22' ? 'selected' : ''}>Gestión de Talento</option>
                    <option value="23" ${usuario.nombreDepartamento == '23' ? 'selected' : ''}>Servicio al Cliente</option>
                    <option value="24" ${usuario.nombreDepartamento == '24' ? 'selected' : ''}>Expansión de Mercado</option>
                    <option value="25" ${usuario.nombreDepartamento == '25' ? 'selected' : ''}>Auditoría Interna</option>
                    <option value="26" ${usuario.nombreDepartamento == '26' ? 'selected' : ''}>Relaciones Internacionales</option>
                    <option value="27" ${usuario.nombreDepartamento == '27' ? 'selected' : ''}>Estrategia y Planeación</option>
                    <option value="28" ${usuario.nombreDepartamento == '28' ? 'selected' : ''}>Alianzas Estratégicas</option>
                    <option value="29" ${usuario.nombreDepartamento == '29' ? 'selected' : ''}>Desarrollo de Negocios</option>
                    <option value="30" ${usuario.nombreDepartamento == '30' ? 'selected' : ''}>Customer Success</option>
                </select>

                <button type="submit">Actualizar</button>
            </form>
        </div>
    </body>
</html>


