create or replace view usuario_completo_CRUD as
select
    u.id_usuario,
    u.nombre,
    u.correo,
    u.contraseña,
    r.nombre_rol,
    d.nombre_departamento
from fide_usuarios_tb u
join fide_roles_tb r on u.id_rol=r.id_rol
join fide_departamento_tb d on u.id_departamento = d.id_departamento;



desc cliente_completo_CRUD;
select * from usuario_completo_CRUD;
select * from fide_usuarios_tb;
select * from fide_proyectos_tb;
select * from fide_clientes_tb;
select * from cliente_completo_CRUD;

create or replace view cliente_completo_CRUD as 
select
    c.id_cliente,
    c.nombre_cliente,
    c.correo_cliente,
    c.telefono,
    p.nombre_proyecto
from fide_clientes_tb c
join fide_proyectos_tb p on c.id_proyecto = p.id_proyecto;





--
