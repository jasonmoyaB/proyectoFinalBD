select * from fide_usuarios_tb;
insert into fide_usuarios_tb (id_usuario, nombre, correo, contraseña, id_rol)
values(3549443,'jason','jason.moyabre.es@gmail.com','jasonmoya12',1);

insert into fide_usuarios_tb (id_usuario, nombre, correo, contraseña, id_rol)
values(3549445,'Jorge','jorge@gmail.com','jorge12',2);

insert into fide_roles_tb(id_rol, nombre_rol)
values(1,'admin');
insert into fide_roles_tb(id_rol, nombre_rol)
values(2,'User');

create or replace view usuario_rol_View as
select u.nombre,
u.correo,
u.contraseña,
r.nombre_rol
from fide_usuarios_tb u
join fide_roles_tb r on u.id_rol=r.id_rol;

drop VIEW usuario_rol_View;

select * from usuario_rol_View;