<%-- 
    Document   : taskList
    Created on : 20 abr 2025, 5:49:11 p. m.
    Author     : adria
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, Modelo.Tarea" %>
<%
    List<Tarea> tareas = (List<Tarea>) request.getAttribute("tareas");
    Integer proyectoId = (Integer) request.getAttribute("proyectoId");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Listado de Tareas</title>
</head>
<body>
    <h2>Lista de Tareas del Proyecto <%= proyectoId != null ? proyectoId : "" %></h2>

    <!-- Mensajes -->
    <c:if test="${not empty msg}">
        <p style="color: green;">${msg}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>

    <!-- Tabla de tareas -->
    <table border="1" cellpadding="8" cellspacing="0">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Estado</th>
            <th>Fecha Límite</th>
            <th>Tiempo Dedicado (min)</th>
            <th>Acciones</th>
        </tr>

        <%
            if (tareas != null && !tareas.isEmpty()) {
                for (Tarea t : tareas) {
        %>
        <tr>
            <td><%= t.getTareaId() %></td>
            <td><%= t.getNombre() %></td>
            <td><%= t.getDescripcion() %></td>
            <td><%= t.getEstado() %></td>
            <td><%= t.getFechaLimite() %></td>
            <td><%= t.getTiempoDedicado() / 60000 %></td>

            <td>
                <!-- Botón Editar -->
                <form action="EditarTareaServlet" method="get" style="display:inline;">
                    <input type="hidden" name="tareaId" value="<%= t.getTareaId() %>">
                    <input type="hidden" name="projectId" value="<%= t.getProyectoId() %>">
                    <input type="submit" value="Editar">
                </form>

                <!-- Botón Eliminar -->
                <form action="EliminarTareaServlet" method="post" style="display:inline;" onsubmit="return confirm('¿Estás seguro de eliminar esta tarea?');">
                    <input type="hidden" name="tareaId" value="<%= t.getTareaId() %>">
                    <input type="hidden" name="projectId" value="<%= t.getProyectoId() %>">
                    <input type="submit" value="Eliminar">
                </form>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="7">No hay tareas registradas para este proyecto.</td>
        </tr>
        <%
            }
        %>
    </table>

    <br>
    <a href="addTask.jsp">➕ Añadir nueva tarea</a>
</body>
</html>

