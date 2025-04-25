CREATE OR REPLACE VIEW tarea_completa_crud_V AS
SELECT 
    id_tarea,
    nombre_tarea,
    descripcion,
    estado,
    fecha_limite
FROM fide_tareas_tb;
drop view tarea_completa_crud_V;
select * from tarea_completa_crud_V;

select * from fide_tareas_tb;

desc fide_tareas_tb;