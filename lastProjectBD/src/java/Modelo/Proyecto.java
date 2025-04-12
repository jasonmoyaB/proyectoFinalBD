/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Modelo;

import java.util.Date;
/**
 *
 * @author adria
 */
public class Proyecto {
    private int id_proyecto;
    private String nombre_proyecto;
    private String descripcion_proyecto;
    private Date fechaInicio_p;
    private Date fechaFin_p;
    private String estado_p;
    private Date fechaCreacion_p;
    
    public int getId_proyecto() {
        return id_proyecto;
    }
    
    public void setId_proyecto(int id_proyecto) {
        this.id_proyecto = id_proyecto;
    }
    
    public String getNombre_proyecto() {
        return nombre_proyecto;
    }
    
    public void setNombre_proyecto(String nombre_proyecto) {
        this.nombre_proyecto = nombre_proyecto;
    }
    
    public String getDescripcion_proyecto() {
        return descripcion_proyecto;
    }
    
    public void setDescripcion_proyecto(String descripcion_proyecto) {
        this.descripcion_proyecto = descripcion_proyecto;
    }
    
    public Date getFechaInicio_p() {
        return fechaInicio_p;
    }
    
    public void setFechaInicio_p(Date fechaInicio_p) {
        this.fechaInicio_p = fechaInicio_p;
    }
    
    public Date getFechaFin_p() {
        return fechaFin_p;
    }
    
    public void setFechaFin_p(Date fechaFin_p) {
        this.fechaFin_p = fechaFin_p;
    }
    
    public String getEstado_p() {
        return estado_p;
    }
    
    public void setEstado_p(String estado_p) {
        this.estado_p = estado_p;
    }
    
    public Date getFechaCreacion_p() {
        return fechaCreacion_p;
    }
    
    public void setFechaCreacion_p(Date fechaCreacion_p) {
        this.fechaCreacion_p = fechaCreacion_p;
    }
    
}



