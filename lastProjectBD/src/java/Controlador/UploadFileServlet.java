package Controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@WebServlet("/UploadFileServlet")
@MultipartConfig
public class UploadFileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Usar una ruta absoluta para la carpeta uploads
        String uploadDirectory = "C:\\Users\\jason\\OneDrive - Universidad Fidélitas\\Escritorio\\proyectoFinalBD\\uploads"; // ruta en que se guarda

        // Verificar si la ruta de carga es válida
        File uploadDir = new File(uploadDirectory);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Si no existe la carpeta, la creamos
        }

        // Obtenemos el archivo subido
        Part filePart = request.getPart("file"); 
        if (filePart == null) {
            request.setAttribute("errorMessage", "No se ha seleccionado ningún archivo.");
            request.getRequestDispatcher("upload.jsp").forward(request, response);
            return; // Terminar la ejecución si no hay archivo
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        File file = new File(uploadDir, fileName);

        // Intentamos guardar el archivo
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            request.setAttribute("successMessage", "Archivo subido exitosamente.");
        } catch (IOException e) {
            request.setAttribute("errorMessage", "Error al subir el archivo: " + e.getMessage());
        }

        // Redirigimos al usuario de vuelta a la página de carga
        request.getRequestDispatcher("upload.jsp").forward(request, response);
    }
}


