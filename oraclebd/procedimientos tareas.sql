ALTER TABLE FIDE_TAREAS_TB ADD TIEMPO_DEDICADO NUMBER NULL;

CREATE OR REPLACE PROCEDURE insertar_tarea (
    p_nombre        IN VARCHAR2,
    p_descripcion   IN CLOB,
    p_estado        IN VARCHAR2,
    p_fecha_limite  IN DATE,
    p_proyecto_id   IN NUMBER,
    p_usuario_id    IN NUMBER,
    p_tiempo_ms     IN NUMBER
) IS
BEGIN
    INSERT INTO fide_tareas_tb (
        nombre_tarea, descripcion, estado, fecha_limite,
        proyecto_id, usuario_id, tiempo_dedicado,
        created_by, creation_date, last_update_by, last_update_date, accion
    )
    VALUES (
        p_nombre, p_descripcion, p_estado, p_fecha_limite,
        p_proyecto_id, p_usuario_id, p_tiempo_ms,
        USER, SYSDATE, USER, SYSDATE, 'INSERT'
    );
END;

CREATE OR REPLACE PROCEDURE actualizar_tarea(
    p_tarea_id     IN NUMBER,
    p_nombre       IN VARCHAR2,
    p_descripcion  IN CLOB,
    p_estado       IN VARCHAR2,
    p_fecha_limite IN DATE
) IS
BEGIN
    UPDATE fide_tareas_tb
    SET nombre_tarea = p_nombre,
        descripcion = p_descripcion,
        estado = p_estado,
        fecha_limite = p_fecha_limite,
        last_update_by = USER,
        last_update_date = SYSDATE,
        accion = 'UPDATE'
    WHERE tarea_id = p_tarea_id;
END;

CREATE OR REPLACE PROCEDURE eliminar_tarea(
    p_tarea_id IN NUMBER
) IS
BEGIN
    DELETE FROM fide_tareas_tb
    WHERE tarea_id = p_tarea_id;
END;

ALTER TABLE FIDE_TAREAS_TB ADD TIEMPO_DEDICADO NUMBER NULL;


