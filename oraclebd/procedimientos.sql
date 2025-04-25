CREATE OR REPLACE PROCEDURE INSERTAR_PERMISO_SP (
    P_ID_PERMISO NUMBER,
    P_NOMBRE_PERMISO VARCHAR2
) AS
BEGIN
    INSERT INTO FIDE_PERMISOS_TB (ID_PERMISO, NOMBRE_PERMISO)
    VALUES (P_ID_PERMISO, P_NOMBRE_PERMISO);

    COMMIT; -- Guardar los cambios
END;

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
    INSERTAR_RECURSO_SP(1, 'Computadora Port�til', 'Computadora port�til para tareas administrativas', 1);
    INSERTAR_RECURSO_SP(2, 'Proyector', 'Proyector para presentaciones en reuniones', 2);
    INSERTAR_RECURSO_SP(3, 'Silla Ergonomica', 'Silla ergon�mica para mejorar postura', 3);
    INSERTAR_RECURSO_SP(4, 'Pizarra Blanca', 'Pizarra blanca para reuniones de equipo', 4);
    INSERTAR_RECURSO_SP(5, 'Monitor Curvo', 'Monitor curvo de 27 pulgadas', 5);
    INSERTAR_RECURSO_SP(6, 'C�mara Web', 'C�mara web de alta definici�n', 6);
    INSERTAR_RECURSO_SP(7, 'Teclado Inal�mbrico', 'Teclado inal�mbrico para oficina', 7);
    INSERTAR_RECURSO_SP(8, 'Mous Bluetooth', 'Mouse Bluetooth ergon�mico', 8);
    INSERTAR_RECURSO_SP(9, 'Impresora L�ser', 'Impresora l�ser color para oficinas', 9);
    INSERTAR_RECURSO_SP(10, 'Altavoces Bluetooth', 'Altavoces inal�mbricos para reuniones', 10);
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
CREATE OR REPLACE PROCEDURE actualizar_proveedor(
    p_id_proveedor IN NUMBER,
    p_nombre_proveedor IN VARCHAR2,
    p_contacto IN VARCHAR2,
    p_telefono IN VARCHAR2
) AS
BEGIN
    UPDATE fide_proveedores_tb
    SET nombre_proveedor = p_nombre_proveedor,
        contacto = p_contacto,
        telefono = p_telefono
    WHERE id_proveedor = p_id_proveedor;
    
END actualizar_proveedor;

CREATE OR REPLACE PROCEDURE eliminar_proveedor(
    p_id_proveedor IN NUMBER
) AS
BEGIN
    DELETE FROM fide_proveedores_tb WHERE id_proveedor = p_id_proveedor;
    COMMIT;
END eliminar_proveedor;
---Procedimiento para inserts para tabla comentarios
CREATE OR REPLACE PROCEDURE INSERTAR_COMENTARIO_SP (
    
    P_CONTENIDO VARCHAR2,
    P_ID_USUARIO NUMBER,
    P_ID_TAREA NUMBER
) AS
BEGIN
    -- Insertar comentario
    INSERT INTO FIDE_COMENTARIOS_TB (CONTENIDO, FECHA_COMENTARIO, ID_USUARIO, ID_TAREA)
    VALUES (P_CONTENIDO, SYSDATE, P_ID_USUARIO, P_ID_TAREA);

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
    INSERTAR_NOTIFICACION_SP(2, 'Revisi�n de proyecto', 3, 'N');
    INSERTAR_NOTIFICACION_SP(3, 'Tarea completada', 4, 'S');
    INSERTAR_NOTIFICACION_SP(4, 'Actualizaci�n en el sistema', 5, 'N');
    INSERTAR_NOTIFICACION_SP(5, 'Nuevo comentario en tu tarea', 6, 'S');
    INSERTAR_NOTIFICACION_SP(6, 'Revisi�n pendiente', 7, 'N');
    INSERTAR_NOTIFICACION_SP(7, 'Plazo de entrega cercano', 8, 'S');
    INSERTAR_NOTIFICACION_SP(8, 'Nuevo mensaje del equipo', 9, 'N');
    INSERTAR_NOTIFICACION_SP(9, 'Reuni�n programada', 10, 'S');
    INSERTAR_NOTIFICACION_SP(10, 'Tarea reasignada', 1, 'N');
END;
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
    INSERTAR_HISTORIAL_SP(2, 'Modificaci�n en la tarea 2', 2, 2);
    INSERTAR_HISTORIAL_SP(3, 'Ajuste de fechas en la tarea 3', 3, 3);
    INSERTAR_HISTORIAL_SP(4, 'Correcci�n de errores en la tarea 4', 4, 4);
    INSERTAR_HISTORIAL_SP(5, 'Cambio de responsable en la tarea 5', 5, 5);
    INSERTAR_HISTORIAL_SP(6, 'Revisi�n de requerimientos en la tarea 6', 6, 6);
    INSERTAR_HISTORIAL_SP(7, 'Actualizaci�n de estado en la tarea 7', 7, 7);
    INSERTAR_HISTORIAL_SP(8, 'Se agreg� una nueva fase a la tarea 8', 8, 8);
    INSERTAR_HISTORIAL_SP(9, 'Cambio de prioridad en la tarea 9', 9, 9);
    INSERTAR_HISTORIAL_SP(10, 'Optimizaci�n de la tarea 10', 10, 10);
END;
/


-- Consulta de esa vista por medio de un cursor explicito
CREATE OR REPLACE PROCEDURE CONSULTAR_HISTORIAL_SP IS
    CURSOR C_HISTORIAL IS 
        SELECT DESCRIPCION_CAMBIO, FECHA_CAMBIO, NOMBRE, ID_TAREA -- Ajusta NOMBRE_USUARIO a NOMBRE o el nombre correcto
        FROM FIDE_HISTORIAL_V;

    V_DESCRIPCION FIDE_HISTORIAL_V.DESCRIPCION_CAMBIO%TYPE;
    V_FECHA FIDE_HISTORIAL_V.FECHA_CAMBIO%TYPE;
    V_USUARIO FIDE_HISTORIAL_V.NOMBRE%TYPE;  -- Asegúrate de que esta columna exista
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
    INSERTAR_CATEGORIA_SP(2, 'Dise�o');
    INSERTAR_CATEGORIA_SP(3, 'Marketing');
    INSERTAR_CATEGORIA_SP(4, 'Finanzas');
    INSERTAR_CATEGORIA_SP(5, 'Recursos Humanos');
    INSERTAR_CATEGORIA_SP(6, 'Legal');
    INSERTAR_CATEGORIA_SP(7, 'Ventas');
    INSERTAR_CATEGORIA_SP(8, 'Soporte T�cnico');
    INSERTAR_CATEGORIA_SP(9, 'Investigaci�n y Desarrollo');
    INSERTAR_CATEGORIA_SP(10, 'Producci�n');
END;
/
--cursor explicito que muestra las categorias 
DECLARE
    CURSOR c_categorias IS
        SELECT NOMBRE_CATEGORIA
        FROM FIDE_CATEGORIAS_TB;
    
    -- Variable para almacenar el nombre de la categor�a
    v_nombre_categoria VARCHAR2(100);
BEGIN
    OPEN c_categorias;
    
    LOOP
        FETCH c_categorias INTO v_nombre_categoria;
        
        EXIT WHEN c_categorias%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Categor�a: ' || v_nombre_categoria);
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
    SELECT id_tarea INTO v_tarea_id FROM fide_tareas_tb WHERE nombre_tarea = p_nombre_tarea;
    
    -- Insertar el registro en fide_tiempo_tb sin usar la secuencia para el tiempo_id
    INSERT INTO fide_tiempo_tb (tiempo_inicio, tiempo_fin, id_tarea)
    VALUES (p_tiempo_inicio, p_tiempo_fin, v_tarea_id);
    
    COMMIT;
END;

/
--llamado 

BEGIN
    insertar_tiempo_SP(TO_TIMESTAMP('2025-03-20 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       TO_TIMESTAMP('2025-03-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       'Dise�ar UI');

    insertar_tiempo_SP(TO_TIMESTAMP('2025-03-20 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       TO_TIMESTAMP('2025-03-20 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       'Configurar Base de Datos');

    insertar_tiempo_SP(TO_TIMESTAMP('2025-03-20 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       TO_TIMESTAMP('2025-03-20 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 
                       'Implementar Backend');

END;





CREATE OR REPLACE PROCEDURE ACTUALIZAR_NOTIFICACION_SP (
    P_ID_NOTIFICACION NUMBER,
    P_LEIDO VARCHAR2
) AS
BEGIN
    UPDATE FIDE_NOTIFICACIONES_TB
    SET LEIDO = P_LEIDO
    WHERE ID_NOTIFICACION = P_ID_NOTIFICACION;
    
    COMMIT;
END ACTUALIZAR_NOTIFICACION_SP;

CREATE OR REPLACE PROCEDURE CONSULTAR_COMENTARIOS_USUARIO_SP (
    P_ID_USUARIO NUMBER
) AS
    CURSOR C_COMENTARIOS IS
        SELECT CONTENIDO, FECHA_COMENTARIO
        FROM FIDE_COMENTARIOS_TB
        WHERE ID_USUARIO = P_ID_USUARIO;
        
    V_CONTENIDO FIDE_COMENTARIOS_TB.CONTENIDO%TYPE;
    V_FECHA_COMENTARIO FIDE_COMENTARIOS_TB.FECHA_COMENTARIO%TYPE;
BEGIN
    OPEN C_COMENTARIOS;
    LOOP
        FETCH C_COMENTARIOS INTO V_CONTENIDO, V_FECHA_COMENTARIO;
        EXIT WHEN C_COMENTARIOS%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Comentario: ' || V_CONTENIDO || 
                             ' | Fecha: ' || TO_CHAR(V_FECHA_COMENTARIO, 'YYYY-MM-DD HH24:MI:SS'));
    END LOOP;
    CLOSE C_COMENTARIOS;
END CONSULTAR_COMENTARIOS_USUARIO_SP;

create or replace PROCEDURE actualizar_usuario(
    p_id_usuario IN NUMBER,
    p_nombre IN VARCHAR2,
    p_correo IN VARCHAR2,
    p_contraseña IN VARCHAR2,
    p_id_rol IN NUMBER,
    p_id_departamento IN NUMBER
) AS
BEGIN
    UPDATE fide_usuarios_tb
    SET nombre = p_nombre,
        correo = p_correo,
        contraseña = p_contraseña,
        id_rol = p_id_rol,
        id_departamento = p_id_departamento
    WHERE id_usuario = p_id_usuario;
    COMMIT;
END actualizar_usuario;

-- PROCEDIMIENTO PARA ELIMINAR USUARIO
create or replace PROCEDURE eliminar_usuario(
    p_id_usuario IN NUMBER
) AS
BEGIN
    DELETE FROM fide_usuarios_tb WHERE id_usuario = p_id_usuario;
    COMMIT;
END eliminar_usuario;

-- PROCEDIMIENTO PARA CONSULTAR USUARIO
create or replace PROCEDURE consultar_usuario(
    p_id_usuario IN NUMBER
) AS
    v_nombre fide_usuarios_tb.nombre%TYPE;
    v_correo fide_usuarios_tb.correo%TYPE;
    v_contraseña fide_usuarios_tb.contraseña%TYPE;
    v_id_rol fide_usuarios_tb.id_rol%TYPE;
    v_id_departamento fide_usuarios_tb.id_departamento%TYPE;
BEGIN
    SELECT nombre, correo, contraseña, id_rol, id_departamento
    INTO v_nombre, v_correo, v_contraseña, v_id_rol, v_id_departamento
    FROM fide_usuarios_tb
    WHERE id_usuario = p_id_usuario;

    DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre);
    DBMS_OUTPUT.PUT_LINE('Correo: ' || v_correo);
    DBMS_OUTPUT.PUT_LINE('Contraseña: ' || v_contraseña);
    DBMS_OUTPUT.PUT_LINE('ID Rol: ' || v_id_rol);
    DBMS_OUTPUT.PUT_LINE('ID Departamento: ' || v_id_departamento);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el usuario con el ID proporcionado.');
END consultar_usuario;

-- PROCEDIMIENTO PARA CONSULTAR TODOS LOS USUARIOS
create or replace PROCEDURE consultar_todos_usuarios AS
    CURSOR c_usuarios IS
        SELECT id_usuario, nombre, correo, id_rol, id_departamento
        FROM fide_usuarios_tb;
    v_usuario c_usuarios%ROWTYPE;
BEGIN
    OPEN c_usuarios;
    LOOP
        FETCH c_usuarios INTO v_usuario;
        EXIT WHEN c_usuarios%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID Usuario: ' || v_usuario.id_usuario || ', Nombre: ' || v_usuario.nombre ||
                             ', Correo: ' || v_usuario.correo || ', ID Rol: ' || v_usuario.id_rol ||
                             ', ID Departamento: ' || v_usuario.id_departamento);
    END LOOP;
    CLOSE c_usuarios;
END consultar_todos_usuarios;

-- PROCEDIMIENTO PARA ACTUALIZAR CLIENTE
create or replace PROCEDURE actualizar_cliente(
    p_id_cliente IN NUMBER,
    p_nombre_cliente IN VARCHAR2,
    p_correo_cliente IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_id_proyecto IN NUMBER
) AS
BEGIN
    UPDATE fide_clientes_tb
    SET nombre_cliente = p_nombre_cliente,
        correo_cliente = p_correo_cliente,
        telefono = p_telefono,
        id_proyecto = p_id_proyecto
    WHERE id_cliente = p_id_cliente;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cliente actualizado correctamente.');
END actualizar_cliente;

-- PROCEDIMIENTO PARA ELIMINAR CLIENTE
create or replace PROCEDURE eliminar_cliente(
    p_id_cliente IN NUMBER
) AS
BEGIN
    DELETE FROM fide_clientes_tb WHERE id_cliente = p_id_cliente;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cliente eliminado correctamente.');
END eliminar_cliente;

-- PROCEDIMIENTO PARA CONSULTAR CLIENTE
create or replace PROCEDURE consultar_cliente(
    p_id_cliente IN NUMBER
) AS
    v_nombre_cliente fide_clientes_tb.nombre_cliente%TYPE;
    v_correo_cliente fide_clientes_tb.correo_cliente%TYPE;
    v_telefono fide_clientes_tb.telefono%TYPE;
    v_id_proyecto fide_clientes_tb.id_proyecto%TYPE;
BEGIN
    SELECT nombre_cliente, correo_cliente, telefono, id_proyecto
    INTO v_nombre_cliente, v_correo_cliente, v_telefono, v_id_proyecto
    FROM fide_clientes_tb
    WHERE id_cliente = p_id_cliente;

    DBMS_OUTPUT.PUT_LINE('Nombre Cliente: ' || v_nombre_cliente);
    DBMS_OUTPUT.PUT_LINE('Correo Cliente: ' || v_correo_cliente);
    DBMS_OUTPUT.PUT_LINE('Teléfono: ' || v_telefono);
    DBMS_OUTPUT.PUT_LINE('ID Proyecto: ' || v_id_proyecto);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No se encontró el cliente con el ID proporcionado.');
END consultar_cliente;

create or replace PROCEDURE insertar_usuarios (
    p_nombre IN VARCHAR2,
    p_correo IN VARCHAR2,
    p_contraseña IN VARCHAR2,
    p_id_rol IN NUMBER,
    p_id_departamento IN NUMBER
) AS
BEGIN
    INSERT INTO fide_usuarios_tb (nombre, correo, contraseña, id_rol, id_departamento)
    VALUES (p_nombre, p_correo, p_contraseña, p_id_rol, p_id_departamento);
    COMMIT;
END insertar_usuarios;

create or replace PROCEDURE insertar_clientes (
    p_nombre_cliente IN VARCHAR2,
    p_correo_cliente IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_id_proyecto IN NUMBER
) AS
BEGIN
    INSERT INTO fide_clientes_tb (nombre_cliente, correo_cliente, telefono, id_proyecto)
    VALUES (p_nombre_cliente, p_correo_cliente, p_telefono, p_id_proyecto);
    COMMIT;
END insertar_clientes;

create or replace PROCEDURE insertar_proveedores (
    p_nombre_proveedor IN VARCHAR2,
    p_contacto IN VARCHAR2,
    p_telefono IN VARCHAR2
) AS
BEGIN
    INSERT INTO fide_proveedores_tb (nombre_proveedor, contacto, telefono)
    VALUES (p_nombre_proveedor, p_contacto, p_telefono);
    COMMIT;
END insertar_proveedores;
CREATE OR REPLACE PROCEDURE actualizar_categoria(
    p_id_categoria IN NUMBER,
    p_nombre_categoria IN VARCHAR2,
    p_id_proyecto IN NUMBER
) AS
BEGIN
    UPDATE fide_categorias_tb
    SET 
        nombre_categoria = p_nombre_categoria,
        id_proyecto = p_id_proyecto
    WHERE id_categoria = p_id_categoria;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Categoría actualizada correctamente.');
END actualizar_categoria;
CREATE OR REPLACE PROCEDURE eliminar_categoria(
    p_id_categoria IN NUMBER
) AS
BEGIN
    DELETE FROM fide_categorias_tb WHERE id_categoria = p_id_categoria;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Categoría eliminada correctamente.');
END eliminar_categoria;

CREATE OR REPLACE PROCEDURE insertar_tarea (
    p_nombre_tarea IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_estado IN VARCHAR2,
    p_fecha_limite IN DATE

) AS
BEGIN
    INSERT INTO fide_tareas_tb (nombre_tarea, descripcion, estado, fecha_limite)
    VALUES (p_nombre_tarea, p_descripcion, p_estado, p_fecha_limite);
    COMMIT;
END insertar_tarea;

CREATE OR REPLACE PROCEDURE eliminar_tarea (
    p_id_tarea IN NUMBER
) AS
BEGIN
    DELETE FROM fide_tareas_tb WHERE id_tarea = p_id_tarea;
    COMMIT;
END eliminar_tarea;
CREATE OR REPLACE PROCEDURE actualizar_tarea (
    p_id_tarea IN NUMBER,
    p_nombre_tarea IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_estado IN VARCHAR2,
    p_fecha_limite IN DATE
) AS
BEGIN
    UPDATE fide_tareas_tb
    SET nombre_tarea = p_nombre_tarea,
        descripcion = p_descripcion,
        estado = p_estado,
        fecha_limite = p_fecha_limite
    WHERE id_tarea = p_id_tarea;
    COMMIT;
END actualizar_tarea;
