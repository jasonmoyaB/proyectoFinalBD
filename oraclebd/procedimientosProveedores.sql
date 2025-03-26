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