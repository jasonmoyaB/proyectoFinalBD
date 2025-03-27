create or replace NONEDITIONABLE PACKAGE seguimiento_tareas_empresas AS
    -- Funciones
    FUNCTION get_usuario_mas_tareas_FN RETURN VARCHAR2;
    FUNCTION get_proyecto_mas_tareas_FN RETURN VARCHAR2;
    FUNCTION get_usuarios_sin_tareas_FN RETURN NUMBER;
    FUNCTION get_tarea_mas_urgente_FN RETURN VARCHAR2;
    FUNCTION get_total_horas_trabajadas_FN RETURN NUMBER;
    FUNCTION get_fecha_mas_importante_FN RETURN DATE;
    FUNCTION get_estado_mas_comun_FN RETURN VARCHAR2;
    FUNCTION get_promedio_tareas_por_usuario_FN RETURN NUMBER;

    -- Procedimientos
    PROCEDURE INSERTAR_PERMISO_SP(
        P_PERMISO_ID NUMBER,
        P_NOMBRE_PERMISO VARCHAR2
    );

    PROCEDURE INSERTAR_RECURSO_SP(
        P_ID_RECURSO NUMBER,
        P_NOMBRE_RECURSO VARCHAR2,
        P_DESCRIPCION CLOB,
        P_ID_PROVEEDOR NUMBER
    );

    PROCEDURE INSERTAR_ASIGNACION_RECURSO_SP(
        P_ID_ASIGNACION NUMBER,
        P_ID_TAREA NUMBER,
        P_ID_RECURSO NUMBER
    );

    PROCEDURE INSERTAR_COMENTARIO_SP(
        P_ID_COMENTARIO NUMBER,
        P_CONTENIDO VARCHAR2,
        P_ID_USUARIO NUMBER,
        P_ID_TAREA NUMBER
    );

    PROCEDURE CONSULTAR_COMENTARIOS_USUARIO_SP;

    PROCEDURE INSERTAR_NOTIFICACION_SP(
        P_ID_NOTIFICACION NUMBER,
        P_MENSAJE VARCHAR2,
        P_ID_USUARIO NUMBER,
        P_LEIDO VARCHAR2
    );

    PROCEDURE CONSULTAR_NOTIFICACIONES_SP;

    PROCEDURE INSERTAR_HISTORIAL_SP(
        P_ID_HISTORIAL NUMBER,
        P_DESCRIPCION_CAMBIO CLOB,
        P_ID_USUARIO NUMBER,
        P_ID_TAREA NUMBER
    );

    PROCEDURE CONSULTAR_HISTORIAL_SP;

    PROCEDURE INSERTAR_CATEGORIA_SP(
        P_ID_CATEGORIA NUMBER,
        P_NOMBRE_CATEGORIA VARCHAR2
    );

    PROCEDURE insertar_tiempo_SP(
        p_tiempo_inicio TIMESTAMP,
        p_tiempo_fin TIMESTAMP,
        p_nombre_tarea VARCHAR2
    );

END seguimiento_tareas_empresas;