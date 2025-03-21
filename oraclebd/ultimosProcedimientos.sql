desc fide_usuarios_tb;


CREATE OR REPLACE PROCEDURE actualizar_usuario(
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

CREATE OR REPLACE PROCEDURE eliminar_usuario(
    p_id_usuario IN NUMBER
) AS
BEGIN
    DELETE FROM fide_usuarios_tb WHERE id_usuario = p_id_usuario;
    COMMIT;
END eliminar_usuario;



CREATE OR REPLACE PROCEDURE consultar_usuario(
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



--CONSULTAR AL USER

CREATE OR REPLACE PROCEDURE consultar_todos_usuarios AS
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



CREATE OR REPLACE PROCEDURE actualizar_cliente(
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


CREATE OR REPLACE PROCEDURE eliminar_cliente(
    p_id_cliente IN NUMBER
) AS
BEGIN
    DELETE FROM fide_clientes_tb WHERE id_cliente = p_id_cliente;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Cliente eliminado correctamente.');
END eliminar_cliente;



CREATE OR REPLACE PROCEDURE consultar_cliente(
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