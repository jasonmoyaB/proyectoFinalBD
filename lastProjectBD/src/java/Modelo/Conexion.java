package Modelo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

public class Conexion {
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe"; // Asegúrate de que estos valores sean correctos
    private static final String USER = "proyectoMain";
    private static final String PASSWORD = "mbrenes12";
    
    public Connection conectar() {
        Connection conn = null;
        try {
            // Cargar el driver de Oracle
            Class.forName("oracle.jdbc.OracleDriver");
            // Establecer la conexión
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Conexión exitosa a la base de datos.");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    
    
}

