--EJECUCION CRUDS
--====================================================================
EXEC proyectoMain_pck.obtener_todos_usuarios;
EXEC proyectoMain_pck.obtener_todos_clientes;
EXEC proyectoMain_pck.obtener_todos_proveedores;
EXEC proyectoMain_pck.obtener_comentarios;
EXEC proyectoMain_pck.obtener_todas_las_categorias;
























CREATE OR REPLACE PROCEDURE obtener_todos_usuarios 
IS
BEGIN
    FOR r IN (SELECT * FROM fide_usuarios_tb) LOOP
        
        DBMS_OUTPUT.PUT_LINE('ID Usuario: ' || r.id_usuario || ' | Nombre: ' || r.nombre || ' | Correo: ' || r.correo);
    END LOOP;
END obtener_todos_usuarios;


CREATE OR REPLACE PROCEDURE obtener_todos_clientes 
IS
BEGIN
    FOR r IN (SELECT * FROM cliente_completo_CRUD) LOOP
        
        DBMS_OUTPUT.PUT_LINE('ID Cliente: ' || r.id_cliente || ' | Nombre: ' || r.nombre_cliente || ' | Correo: ' || r.correo_cliente);
    END LOOP;
END obtener_todos_clientes;

CREATE OR REPLACE PROCEDURE obtener_todos_proveedores 
IS
BEGIN
    FOR r IN (SELECT * FROM fide_proveedores_tb) LOOP
        
        DBMS_OUTPUT.PUT_LINE('ID Proveedor: ' || r.id_proveedor || ' | Nombre: ' || r.nombre_proveedor || ' | Contacto: ' || r.contacto);
    END LOOP;
END obtener_todos_proveedores;
CREATE OR REPLACE PROCEDURE obtener_comentarios IS
    CURSOR c_comentarios IS
        SELECT ID_COMENTARIO, CONTENIDO, FECHA_COMENTARIO
        FROM fide_comentarios_tb;
BEGIN
    FOR comentario IN c_comentarios LOOP
        DBMS_OUTPUT.PUT_LINE('ID Comentario: ' || comentario.ID_COMENTARIO || ' | Contenido: ' || comentario.CONTENIDO || ' | Fecha: ' || comentario.FECHA_COMENTARIO);
    END LOOP;
END obtener_comentarios;
CREATE OR REPLACE PROCEDURE obtener_todas_las_categorias 
IS
BEGIN
    FOR r IN (SELECT * FROM categoria_proyecto_crud_V) LOOP
        -- Aquí puedes manejar la salida, por ejemplo, mostrando el resultado
        DBMS_OUTPUT.PUT_LINE('ID Categoría: ' || r.id_categoria || ' | Nombre Categoría: ' || r.nombre_categoria || ' | Proyecto: ' || r.nombre_proyecto);
    END LOOP;
END obtener_todas_las_categorias;


