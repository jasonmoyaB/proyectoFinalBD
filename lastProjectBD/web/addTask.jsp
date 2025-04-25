<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/styleaddTarea.css"/>
        <title>Agregar Tarea</title>
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="bienvenido.jsp">CODINGRAPH;</a>                
                    <a class="nav-link" href="login.jsp">Log-out</a>
                </ul>
            </nav>
        </header>

        <div class="container">
            <h2>Agregar Tarea</h2>

            <!-- Mostrar mensaje de éxito si existe -->
            <c:if test="${not empty param.msg}">
                <div class="message success">${param.msg}</div>
            </c:if>

            <!-- Mostrar mensaje de error si existe -->
            <c:if test="${not empty requestScope.error}">
                <div class="message error">${requestScope.error}</div>
            </c:if>

            <!-- 🔧 Cambiado el action para que coincida con el nombre correcto del servlet -->
            <form action="AgregarTareasServlet" method="post">
                <table>
                    <tr>
                        <th>Auto-generado</th>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Estado</th>
                        <th>Fecha Límite</th>
                        <th>Acciones</th>
                    </tr>
                    <tr>
                        <td>Auto-generado</td>
                        <td><input type="text" name="nombre_tarea" required></td>
                        <td><input type="text" name="descripcion" required></td>
                        <td>
                            <select name="estado" required>
                                <option value="Pendiente">Pendiente</option>
                                <option value="En Progreso">En Progreso</option>
                                <option value="Completada">Completada</option>
                            </select>
                        </td>
                        <td><input type="date" name="fecha_limite" required></td>
                        <td><button type="submit">Agregar Tarea</button></td>
                    </tr>
                </table>
            </form>

            <h2>Tareas Registradas</h2>

            <div class="input-wrapper">
                <form action="AgregarTareasServlet" method="get">
                    <input type="text" name="search" class="input" placeholder="Buscar tareas..." />
                    <button type="submit">Buscar</button>
                </form>
            </div>

            <table>
                <tr>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                    <th>Fecha Límite</th>
                    <th>Acciones</th>
                </tr>

                <c:forEach var="tarea" items="${tareas}">
                    <tr>
                        <td>${tarea.nombreTarea}</td>
                        <td>${tarea.descripcion}</td>
                        <td>${tarea.estado}</td>
                        <td>${tarea.fechaLimite}</td>
                        <td>
                            <a href="EditarTareaServlet?id_tarea=${tarea.idTarea}">
                                <button>Editar</button>
                            </a>
                            <a href="EliminarTareaServlet?id_tarea=${tarea.idTarea}" onclick="return confirm('¿Estás seguro de eliminar esta tarea?')">
                                <button>Eliminar</button>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </body>
</html>