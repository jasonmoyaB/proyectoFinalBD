package Controlador;

import Modelo.Conexion;
import Modelo.Tarea;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/EliminarTareaServlet")
public class EliminarTareaServlet extends HttpServlet {

    // Elimina la tarea mediante procedimiento almacenado
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int idTarea = Integer.parseInt(request.getParameter("id_tarea"));

        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();

        if (conn != null) {
            CallableStatement cs = null;
            try {
                String sql = "{call proyectoMain_pck.eliminar_tarea(?)}";
                cs = conn.prepareCall(sql);
                cs.setInt(1, idTarea);
                cs.execute();

                request.setAttribute("msg", "Tarea eliminada correctamente");
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al eliminar la tarea: " + e.getMessage());
            } finally {
                try {
                    if (cs != null) cs.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            request.setAttribute("error", "No hay conexión con la base de datos");
        }

        // Obtener la lista actualizada de tareas y redirigir
        List<Tarea> tareas = obtenerTareas();
        request.setAttribute("tareas", tareas);
        request.getRequestDispatcher("addTask.jsp").forward(request, response);
    }

    // Método auxiliar para obtener las tareas desde la vista
    private List<Tarea> obtenerTareas() {
        List<Tarea> lista = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String sql = "SELECT ID_TAREA, NOMBRE_TAREA, DESCRIPCION, ESTADO, FECHA_LIMITE FROM tarea_completa_crud_V";
        try {
            conn = conexion.conectar();
            if (conn != null) {
                ps = conn.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Tarea tarea = new Tarea();
                    tarea.setIdTarea(rs.getInt("ID_TAREA"));
                    tarea.setNombreTarea(rs.getString("NOMBRE_TAREA"));
                    tarea.setDescripcion(rs.getString("DESCRIPCION"));
                    tarea.setEstado(rs.getString("ESTADO"));
                    tarea.setFechaLimite(rs.getDate("FECHA_LIMITE"));
                    lista.add(tarea);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return lista;
    }
}

