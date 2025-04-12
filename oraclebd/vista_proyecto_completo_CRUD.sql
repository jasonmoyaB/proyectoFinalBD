-- Crear vista para mostrar informaci�n completa de proyectos para operaciones CRUD
CREATE OR REPLACE VIEW proyecto_completo_CRUD AS
SELECT 
    p.id AS id_proyecto,
    p.nombre AS nombre_proyecto,
    p.descripcion AS descripcion_proyecto,
    p.fechaInicio AS fechaInicio_p,
    p.fechaFin AS fechaFin_p,
    p.estado AS estado_p,
    p.fechaCreacion AS fechaCreacion_p,
    -- Incluir informaci�n adicional si es necesario, como el n�mero de clientes por proyecto
    (SELECT COUNT(*) FROM Cliente c WHERE c.nombre_proyecto = p.nombre) AS total_clientes
FROM 
    Proyecto p
ORDER BY 
    p.fechaCreacion DESC;

-- A�adir comentario a la vista
COMMENT ON TABLE proyecto_completo_CRUD IS 'Vista que muestra informaci�n completa de proyectos para operaciones CRUD';