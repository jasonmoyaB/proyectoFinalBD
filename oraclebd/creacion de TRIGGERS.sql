
--================================================================
--                  asignacion Recursos
--================================================================
create or replace trigger asignacion_recurso_id_trg
before insert on fide_asignacion_recursos_tb
for each row
begin 
:new.ID_ASIGNACION:=asignacion_recursos_seq.nextval;
end;
--ACCION
create or replace trigger accion_asignacion_recursos_trg
before insert or update  on fide_asignacion_recursos_tb
for each row 
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_asignacion_trg
before insert or update on fide_asignacion_recursos_tb
for each row 
begin
if inserting then 
    :new.creation_date:=sysdate;
    :new.created_by:=user;
end if;
    :new.last_update_date:=sysdate;
    :new.Last_update_by:=user;
end;

--================================================================
--                      calendario
--================================================================
create or replace trigger calendario_id_trg
before insert on fide_calendario_tb
for each row

begin 
:new.id_calendario:=calendario_seq.nextval;
end;
--accion
create or replace trigger accion_calendario_trg
before insert on fide_calendario_tb
for each row
begin 
if inserting then
    :new.accion:='Insertado';
elsif updating then
    :new.accion:= 'Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_calendario_trg
before insert or update on fide_calendario_tb
for each row
begin 
if inserting then 
    :new.creation_date:=sysdate;
    :new.created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;
end;
--================================================================
--                      CATEGORIAS
--================================================================
create or replace trigger categorias_id_trg
before insert on fide_categorias_tb
for each row

begin 
:new.id_categoria:=categorias_seq.nextval;
end;
--accion
create or replace trigger accion_categorias_trg
before insert on fide_categorias_tb
for each row
begin 
if inserting then
    :new.accion:='Insertado';
elsif updating then
    :new.accion:= 'Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_categorias_trg
before insert or update on fide_categorias_tb
for each row
begin 
if inserting then 
    :new.creation_date:=sysdate;
    :new.created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;
end;
--================================================================
--                      CLIENTES
--================================================================
create or replace trigger cliente_id_trg
before insert on fide_clientes_tb
for each row
begin 
:new.id_cliente:=clientes_seq.nextval;
end;


create or replace trigger accion_cliente_id_trg
before insert or update on fide_clientes_tb
for each row 
begin 
if inserting then
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;

end;

--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_clientes_trg
before insert or update on fide_clientes_tb
for each row 
begin
if inserting then
    :new.creation_date:=sysdate;
    :new.created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;
end;
select * from fide_clientes_tb;
update fide_clientes_tb
set nombre_cliente='Tech Solutions'
where id_cliente=1;


--================================================================
--                      COMENTARIOS
--================================================================
create or replace trigger comentarios_id_trg
before insert on fide_comentarios_tb
for each row
begin
:new.id_comentario:=comentarios_seq.nextval;

end;
--accion
create or replace trigger accion_comentarios_trg
before insert or update on fide_comentarios_tb
for each row 
begin
if inserting then
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;

--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_comentarios_trg
before insert or update on fide_comentarios_tb
for each row 
begin
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;
--================================================================
--                      DEPARTAMENTOS
--================================================================
create or replace trigger departamentos_id_trg
before insert on fide_departamento_tb
for each row
begin 
:new.id_departamento:=departamento_seq.nextval;
end;
--accion
create or replace trigger accion_departamentos_trg
before insert or update on fide_departamento_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if ;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_departamentos_trg
before insert on fide_departamento_tb
for each row

begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;

--================================================================
--                      HISTORIAL
--================================================================
create or replace trigger historial_id_trg
before insert on fide_historial_tb
for each row
begin 
:new.id_historial:=historial_seq.nextval;
end;
--accion
create or replace trigger accion_historial_trg
before insert or update on fide_historial_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insertar_historial_trg
before insert or update on fide_historial_tb
for each row
begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;
--================================================================
--                      NOTIFICACIONES
--================================================================
create or replace trigger notificaciones_id_trg
before insert on fide_notificaciones_tb
for each row
begin 
:new.id_notificacion:=notificaciones_seq.nextval;
end;
--accion
create or replace trigger accion_notificaciones_trg
before insert or update on fide_notificaciones_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_notificaciones_trg
before insert or update on fide_notificaciones_tb
for each row
begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;

--================================================================
--                       PERMISOS
--================================================================
create or replace trigger permisos_id_trg
before insert on fide_permisos_tb
for each row
begin 
:new.id_permiso:=permisos_seq.nextval;
end;
--accion
create or replace trigger accion_permisos_trg
before insert or update on fide_permisos_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_permisos_trg
before insert or update on fide_permisos_tb
for each row
begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;

--================================================================
--                       PROVEEDORES
--================================================================
create or replace trigger proveedores_id_trg
before insert on fide_proveedores_tb
for each row
begin 
:new.id_proveedor:=proveedores_seq.nextval;
end;
--accion
create or replace trigger accion_proveedores_trg
before insert or update on fide_proveedores_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_proveedores_trg
before insert or update on fide_proveedores_tb
for each row
begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;
update fide_proveedores_tb
set nombre_proveedor='Keneth Pol'
where id_proveedor=6;
--================================================================
--                       RECURSOS
--================================================================
create or replace trigger recursos_id_trg
before insert on fide_recursos_tb
for each row
begin 
:new.id_recurso:=recursos_seq.nextval;
end;
--accion
create or replace trigger accion_recursos_trg
before insert or update on fide_recursos_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_recursos_trg
before insert or update on fide_recursos_tb
for each row
begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;

--================================================================
--                       ROLES
--================================================================
create or replace trigger roles_id_trg
before insert on fide_roles_tb
for each row
begin 
:new.id_rol:=roles_seq.nextval;
end;
--accion
create or replace trigger accion_roles_trg
before insert or update on fide_roles_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_roles_trg
before insert or update on fide_roles_tb
for each row
begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;
--================================================================
--                       TAREAS
--================================================================
create or replace trigger tareas_id_trg
before insert on fide_tareas_tb
for each row
begin 
:new.id_tarea:=tareas_seq.nextval;
end;
--accion
create or replace trigger accion_tareas_trg
before insert or update on fide_tareas_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger accion_tareas_trg
before insert or update on fide_tareas_tb
for each row
begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;
--================================================================
--                       TIEMPO
--================================================================
create or replace trigger tiempo_id_trg
before insert on fide_tiempo_tb
for each row
begin 
:new.id_tiempo:=tiempo_seq.nextval;
end;
--accion
create or replace trigger accion_tiempo_trg
before insert or update on fide_tiempo_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_tiempo_trg
before insert or update on fide_tiempo_tb
for each row
begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;

--================================================================
--                       USUARIOS
--================================================================
create or replace trigger usuarios_id_trg
before insert on fide_usuarios_tb
for each row
begin 
:new.id_usuario:=usuarios_seq.nextval;
end;
--accion
create or replace trigger accion_usuario_trg
before insert or update on fide_usuarios_tb
for each row
begin
if inserting then 
    :new.accion:='Insertado';
elsif updating then
    :new.accion:='Actualizado';
end if;
end;
--Los campos Creation_date, Last_update_date, Created_by y Last_update_by deben de 
--generarse de forma automática mediante Triggers. 
create or replace trigger insert_usuarios_trg
before insert or update on fide_usuarios_tb
for each row
begin 
if inserting then 
    :new.Creation_date:=sysdate;
    :new.Created_by:=user;
end if;
    :new.Last_update_date:=sysdate;
    :new.Last_update_by:=user;

end;
update fide_usuarios_tb
set nombre='Sabado'
where id_usuario=5;
