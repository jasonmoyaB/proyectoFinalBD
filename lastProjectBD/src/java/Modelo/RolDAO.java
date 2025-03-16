package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class RolDAO {
   public List<String> obtenerRoles() {
      List<String> roles = new ArrayList();
      String sql = "SELECT nombre_rol FROM fide_roles_tb";

      try {
         Connection con = (new Conexion()).conectar();

         try {
            Statement stmt = con.createStatement();

            try {
               ResultSet rs = stmt.executeQuery(sql);

               try {
                  while(rs.next()) {
                     roles.add(rs.getString("nombre_rol"));
                  }
               } catch (Throwable var11) {
                  if (rs != null) {
                     try {
                        rs.close();
                     } catch (Throwable var10) {
                        var11.addSuppressed(var10);
                     }
                  }

                  throw var11;
               }

               if (rs != null) {
                  rs.close();
               }
            } catch (Throwable var12) {
               if (stmt != null) {
                  try {
                     stmt.close();
                  } catch (Throwable var9) {
                     var12.addSuppressed(var9);
                  }
               }

               throw var12;
            }

            if (stmt != null) {
               stmt.close();
            }
         } catch (Throwable var13) {
            if (con != null) {
               try {
                  con.close();
               } catch (Throwable var8) {
                  var13.addSuppressed(var8);
               }
            }

            throw var13;
         }

         if (con != null) {
            con.close();
         }
      } catch (SQLException var14) {
         var14.printStackTrace();
      }

      return roles;
   }

   public boolean agregarRol(String nombreRol) {
      String sql = "INSERT INTO fide_roles_tb (id_rol, nombre_rol) VALUES (fide_roles_seq.NEXTVAL, ?)";

      try {
         Connection con = (new Conexion()).conectar();

         boolean var6;
         try {
            PreparedStatement pst = con.prepareStatement(sql);

            try {
               pst.setString(1, nombreRol);
               int rowsAffected = pst.executeUpdate();
               var6 = rowsAffected > 0;
            } catch (Throwable var9) {
               if (pst != null) {
                  try {
                     pst.close();
                  } catch (Throwable var8) {
                     var9.addSuppressed(var8);
                  }
               }

               throw var9;
            }

            if (pst != null) {
               pst.close();
            }
         } catch (Throwable var10) {
            if (con != null) {
               try {
                  con.close();
               } catch (Throwable var7) {
                  var10.addSuppressed(var7);
               }
            }

            throw var10;
         }

         if (con != null) {
            con.close();
         }

         return var6;
      } catch (SQLException var11) {
         var11.printStackTrace();
         return false;
      }
   }
}
