package Modelo;

import jakarta.jms.Connection;
import jakarta.resource.cci.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author adria
 */
public class ProyectoDAO {
    public List<Proyecto> obtenerProyectos() {
        List<Proyecto> proyectos = new ArrayList<>();
        String sql = "SELECT * FROM proyectos";
        try (Connection conn = (Connection) new Conexion().conectar();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Proyecto proyecto = new Proyecto();
                proyecto.setId_proyecto(rs.getInt("id_proyecto"));
                proyecto.setNombre_proyecto(rs.getString("nombre_proyecto"));
                proyectos.add(proyecto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return proyectos;
    }
}
