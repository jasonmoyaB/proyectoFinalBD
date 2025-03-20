--Procedimiento para inserts en tabla permisos
CREATE OR REPLACE PROCEDURE INSERTAR_PERMISO_SP (
    P_PERMISO_ID NUMBER,
    P_NOMBRE_PERMISO VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_PERMISOS_TB (PERMISO_ID, NOMBRE_PERMISO)
    VALUES (P_PERMISO_ID, P_NOMBRE_PERMISO);

    COMMIT; -- Guardar los cambios
END INSERTAR_PERMISO_SP;
/
--llamado
BEGIN
    INSERTAR_PERMISO_SP(1, 'ADMINISTRAR_USUARIOS');
    INSERTAR_PERMISO_SP(2, 'VER_REPORTES');
    INSERTAR_PERMISO_SP(3, 'EDITAR_PERFILES');
END;
/

---Procedimiento para insercion en tabla de recursos
CREATE OR REPLACE PROCEDURE INSERTAR_RECURSO_SP (
    P_ID_RECURSO NUMBER,
    P_NOMBRE_RECURSO VARCHAR2,
    P_DESCRIPCION CLOB,
    P_ID_PROVEEDOR NUMBER
) AS
BEGIN
    INSERT INTO FIDE_RECURSOS_TB (ID_RECURSO, NOMBRE_RECURSO, DESCRIPCION, ID_PROVEEDOR)
    VALUES (P_ID_RECURSO, P_NOMBRE_RECURSO, P_DESCRIPCION, P_ID_PROVEEDOR);

    COMMIT; -- Guardar los cambios
END INSERTAR_RECURSO_SP;
/
--llamado
BEGIN
    INSERTAR_RECURSO_SP(1, 'Computadora Portátil', 'Computadora portátil para tareas administrativas', 1);
    INSERTAR_RECURSO_SP(2, 'Proyector', 'Proyector para presentaciones en reuniones', 2);
    INSERTAR_RECURSO_SP(3, 'Silla Ergonomica', 'Silla ergonómica para mejorar postura', 3);
    INSERTAR_RECURSO_SP(4, 'Pizarra Blanca', 'Pizarra blanca para reuniones de equipo', 4);
    INSERTAR_RECURSO_SP(5, 'Monitor Curvo', 'Monitor curvo de 27 pulgadas', 5);
    INSERTAR_RECURSO_SP(6, 'Cámara Web', 'Cámara web de alta definición', 6);
    INSERTAR_RECURSO_SP(7, 'Teclado Inalámbrico', 'Teclado inalámbrico para oficina', 7);
    INSERTAR_RECURSO_SP(8, 'Mous Bluetooth', 'Mouse Bluetooth ergonómico', 8);
    INSERTAR_RECURSO_SP(9, 'Impresora Láser', 'Impresora láser color para oficinas', 9);
    INSERTAR_RECURSO_SP(10, 'Altavoces Bluetooth', 'Altavoces inalámbricos para reuniones', 10);
END;
/

---Procedimiento para inserts para tabla asignacion de recursos
CREATE OR REPLACE PROCEDURE INSERTAR_ASIGNACION_RECURSO_SP (
    P_ID_ASIGNACION NUMBER,
    P_ID_TAREA NUMBER,
    P_ID_RECURSO NUMBER
) AS
BEGIN
    INSERT INTO FIDE_ASIGNACION_RECURSOS_TB (ID_ASIGNACION, ID_TAREA, ID_RECURSO)
    VALUES (P_ID_ASIGNACION, P_ID_TAREA, P_ID_RECURSO);

    COMMIT; 
END INSERTAR_ASIGNACION_RECURSO_SP;
/
--llamado
BEGIN
    INSERTAR_ASIGNACION_RECURSO_SP(1, 1, 1); -- Asignar recurso 1 a tarea 1
    INSERTAR_ASIGNACION_RECURSO_SP(2, 1, 2); -- Asignar recurso 2 a tarea 1
    INSERTAR_ASIGNACION_RECURSO_SP(3, 2, 3); -- Asignar recurso 3 a tarea 2
    INSERTAR_ASIGNACION_RECURSO_SP(4, 2, 4); -- Asignar recurso 4 a tarea 2
    INSERTAR_ASIGNACION_RECURSO_SP(5, 3, 5); -- Asignar recurso 5 a tarea 3
    INSERTAR_ASIGNACION_RECURSO_SP(6, 3, 6); -- Asignar recurso 6 a tarea 3
    INSERTAR_ASIGNACION_RECURSO_SP(7, 4, 7); -- Asignar recurso 7 a tarea 4
    INSERTAR_ASIGNACION_RECURSO_SP(8, 4, 8); -- Asignar recurso 8 a tarea 4
    INSERTAR_ASIGNACION_RECURSO_SP(9, 5, 9); -- Asignar recurso 9 a tarea 5
    INSERTAR_ASIGNACION_RECURSO_SP(10, 5, 10); -- Asignar recurso 10 a tarea 5
END;
/

---Procedimiento para inserts para tabla comentarios
CREATE OR REPLACE PROCEDURE INSERTAR_COMENTARIO_SP (
    P_ID_COMENTARIO NUMBER,
    P_CONTENIDO VARCHAR2,
    P_ID_USUARIO NUMBER,
    P_ID_TAREA NUMBER
) AS
BEGIN
    -- Insertar comentario
    INSERT INTO FIDE_COMENTARIOS_TB (ID_COMENTARIO, CONTENIDO, FECHA_COMENTARIO, ID_USUARIO, ID_TAREA)
    VALUES (P_ID_COMENTARIO, P_CONTENIDO, SYSDATE, P_ID_USUARIO, P_ID_TAREA);

    COMMIT;  -- Confirmar los cambios
END INSERTAR_COMENTARIO_SP;

/
--llamado 
BEGIN
    INSERTAR_COMENTARIO_SP(1, 'Comentario sobre la tarea 1', 2, 1);
    INSERTAR_COMENTARIO_SP(2, 'Comentario sobre la tarea 2', 3, 1);
    INSERTAR_COMENTARIO_SP(3, 'Comentario sobre la tarea 3', 4, 2);
    INSERTAR_COMENTARIO_SP(4, 'Comentario sobre la tarea 4', 5, 3);
    INSERTAR_COMENTARIO_SP(5, 'Comentario sobre la tarea 5', 6, 4);
    INSERTAR_COMENTARIO_SP(6, 'Comentario sobre la tarea 6', 7, 5);
    INSERTAR_COMENTARIO_SP(7, 'Comentario sobre la tarea 7', 8, 6);
    INSERTAR_COMENTARIO_SP(8, 'Comentario sobre la tarea 8', 9, 7);
    INSERTAR_COMENTARIO_SP(9, 'Comentario sobre la tarea 9', 10, 8);
    INSERTAR_COMENTARIO_SP(10, 'Comentario sobre la tarea 10', 1, 9);
END;
/

--Vista para consultar comentarios
CREATE OR REPLACE VIEW FIDE_COMENTARIOS_USUARIO_V AS
SELECT 
    fc.contenido AS comentario_contenido,
    fu.nombre AS usuario_nombre
FROM 
    fide_comentarios_tb fc
JOIN 
    fide_usuarios_tb fu ON fc.id_usuario = fu.id_usuario;
/
--consulta de la vista mediante un cursor explicito
CREATE OR REPLACE PROCEDURE CONSULTAR_COMENTARIOS_USUARIO_SP AS
    CURSOR c_comentarios IS
        SELECT comentario_contenido, usuario_nombre
        FROM FIDE_COMENTARIOS_USUARIO_V;
    
    v_comentario_contenido VARCHAR2(100);
    v_usuario_nombre VARCHAR2(100);
BEGIN
    OPEN c_comentarios;
    
    LOOP
        FETCH c_comentarios INTO v_comentario_contenido, v_usuario_nombre;
        
        EXIT WHEN c_comentarios%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Comentario: ' || v_comentario_contenido || ' - Usuario: ' || v_usuario_nombre);
    END LOOP;
    
    CLOSE c_comentarios;
END CONSULTAR_COMENTARIOS_USUARIO_SP;
/
EXEC CONSULTAR_COMENTARIOS_USUARIO_SP;
/

---Procedimiento para inserts para tabla notificaciones
CREATE OR REPLACE PROCEDURE INSERTAR_NOTIFICACION_SP (
    P_ID_NOTIFICACION NUMBER,
    P_MENSAJE VARCHAR2,
    P_ID_USUARIO NUMBER,
    P_LEIDO VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_NOTIFICACIONES_TB (ID_NOTIFICACION, MENSAJE, FECHA_NOTIFICACION, ID_USUARIO, LEIDO)
    VALUES (P_ID_NOTIFICACION, P_MENSAJE, SYSDATE, P_ID_USUARIO, P_LEIDO);

    COMMIT;  
END INSERTAR_NOTIFICACION_SP;
/
--llamado
BEGIN
    INSERTAR_NOTIFICACION_SP(1, 'Nueva tarea asignada', 2, 'N');
    INSERTAR_NOTIFICACION_SP(2, 'Revisión de proyecto', 3, 'N');
    INSERTAR_NOTIFICACION_SP(3, 'Tarea completada', 4, 'S');
    INSERTAR_NOTIFICACION_SP(4, 'Actualización en el sistema', 5, 'N');
    INSERTAR_NOTIFICACION_SP(5, 'Nuevo comentario en tu tarea', 6, 'S');
    INSERTAR_NOTIFICACION_SP(6, 'Revisión pendiente', 7, 'N');
    INSERTAR_NOTIFICACION_SP(7, 'Plazo de entrega cercano', 8, 'S');
    INSERTAR_NOTIFICACION_SP(8, 'Nuevo mensaje del equipo', 9, 'N');
    INSERTAR_NOTIFICACION_SP(9, 'Reunión programada', 10, 'S');
    INSERTAR_NOTIFICACION_SP(10, 'Tarea reasignada', 1, 'N');
END;
/

--vista que consulta los registros de notificaciones
CREATE OR REPLACE VIEW FIDE_NOTIFICACIONES_V AS
SELECT 
    N.MENSAJE, 
    N.FECHA_NOTIFICACION, 
    U.NOMBRE_USUARIO, 
    N.LEIDO
FROM 
    FIDE_NOTIFICACIONES_TB N
JOIN 
    FIDE_USUARIOS_TB U ON N.ID_USUARIO = U.ID_USUARIO;
/
--Consulta de esa vista por medio de un cursor explicito
CREATE OR REPLACE PROCEDURE CONSULTAR_NOTIFICACIONES_SP AS
    CURSOR C_NOTIFICACIONES IS 
        SELECT MENSAJE, FECHA_NOTIFICACION, NOMBRE_USUARIO, LEIDO 
        FROM FIDE_NOTIFICACIONES_V;

    V_MENSAJE FIDE_NOTIFICACIONES_TB.MENSAJE%TYPE;
    V_FECHA_NOTIFICACION FIDE_NOTIFICACIONES_TB.FECHA_NOTIFICACION%TYPE;
    V_NOMBRE_USUARIO FIDE_USUARIOS_TB.NOMBRE_USUARIO%TYPE;
    V_LEIDO FIDE_NOTIFICACIONES_TB.LEIDO%TYPE;

BEGIN
    OPEN C_NOTIFICACIONES;

    LOOP
        FETCH C_NOTIFICACIONES INTO V_MENSAJE, V_FECHA_NOTIFICACION, V_NOMBRE_USUARIO, V_LEIDO;
        
        EXIT WHEN C_NOTIFICACIONES%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Usuario: ' || V_NOMBRE_USUARIO || 
                             ', Mensaje: ' || V_MENSAJE || 
                             ', Fecha: ' || V_FECHA_NOTIFICACION || 
                             ', Leído: ' || V_LEIDO);
    END LOOP;

    CLOSE C_NOTIFICACIONES;
END CONSULTAR_NOTIFICACIONES_SP;
/

--Procedimiento que inserta registros en la tabla historial
CREATE OR REPLACE PROCEDURE INSERTAR_HISTORIAL_SP (
    P_ID_HISTORIAL NUMBER,
    P_DESCRIPCION_CAMBIO CLOB,
    P_ID_USUARIO NUMBER,
    P_ID_TAREA NUMBER
) AS
BEGIN
    INSERT INTO FIDE_HISTORIAL_TB (ID_HISTORIAL, DESCRIPCION_CAMBIO, FECHA_CAMBIO, ID_USUARIO, ID_TAREA)
    VALUES (P_ID_HISTORIAL, P_DESCRIPCION_CAMBIO, SYSDATE, P_ID_USUARIO, P_ID_TAREA);

    COMMIT;
END INSERTAR_HISTORIAL_SP;
/
--llamado
BEGIN
    INSERTAR_HISTORIAL_SP(1, 'Cambio en la tarea 1', 1, 1);
    INSERTAR_HISTORIAL_SP(2, 'Modificación en la tarea 2', 2, 2);
    INSERTAR_HISTORIAL_SP(3, 'Ajuste de fechas en la tarea 3', 3, 3);
    INSERTAR_HISTORIAL_SP(4, 'Corrección de errores en la tarea 4', 4, 4);
    INSERTAR_HISTORIAL_SP(5, 'Cambio de responsable en la tarea 5', 5, 5);
    INSERTAR_HISTORIAL_SP(6, 'Revisión de requerimientos en la tarea 6', 6, 6);
    INSERTAR_HISTORIAL_SP(7, 'Actualización de estado en la tarea 7', 7, 7);
    INSERTAR_HISTORIAL_SP(8, 'Se agregó una nueva fase a la tarea 8', 8, 8);
    INSERTAR_HISTORIAL_SP(9, 'Cambio de prioridad en la tarea 9', 9, 9);
    INSERTAR_HISTORIAL_SP(10, 'Optimización de la tarea 10', 10, 10);
END;
/
--vista que muestra los registros de la tabla historial
CREATE OR REPLACE VIEW FIDE_HISTORIAL_V AS
SELECT 
    H.DESCRIPCION_CAMBIO, 
    H.FECHA_CAMBIO, 
    U.NOMBRE_USUARIO, 
    H.ID_TAREA
FROM FIDE_HISTORIAL_TB H
JOIN FIDE_USUARIOS_TB U ON H.ID_USUARIO = U.ID_USUARIO;

/
-- Consulta de esa vista por medio de un cursor explicito
CREATE OR REPLACE PROCEDURE CONSULTAR_HISTORIAL_SP IS
    CURSOR C_HISTORIAL IS 
        SELECT DESCRIPCION_CAMBIO, FECHA_CAMBIO, NOMBRE_USUARIO, ID_TAREA 
        FROM FIDE_HISTORIAL_V;

    V_DESCRIPCION FIDE_HISTORIAL_V.DESCRIPCION_CAMBIO%TYPE;
    V_FECHA FIDE_HISTORIAL_V.FECHA_CAMBIO%TYPE;
    V_USUARIO FIDE_HISTORIAL_V.NOMBRE_USUARIO%TYPE;
    V_TAREA FIDE_HISTORIAL_V.ID_TAREA%TYPE;

BEGIN
    OPEN C_HISTORIAL;
    LOOP
        FETCH C_HISTORIAL INTO V_DESCRIPCION, V_FECHA, V_USUARIO, V_TAREA;
        EXIT WHEN C_HISTORIAL%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Cambio: ' || V_DESCRIPCION || 
                             ' | Fecha: ' || TO_CHAR(V_FECHA, 'YYYY-MM-DD HH24:MI:SS') || 
                             ' | Usuario: ' || V_USUARIO || 
                             ' | ID Tarea: ' || V_TAREA);
    END LOOP;
    CLOSE C_HISTORIAL;
END CONSULTAR_HISTORIAL_SP;
/

CREATE OR REPLACE PROCEDURE INSERTAR_CATEGORIA_SP (
    P_ID_CATEGORIA NUMBER,
    P_NOMBRE_CATEGORIA VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_CATEGORIAS_TB (ID_CATEGORIA, NOMBRE_CATEGORIA)
    VALUES (P_ID_CATEGORIA, P_NOMBRE_CATEGORIA);

    COMMIT;  
END INSERTAR_CATEGORIA_SP;
/
BEGIN
    INSERTAR_CATEGORIA_SP(1, 'Desarrollo');
    INSERTAR_CATEGORIA_SP(2, 'Diseño');
    INSERTAR_CATEGORIA_SP(3, 'Marketing');
    INSERTAR_CATEGORIA_SP(4, 'Finanzas');
    INSERTAR_CATEGORIA_SP(5, 'Recursos Humanos');
    INSERTAR_CATEGORIA_SP(6, 'Legal');
    INSERTAR_CATEGORIA_SP(7, 'Ventas');
    INSERTAR_CATEGORIA_SP(8, 'Soporte Técnico');
    INSERTAR_CATEGORIA_SP(9, 'Investigación y Desarrollo');
    INSERTAR_CATEGORIA_SP(10, 'Producción');
END;
/
--cursor explicito que muestra las categorias 
DECLARE
    CURSOR c_categorias IS
        SELECT NOMBRE_CATEGORIA
        FROM FIDE_CATEGORIAS_TB;
    
    -- Variable para almacenar el nombre de la categoría
    v_nombre_categoria VARCHAR2(100);
BEGIN
    OPEN c_categorias;
    
    LOOP
        FETCH c_categorias INTO v_nombre_categoria;
        
        EXIT WHEN c_categorias%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Categoría: ' || v_nombre_categoria);
    END LOOP;
    
    CLOSE c_categorias;
END;
/
CREATE OR REPLACE PROCEDURE insertar_tiempo_SP(
    p_tiempo_inicio TIMESTAMP,
    p_tiempo_fin TIMESTAMP,
    p_nombre_tarea VARCHAR2
) IS
    v_tarea_id NUMBER;
BEGIN
    -- Obtener el ID de la tarea basado en su nombre
    SELECT tarea_id INTO v_tarea_id FROM fide_tareas_tb WHERE nombre_tarea = p_nombre_tarea;
    
    -- Insertar el registro en fide_tiempo_tb sin usar la secuencia para el tiempo_id
    INSERT INTO fide_tiempo_tb (tiempo_inicio, tiempo_fin, tarea_id)
    VALUES (p_tiempo_inicio, p_tiempo_fin, v_tarea_id);
    
    COMMIT;
END;

/
--llamado 

BEGIN
    insertar_tiempo_SP(TO_TIMESTAMP('2025-03-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       TO_TIMESTAMP('2025-03-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       'Diseñar UI');

    insertar_tiempo_SP(TO_TIMESTAMP('2025-03-20 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       TO_TIMESTAMP('2025-03-20 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       'Configurar Base de Datos');

    insertar_tiempo_SP(TO_TIMESTAMP('2025-03-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       TO_TIMESTAMP('2025-03-20 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       'Implementar Backend');

END;










