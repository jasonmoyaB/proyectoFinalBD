<%-- 
    Document   : contacto
    Created on : 20 mar. 2025, 13:28:42
    Author     : jason
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles/styleContacto.css"/>
        <title>Contactanos</title>
    </head>
    <body>
        <header>
    <nav class="nav">
        <a class="logo" href="index.jsp">CODINGRAPH;</a>
        <ul class="nav-links">
            <li><a class="nav-link" href="sobreNosotros.jsp">Quienes somos</a></li>
            <li><a class="nav-link" href="myTasks.jsp">Mis Tareas</a></li>
            <li><a class="nav-link-login" href="login.jsp">Log-in</a></li>
        </ul>
    </nav>
</header>

<div class="container">
    <h2>Contacto</h2>
    <p>¿Tienes preguntas o necesitas ayuda? ¡Contáctanos!</p>
    <form action="#" method="post">
        <div class="form-group">
            <label for="name">Nombre:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="email">Correo Electrónico:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="message">Mensaje:</label>
            <textarea id="message" name="message" rows="4" required></textarea>
        </div>
        <button type="submit">Enviar</button>
    </form>
</div>
    </body>
</html>
