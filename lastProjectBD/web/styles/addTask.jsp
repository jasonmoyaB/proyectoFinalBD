<%-- 
    Document   : addTask
    Created on : 20 abr 2025, 5:13:46 p. m.
    Author     : adria
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles/styleAddProjects.css"/>
    <title>Gestión de Tareas</title>
    <style>
        .tasks-container {
            margin-top: 30px;
            width: 100%;
        }
        
        .tasks-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        
        .tasks-table th, .tasks-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        
        .tasks-table th {
            background-color: #f2f2f2;
            color: #333;
        }
        
        .tasks-table tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        
        .tasks-table tr:hover {
            background-color: #e9e9e9;
        }
        
        .timer-controls {
            display: flex;
            gap: 5px;
        }
        
        .timer-btn {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 12px;
        }
        
        .start-btn {
            background-color: #4CAF50;
            color: white;
        }
        
        .pause-btn {
            background-color: #f39c12;
            color: white;
        }
        
        .reset-btn {
            background-color: #e74c3c;
            color: white;
        }
        
        .tabs {
            display: flex;
            margin-bottom: 20px;
        }
        
        .tab {
            padding: 10px 20px;
            cursor: pointer;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
            border-bottom: none;
            border-radius: 5px 5px 0 0;
            margin-right: 5px;
        }
        
        .tab.active {
            background-color: #fff;
            border-bottom: 1px solid white;
        }
        
        .tab-content {
            display: none;
        }
        
        .tab-content.active {
            display: block;
        }
    </style>
    <script>
        // Objeto para almacenar todos los cronómetros
        const timerStates = {};
        
        // Función para inicializar un cronómetro para una tarea específica
        function initTimer(taskId, savedTime) {
            if (!timerStates[taskId]) {
                timerStates[taskId] = {
                    timer: null,
                    elapsedTime: savedTime || 0,
                    isRunning: false
                };
            }
            updateTaskTimerDisplay(taskId);
        }
        
        function formatTime(ms) {
            const totalSeconds = Math.floor(ms / 1000);
            const hours = String(Math.floor(totalSeconds / 3600)).padStart(2, '0');
            const minutes = String(Math.floor((totalSeconds % 3600) / 60)).padStart(2, '0');
            const seconds = String(totalSeconds % 60).padStart(2, '0');
            return `${hours}:${minutes}:${seconds}`;
        }
        
        function updateTaskTimerDisplay(taskId) {
            const timerState = timerStates[taskId];
            if (timerState) {
                document.getElementById(`timer-${taskId}`).innerText = formatTime(timerState.elapsedTime);
                document.getElementById(`hidden-time-${taskId}`).value = timerState.elapsedTime;
            }
        }
        
        function startTaskTimer(taskId) {
            const timerState = timerStates[taskId];
            if (timerState && !timerState.isRunning) {
                timerState.isRunning = true;
                const startTime = Date.now() - timerState.elapsedTime;
                timerState.timer = setInterval(() => {
                    timerState.elapsedTime = Date.now() - startTime;
                    updateTaskTimerDisplay(taskId);
                }, 1000);
            }
        }
        
        function pauseTaskTimer(taskId) {
            const timerState = timerStates[taskId];
            if (timerState && timerState.isRunning) {
                timerState.isRunning = false;
                clearInterval(timerState.timer);
                
                // Enviar actualización al servidor
                updateTaskTime(taskId, timerState.elapsedTime);
            }
        }
        
        function resetTaskTimer(taskId) {
            const timerState = timerStates[taskId];
            if (timerState) {
                if (timerState.isRunning) {
                    clearInterval(timerState.timer);
                    timerState.isRunning = false;
                }
                timerState.elapsedTime = 0;
                updateTaskTimerDisplay(taskId);
                
                // Enviar actualización al servidor
                updateTaskTime(taskId, 0);
            }
        }
        
        // Función para actualizar el tiempo de la tarea en el servidor
        function updateTaskTime(taskId, time) {
            fetch('ActualizarTiempoTareaServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `taskId=${taskId}&elapsedTime=${time}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.status === 'success') {
                    console.log(`Tiempo actualizado para tarea ${taskId}`);
                } else {
                    console.error('Error al actualizar tiempo:', data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
            });
        }
        
        // Función para alternar entre pestañas
        function openTab(evt, tabName) {
            const tabcontent = document.getElementsByClassName("tab-content");
            for (let i = 0; i < tabcontent.length; i++) {
                tabcontent[i].classList.remove("active");
            }
            
            const tablinks = document.getElementsByClassName("tab");
            for (let i = 0; i < tablinks.length; i++) {
                tablinks[i].classList.remove("active");
            }
            
            document.getElementById(tabName).classList.add("active");
            evt.currentTarget.classList.add("active");
        }
        
        // Para el formulario de nueva tarea
        let newTaskTimer;
        let newTaskElapsedTime = 0;
        let newTaskIsRunning = false;

        function updateNewTaskDisplay() {
            document.getElementById('newTaskTimerDisplay').innerText = formatTime(newTaskElapsedTime);
            document.getElementById('newTaskHiddenTime').value = newTaskElapsedTime;
        }

        function startNewTaskTimer() {
            if (!newTaskIsRunning) {
                newTaskIsRunning = true;
                const startTime = Date.now() - newTaskElapsedTime;
                newTaskTimer = setInterval(() => {
                    newTaskElapsedTime = Date.now() - startTime;
                    updateNewTaskDisplay();
                }, 1000);
            }
        }

        function pauseNewTaskTimer() {
            if (newTaskIsRunning) {
                newTaskIsRunning = false;
                clearInterval(newTaskTimer);
            }
        }

        function resetNewTaskTimer() {
            pauseNewTaskTimer();
            newTaskElapsedTime = 0;
            updateNewTaskDisplay();
        }
        
        // Inicializar todo cuando se carga la página
        window.onload = function() {
            updateNewTaskDisplay();
            
            // Inicializar cronómetros para tareas existentes
            <c:forEach items="${tareas}" var="tarea">
                initTimer(${tarea.tareaId}, ${tarea.tiempoDedicado});
            </c:forEach>
            
            // Activar la primera pestaña por defecto
            document.getElementsByClassName("tab")[0].click();
        };
    </script>
</head>
<body>
    <div class="form-container">
        <h1 class="form-title">Gestión de Tareas</h1>
        
        <div class="tabs">
            <button class="tab" onclick="openTab(event, 'nuevaTarea')">Nueva Tarea</button>
            <button class="tab" onclick="openTab(event, 'tareasExistentes')">Tareas Existentes</button>
        </div>
        
        <div id="nuevaTarea" class="tab-content">
            <form action="AgregarTareasServlet" method="post">
                <div class="form-group">
                    <label for="taskName">Nombre de la tarea:</label>
                    <input type="text" id="taskName" name="taskName" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Descripción:</label>
                    <textarea id="description" name="description" class="form-input" rows="4"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="estado">Estado:</label>
                    <select id="estado" name="estado" class="form-input">
                        <option value="Pendiente">Pendiente</option>
                        <option value="En progreso">En progreso</option>
                        <option value="Completada">Completada</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="fechaLimite">Fecha límite:</label>
                    <input type="date" id="fechaLimite" name="fechaLimite" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label for="projectId">ID del Proyecto:</label>
                    <input type="number" id="projectId" name="projectId" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label for="usuarioId">ID del Usuario:</label>
                    <input type="number" id="usuarioId" name="usuarioId" class="form-input" required>
                </div>
                
                <div class="form-group">
                    <label>Tiempo dedicado (cronómetro):</label>
                    <div class="timer-container">
                        <span id="newTaskTimerDisplay" class="timer-display">00:00:00</span>
                        <input type="hidden" id="newTaskHiddenTime" name="elapsedTime" value="0">
                        <div class="timer-controls">
                            <button type="button" class="timer-btn start-btn" onclick="startNewTaskTimer()">Iniciar</button>
                            <button type="button" class="timer-btn pause-btn" onclick="pauseNewTaskTimer()">Pausar</button>
                            <button type="button" class="timer-btn reset-btn" onclick="resetNewTaskTimer()">Resetear</button>
                        </div>
                    </div>
                </div>
                
                <div class="form-buttons">
                    <button type="submit" class="btn-submit">Guardar Tarea</button>
                    <a href="listarTareas.jsp" class="btn-cancelar">Cancelar</a>
                </div>
            </form>
        </div>
        
        <div id="tareasExistentes" class="tab-content">
            <div class="tasks-container">
                <h2>Tareas Existentes</h2>
                
                <table class="tasks-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Estado</th>
                            <th>Fecha Límite</th>
                            <th>Tiempo Dedicado</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${tareas}" var="tarea">
                            <tr>
                                <td>${tarea.tareaId}</td>
                                <td>${tarea.nombreTarea}</td>
                                <td>${tarea.estado}</td>
                                <td>${tarea.fechaLimite}</td>
                                <td>
                                    <span id="timer-${tarea.tareaId}">00:00:00</span>
                                    <form id="timerForm-${tarea.tareaId}" action="ActualizarTiempoTareaServlet" method="post" style="display:none;">
                                        <input type="hidden" name="taskId" value="${tarea.tareaId}">
                                        <input type="hidden" id="hidden-time-${tarea.tareaId}" name="elapsedTime" value="${tarea.tiempoDedicado}">
                                    </form>
                                </td>
                                <td>
                                    <div class="timer-controls">
                                        <button type="button" class="timer-btn start-btn" onclick="startTaskTimer(${tarea.tareaId})">▶</button>
                                        <button type="button" class="timer-btn pause-btn" onclick="pauseTaskTimer(${tarea.tareaId})">⏸</button>
                                        <button type="button" class="timer-btn reset-btn" onclick="resetTaskTimer(${tarea.tareaId})">⟲</button>
                                        <a href="EditarTareaServlet?id=${tarea.tareaId}" class="timer-btn">✏️</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>