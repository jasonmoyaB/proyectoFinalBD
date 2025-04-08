CREATE OR REPLACE PROCEDURE BuscarUsuarios(
    p_search IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_cursor FOR
    SELECT * 
    FROM usuario_completo_CRUD_V 
    WHERE nombre LIKE '%' || p_search || '%'
    OR correo LIKE '%' || p_search || '%';
END BuscarUsuarios;

