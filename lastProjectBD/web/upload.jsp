<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Subir Archivos</title>
        <link rel="stylesheet" href="styles/styleUpload.css">
    </head>
    <body>
        <header>
            <nav class="nav">
                <ul>
                    <a class="logo" href="">CODINGRAPH;</a>
                    <a class="nav-link" href="upload.jsp">Subir Archivo</a>
                    <a class="nav-link" href="index.jsp">Log-out</a>
                </ul>
            </nav>
        </header>
        <div class="file-upload-container">
            <h2>Sube tu archivo</h2>

            <!-- Mensajes de retroalimentación -->
            <c:if test="${not empty successMessage}">
                <div class="success-message">${successMessage}</div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="error-message">${errorMessage}</div>
            </c:if>

            <!-- Formulario de carga -->
            <form action="UploadFileServlet" method="post" enctype="multipart/form-data">
                <label for="file">Seleccionar archivo:</label>
                <input type="file" name="file" id="file" class="file-input" required />
                <button type="submit" class="submit-btn">Subir archivo</button>
            </form>
        </div>

    </body>
</html>

