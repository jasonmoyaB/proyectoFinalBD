<%-- 
    Document   : editarTarea
    Created on : 20 abr 2025, 5:43:42 p. m.
    Author     : adria
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="Modelo.Tarea" %>
<%
    Tarea tarea = (Tarea) request.getAttribute("tarea");
%>
<html>
<head>
    <title>Editar Tarea</title>
</head>
<body>
    <h2>Editar Tarea</h2>

    <form action="EditarTareaServlet" method="post">
        <input type="hidden" name="tareaId" value="<%= tarea.getTareaId() %>">
        <input type="hidden" name="projectId" value="<%= tarea.getProyectoId() %>">

        <label>Nombre de la tarea:</label><br>
        <input type="text" name="taskName" value="<%= tarea.getNombre() %>" required><br><br>

        <label>Descripción:</label><br>
        <textarea name="description" rows="4" cols="40"><%= tarea.getDescripcion() %></textarea><br><br>

        <label>Estado:</label><br>
        <select name="estado">
            <option value="Pendiente" <%= "Pendiente".equals(tarea.getEstado()) ? "selected" : "" %>>Pendiente</option>
            <option value="En progreso" <%= "En progreso".equals(tarea.getEstado()) ? "selected" : "" %>>En progreso</option>
            <option value="Completada" <%= "Completada".equals(tarea.getEstado()) ? "selected" : "" %>>Completada</option>
        </select><br><br>

        <label>Fecha límite:</label><br>
        <input type="date" name="fechaLimite" value="<%= tarea.getFechaLimite() %>" required><br><br>

        <input type="submit" value="Actualizar Tarea">
    </form>
</body>
</html>

