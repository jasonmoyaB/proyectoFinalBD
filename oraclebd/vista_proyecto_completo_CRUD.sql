-- Crear vista para mostrar información completa de proyectos para operaciones CRUD
CREATE OR REPLACE VIEW proyecto_completo_CRUD AS
SELECT 
    p.id AS id_proyecto,
    p.nombre AS nombre_proyecto,
    p.descripcion AS descripcion_proyecto,
    p.fechaInicio AS fechaInicio_p,
    p.fechaFin AS fechaFin_p,
    p.estado AS estado_p,
    p.fechaCreacion AS fechaCreacion_p,
    -- Incluir información adicional si es necesario, como el número de clientes por proyecto
    (SELECT COUNT(*) FROM Cliente c WHERE c.nombre_proyecto = p.nombre) AS total_clientes
FROM 
    Proyecto p
ORDER BY 
    p.fechaCreacion DESC;

-- Añadir comentario a la vista
COMMENT ON TABLE proyecto_completo_CRUD IS 'Vista que muestra información completa de proyectos para operaciones CRUD';