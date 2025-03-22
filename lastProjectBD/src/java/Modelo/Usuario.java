package Modelo;

public class Usuario {
    private int id_usuario;
    private String nombre;
    private String correo;
    private String contraseña; // Asegúrate de que esta variable exista
    private String nombreRol;
    private String nombreDepartamento;

    // Getters y setters
    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContraseña() { // Getter de contraseña
        return contraseña;
    }

    public void setContraseña(String contraseña) { // Setter de contraseña
        this.contraseña = contraseña;
    }

    public String getNombreRol() {
        return nombreRol;
    }

    public void setNombreRol(String nombreRol) {
        this.nombreRol = nombreRol;
    }

    public String getNombreDepartamento() {
        return nombreDepartamento;
    }

    public void setNombreDepartamento(String nombreDepartamento) {
        this.nombreDepartamento = nombreDepartamento;
    }
}



