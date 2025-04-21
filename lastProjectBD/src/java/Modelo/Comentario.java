
package Modelo;
import java.util.Date;


public class Comentario {
    private String contenido;
    private Date fechaComentario;

    public Comentario() {}

    public Comentario(String contenido, Date fechaComentario) {
        this.contenido = contenido;
        this.fechaComentario = fechaComentario;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public Date getFechaComentario() {
        return fechaComentario;
    }

    public void setFechaComentario(Date fechaComentario) {
        this.fechaComentario = fechaComentario;
    }
}

