create table fide_departamento_tb (
    id_departamento number constraint fide_departamento_pk primary key,   
    nombre_departamento varchar2(100) not null
);
ALTER TABLE fide_usuarios_tb
ADD id_departamento NUMBER;

ALTER TABLE fide_usuarios_tb
ADD CONSTRAINT fk_usuario_departamento
FOREIGN KEY (id_departamento)
REFERENCES fide_departamento_tb(id_departamento);

