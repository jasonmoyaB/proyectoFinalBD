
create or replace view comentarios_View as
select 
contenido,
fecha_comentario
from fide_comentarios_tb;

select * from comentarios_View;
ALTER TABLE fide_comentarios_tb
MODIFY contenido VARCHAR2(200);
 
 
