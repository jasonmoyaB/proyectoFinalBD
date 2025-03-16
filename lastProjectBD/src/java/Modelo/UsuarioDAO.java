package Modelo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {
   public String obtenerRolUsuario(String username, String password) {
      String rol = null;
      String sql = "SELECT r.nombre_rol FROM fide_usuarios_tb u JOIN fide_roles_tb r ON u.id_rol = r.id_rol WHERE u.nombre = ? AND u.contraseña = ?";

      try {
         Connection con = (new Conexion()).conectar();

         try {
            PreparedStatement pst = con.prepareStatement(sql);

            try {
               pst.setString(1, username);
               pst.setString(2, password);
               ResultSet rs = pst.executeQuery();
               if (rs.next()) {
                  rol = rs.getString("nombre_rol");
               }
            } catch (Throwable var11) {
               if (pst != null) {
                  try {
                     pst.close();
                  } catch (Throwable var10) {
                     var11.addSuppressed(var10);
                  }
               }

               throw var11;
            }

            if (pst != null) {
               pst.close();
            }
         } catch (Throwable var12) {
            if (con != null) {
               try {
                  con.close();
               } catch (Throwable var9) {
                  var12.addSuppressed(var9);
               }
            }

            throw var12;
         }

         if (con != null) {
            con.close();
         }
      } catch (SQLException var13) {
         var13.printStackTrace();
      }

      return rol;
   }

   public boolean validarUsuario(String username, String password) {
      boolean valido = false;
      String sql = "SELECT * FROM fide_usuarios_tb WHERE nombre = ? AND contraseña = ?";

      try {
         Connection con = (new Conexion()).conectar();

         try {
            PreparedStatement pst = con.prepareStatement(sql);

            try {
               pst.setString(1, username);
               pst.setString(2, password);
               ResultSet rs = pst.executeQuery();
               if (rs.next()) {
                  valido = true;
               }
            } catch (Throwable var11) {
               if (pst != null) {
                  try {
                     pst.close();
                  } catch (Throwable var10) {
                     var11.addSuppressed(var10);
                  }
               }

               throw var11;
            }

            if (pst != null) {
               pst.close();
            }
         } catch (Throwable var12) {
            if (con != null) {
               try {
                  con.close();
               } catch (Throwable var9) {
                  var12.addSuppressed(var9);
               }
            }

            throw var12;
         }

         if (con != null) {
            con.close();
         }
      } catch (SQLException var13) {
         var13.printStackTrace();
      }

      return valido;
   }

   public boolean agregarUsuario(String nombreUsuario, String correo, String contraseña, String rol) {
      boolean resultado = false;
      String sql = "INSERT INTO fide_usuarios_tb (id_usuario, nombre, correo, contraseña, id_rol) VALUES (fide_usuarios_seq.NEXTVAL, ?, ?, ?, (SELECT id_rol FROM fide_roles_tb WHERE nombre_rol = ?))";

      try {
         Connection con = (new Conexion()).conectar();

         try {
            PreparedStatement pst = con.prepareStatement(sql);

            try {
               pst.setString(1, nombreUsuario);
               pst.setString(2, correo);
               pst.setString(3, contraseña);
               pst.setString(4, rol);
               int filasAfectadas = pst.executeUpdate();
               if (filasAfectadas > 0) {
                  resultado = true;
               }
            } catch (Throwable var13) {
               if (pst != null) {
                  try {
                     pst.close();
                  } catch (Throwable var12) {
                     var13.addSuppressed(var12);
                  }
               }

               throw var13;
            }

            if (pst != null) {
               pst.close();
            }
         } catch (Throwable var14) {
            if (con != null) {
               try {
                  con.close();
               } catch (Throwable var11) {
                  var14.addSuppressed(var11);
               }
            }

            throw var14;
         }

         if (con != null) {
            con.close();
         }
      } catch (SQLException var15) {
         var15.printStackTrace();
      }

      return resultado;
   }
}
