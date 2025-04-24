<%-- 
    Document   : calendar
    Created on : 23 abr 2025
    Author     : adria
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Calendario de Tareas</title>
    <link rel="stylesheet" href="styles/styleCalendar.css">
    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js" rel="stylesheet">
</head>
<body>
    <header>
        <nav class="nav">
            <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>
            <ul class="nav-links">
                <li><a href="addTask.jsp" class="nav-link">Agregar Tarea</a></li>
                <li><a href="addProjects.jsp" class="nav-link">Agregar Proyecto</a></li>
                <li><a href="index.jsp" class="nav-link">Log out</a></li>
            </ul>
        </nav>
    </header>

    <div class="calendar-container">
        <h1 class="calendar-title">Calendario de Tareas</h1>
        <div id="calendar"></div>
    </div>

    <!-- FullCalendar JS -->
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.17/index.global.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const calendarEl = document.getElementById('calendar');
            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                locale: 'es', // Idioma español
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                },
                events: [
                    <c:forEach items="${tareas}" var="tarea">
                    {
                        title: '${tarea.nombreTarea}',
                        start: '${tarea.fechaLimite}',
                        description: '${tarea.descripcion}',
                        backgroundColor: '${tarea.estado == "Completada" ? "#4CAF50" : (tarea.estado == "En progreso" ? "#FFC107" : "#F44336")}',
                        borderColor: '#000',
                        textColor: '#fff'
                    },
                    </c:forEach>
                ],
                eventClick: function (info) {
                    alert('Tarea: ' + info.event.title + '\nDescripción: ' + info.event.extendedProps.description);
                }
            });
            calendar.render();
        });
    </script>
</body>
</html>
