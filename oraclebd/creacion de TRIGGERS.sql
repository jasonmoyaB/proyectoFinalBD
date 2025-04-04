
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
delete from fide_clientes_tb
where id_cliente between 3 and 5;