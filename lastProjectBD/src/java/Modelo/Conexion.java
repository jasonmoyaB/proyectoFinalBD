/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
   Connection con;
   String url = "jdbc:oracle:thin:@localhost:1521:xe";
   String user = "proyectoMain";
   String pass = "mbrenes12";

   public Connection conectar() {
      try {
         Class.forName("oracle.jdbc.driver.OracleDriver");
         this.con = DriverManager.getConnection(this.url, this.user, this.pass);
         System.out.println("Conexión exitosa a la base de datos.");
      } catch (Exception var2) {
         var2.printStackTrace();
      }

      return this.con;
   }
}