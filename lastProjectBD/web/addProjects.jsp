<%-- 
    Document   : addProjects
    Created on : 9 abr 2025, 5:44:36 p. m.
    Author     : adria
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Agregar Proyecto</title>
        <!-- Usar el mismo archivo CSS que addUsers.jsp -->
        <link rel="stylesheet" href="styles/styleAddProjects.css">
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
                    <a class="nav-link" href="styles/addTask.jsp">Agregar Tareas</a>
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>
        <div class="form-container">
            <h1 class="form-title">Agregar Nuevo Proyecto</h1>
            <form action="AgregarProyectoServlet" method="post">
                <div class="form-group">
                    <label for="nombre">Nombre:</label>
                    <input type="text" id="nombre" name="nombre" class="form-input" required>
                </div>
                <div class="form-group">
                    <label for="descripcion">Descripción:</label>
                    <textarea id="descripcion" name="descripcion" class="form-input" rows="4"></textarea>
                </div>
                <div class="form-group">
                    <label for="fechaInicio">Fecha de inicio:</label>
                    <input type="date" id="fechaInicio" name="fechaInicio" class="form-input">
                </div>
                <div class="form-group">
                    <label for="fechaFin">Fecha de fin:</label>
                    <input type="date" id="fechaFin" name="fechaFin" class="form-input">
                </div>
                <div class="form-group">
                    <label for="estado">Estado:</label>
                    <select id="estado" name="estado" class="form-input">
                        <option value="PENDIENTE">Pendiente</option>
                        <option value="EN_PROGRESO">En progreso</option>
                        <option value="COMPLETADO">Completado</option>
                        <option value="CANCELADO">Cancelado</option>
                    </select>
                </div>
                <div class="form-buttons">
                    <button type="submit" class="btn-submit">Guardar Proyecto</button>
                    <a href="listarProyectos.jsp" class="btn-cancelar">Cancelar</a>
                </div>
            </form>
        </div>
    </body>
</html>