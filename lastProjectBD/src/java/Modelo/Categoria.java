
package Modelo;


public class Categoria {
    private int id_categoria;
    private String nombre_categoria;
    private String nombre_proyecto;

    // Getter y Setter para id_categoria
    public int getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(int id_categoria) {
        this.id_categoria = id_categoria;
    }

    // Getter y Setter para nombre_categoria
    public String getNombre_categoria() {
        return nombre_categoria;
    }

    public void setNombre_categoria(String nombre_categoria) {
        this.nombre_categoria = nombre_categoria;
    }

    // Getter y Setter para nombre_proyecto
    public String getNombre_proyecto() {
        return nombre_proyecto;
    }

    public void setNombre_proyecto(String nombre_proyecto) {
        this.nombre_proyecto = nombre_proyecto;
    }
}
