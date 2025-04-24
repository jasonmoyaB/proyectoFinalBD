ALTER TABLE fide_categorias_tb
ADD id_proyecto NUMBER;

ALTER TABLE fide_categorias_tb
ADD CONSTRAINT fk_proyecto
FOREIGN KEY (id_proyecto)
REFERENCES fide_proyectos_tb(id_proyecto);

select * from fide_categorias_tb;