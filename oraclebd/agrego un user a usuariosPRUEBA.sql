select * from fide_usuarios_tb;
select * from fide_roles_tb;
insert into fide_roles_tb(rol_id, nombre_rol)
values(1,'empacar');
insert into fide_roles_tb(rol_id, nombre_rol)
values(2,'jugar');

DELETE FROM fide_usuarios_tb
WHERE usuario_id IN (1, 2);
DELETE FROM fide_roles_tb
WHERE rol_id IN (1, 2);

insert into fide_usuarios_tb(usuario_id, nombre, correo, contraseña, rol_id)
values(1,'jason','jason@gmail.com','holaaa',1);
insert into fide_usuarios_tb(usuario_id, nombre, correo, contraseña, rol_id)
values(2,'jose','jose@gmail.com','hosesada',2);