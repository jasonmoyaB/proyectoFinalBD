package Modelo;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProyectoDAO {

    // Método para agregar un proyecto
    public boolean agregarProyecto(Proyecto proyecto) {
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();
        CallableStatement cs = null;

        if (conn == null) {
            System.out.println("Error: No se pudo conectar a la base de datos.");
            return false;
        }

        try {
            String sql = "{call proyectomain_pck.agregar_proyecto(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);
            cs.setString(1, proyecto.getNombreProyecto());
            cs.setString(2, proyecto.getDescripcion());
            cs.setDate(3, proyecto.getFechaCreacion());
            cs.setInt(4, proyecto.getUsuarioId());
            cs.setString(5, proyecto.getCreatedBy());
            cs.setDate(6, proyecto.getCreationDate());
            cs.setString(7, proyecto.getLastUpdateBy());
            cs.setDate(8, proyecto.getLastUpdateDate());
            cs.setString(9, proyecto.getAccion());
            cs.registerOutParameter(10, Types.INTEGER); // ID generado por la base de datos

            cs.execute();
            proyecto.setProyectoId(cs.getInt(10)); // Obtener el ID generado
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (cs != null) cs.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Método para listar todos los proyectos
    public List<Proyecto> listarProyectos() {
        List<Proyecto> proyectos = new ArrayList<>();
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();
        PreparedStatement ps = null;
        ResultSet rs = null;

        if (conn == null) {
            System.out.println("Error: No se pudo conectar a la base de datos.");
            return proyectos;
        }

        try {
            String sql = "SELECT * FROM FIDE_PROYECTOS_TB";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Proyecto proyecto = new Proyecto();
                proyecto.setProyectoId(rs.getInt("PROYECTO_ID"));
                proyecto.setNombreProyecto(rs.getString("NOMBRE_PROYECTO"));
                proyecto.setDescripcion(rs.getString("DESCRIPCION"));
                proyecto.setFechaCreacion(rs.getDate("FECHA_CREACION"));
                proyecto.setUsuarioId(rs.getInt("USUARIO_ID"));
                proyecto.setCreatedBy(rs.getString("CREATED_BY"));
                proyecto.setCreationDate(rs.getDate("CREATION_DATE"));
                proyecto.setLastUpdateBy(rs.getString("LAST_UPDATE_BY"));
                proyecto.setLastUpdateDate(rs.getDate("LAST_UPDATE_DATE"));
                proyecto.setAccion(rs.getString("ACCION"));

                proyectos.add(proyecto);
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

        return proyectos;
    }

    // Método para eliminar un proyecto
    public boolean eliminarProyecto(int proyectoId) {
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();
        CallableStatement cs = null;

        if (conn == null) {
            System.out.println("Error: No se pudo conectar a la base de datos.");
            return false;
        }

        try {
            String sql = "{call proyectomain_pck.eliminar_proyecto(?)}";
            cs = conn.prepareCall(sql);
            cs.setInt(1, proyectoId);
            cs.execute();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (cs != null) cs.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    // Método para actualizar un proyecto
    public boolean actualizarProyecto(Proyecto proyecto) {
        Conexion conexion = new Conexion();
        Connection conn = conexion.conectar();
        CallableStatement cs = null;

        if (conn == null) {
            System.out.println("Error: No se pudo conectar a la base de datos.");
            return false;
        }

        try {
            String sql = "{call proyectomain_pck.actualizar_proyecto(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
            cs = conn.prepareCall(sql);
            cs.setInt(1, proyecto.getProyectoId());
            cs.setString(2, proyecto.getNombreProyecto());
            cs.setString(3, proyecto.getDescripcion());
            cs.setDate(4, proyecto.getFechaCreacion());
            cs.setInt(5, proyecto.getUsuarioId());
            cs.setString(6, proyecto.getCreatedBy());
            cs.setDate(7, proyecto.getLastUpdateDate());
            cs.setString(8, proyecto.getLastUpdateBy());
            cs.setString(9, proyecto.getAccion());

            cs.execute();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            try {
                if (cs != null) cs.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

