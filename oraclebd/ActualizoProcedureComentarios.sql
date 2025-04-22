select * from comentarios_View;
drop  view comentarios_View;
create or replace view comentarios_View as
select 
contenido,
fecha_comentario
from fide_comentarios_tb;
