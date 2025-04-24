CREATE OR REPLACE PROCEDURE insertar_categoria (
    p_nombre_categoria IN VARCHAR2,
    p_id_proyecto IN NUMBER
) AS
BEGIN
    INSERT INTO fide_categorias_tb (nombre_categoria, id_proyecto)
    VALUES (p_nombre_categoria, p_id_proyecto);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Categoría insertada correctamente.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error al insertar la categoría: ' || SQLERRM);
END insertar_categoria;

BEGIN
    -- Insertar categorías para el proyecto "Desarrollo API"
    insertar_categoria('Backend', 1);
    insertar_categoria('Tecnología', 1);
    insertar_categoria('Rest API', 1);

    -- Insertar categorías para el proyecto "Web E-Commerce"
    insertar_categoria('E-commerce', 2);
    insertar_categoria('Frontend', 2);
    insertar_categoria('TIenda en línea', 2);

    -- Insertar categorías para el proyecto "Mantenimiento DB"
    insertar_categoria('Optimización', 3);
    insertar_categoria('Base de datos', 3);
    insertar_categoria('Respaldo', 3);

    -- Insertar categorías para el proyecto "Chatbot Soporte"
    insertar_categoria('Automatización', 4);
END;
select * from categoria_proyecto_crud_V;

create or replace view categoria_proyecto_crud_V as
select
c.id_categoria,
c.nombre_categoria,
p.nombre_proyecto

from fide_categorias_tb c
join fide_proyectos_tb p on c.id_proyecto=p.id_proyecto;

select * from fide_proyectos_tb;
select * from categoria_proyecto_crud_V;
select * from fide_categorias_tb;