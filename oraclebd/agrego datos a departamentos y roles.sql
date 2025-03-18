create or replace procedure insertar_roles (
p_id_rol in number,
p_nombre_rol in varchar
)is

begin
insert into fide_roles_tb(id_rol,nombre_rol)
values(p_id_rol,p_nombre_rol);

end;
                

    
begin
    -- inserciones utilizando el procedimiento insertar_roles
    insertar_roles(1, 'admin');
    insertar_roles(2, 'usuario');
    insertar_roles(3, 'gerente');
    insertar_roles(4, 'supervisor');
    insertar_roles(5, 'empleado');
    insertar_roles(6, 'cliente');
    insertar_roles(7, 'vendedor');
    insertar_roles(8, 'desarrollador');
    insertar_roles(9, 'tester');
    insertar_roles(10, 'administrador de base de datos');
    insertar_roles(11, 'analista');
    insertar_roles(12, 'soporte');
    insertar_roles(13, 'director');
    insertar_roles(14, 'product owner');
    insertar_roles(15, 'scrum master');
    
    commit;
end;


    

create or replace procedure insertar_departamentos(
    p_id_departamento in number,
    p_nombre_departamento in varchar
) is
begin
    insert into fide_departamento_tb(id_departamento, nombre_departamento)
    values(p_id_departamento, p_nombre_departamento);
end;

begin
    -- inserciones de departamentos utilizando el procedimiento insertar_departamentos
    insertar_departamentos(1, 'IT');
    insertar_departamentos(2, 'Recursos Humanos');
    insertar_departamentos(3, 'Ventas');
    insertar_departamentos(4, 'Marketing');
    insertar_departamentos(5, 'Finanzas');
    insertar_departamentos(6, 'Legal');
    insertar_departamentos(7, 'Producción');
    insertar_departamentos(8, 'Investigación y Desarrollo');
    insertar_departamentos(9, 'Atención al Cliente');
    insertar_departamentos(10, 'Logística');
    insertar_departamentos(11, 'Administración');
    insertar_departamentos(12, 'Soporte Técnico');
    insertar_departamentos(13, 'Planificación');
    insertar_departamentos(14, 'Calidad');
    insertar_departamentos(15, 'Relaciones Públicas');
    
    commit;
end;
ALTER PROCEDURE insertar_roles COMPILE;

create or replace procedure insertar_usuarios (
    p_id_usuario in number,
    p_nombre in varchar2,
    p_correo in varchar2,
    p_contraseña in varchar2,
    p_id_rol in number,
    p_id_departamento in number
) is
begin
    insert into fide_usuarios_tb(id_usuario, nombre, correo, contraseña, id_rol, id_departamento)
    values(p_id_usuario, p_nombre, p_correo, p_contraseña, p_id_rol, p_id_departamento);
end;

begin
    
    insertar_usuarios(1, 'Jason Moya', 'jason.moyabre.es@gmail.com', 'jasonmoya12', 1, 1);
    insertar_usuarios(2, 'Jorge Pérez', 'jorge@gmail.com', 'jorge12', 2, 2);
    insertar_usuarios(3, 'Maria López', 'maria.lopez@gmail.com', 'maria123', 3, 3);
    insertar_usuarios(4, 'Carlos García', 'carlos.garcia@gmail.com', 'carlos123', 4, 4);
    insertar_usuarios(5, 'Ana Rodríguez', 'ana.rodriguez@gmail.com', 'ana1234', 5, 5);
    commit;
end;

set serverout on;
declare --cursores estaticos(este se usa la mayoria de las veces)
    -- Cursor
    cursor usuarios is
        select * from fide_usuarios_tb;
        

    v_usuario fide_usuarios_tb%rowtype;
begin 
   for v_usuario in usuarios
    
    loop
        dbms_output.put_line('Nombre usuario:'||v_usuario.nombre);
    end loop;
end;

select * from fide_roles_tb;



BEGIN
    -- inserciones utilizando el procedimiento insertar_roles
    insertar_roles(15, 'scrum master');
    insertar_roles(16, 'coordinador');
    insertar_roles(17, 'administrador de sistema');
    insertar_roles(18, 'analista de datos');
    insertar_roles(19, 'ingeniero de software');
    insertar_roles(20, 'jefe de proyecto');
    insertar_roles(21, 'programador junior');
    insertar_roles(22, 'programador senior');
    insertar_roles(23, 'arquitecto de software');
    insertar_roles(24, 'consultor');
    insertar_roles(25, 'diseñador de interfaz');
    insertar_roles(26, 'ingeniero de calidad');
    insertar_roles(27, 'administrador de infraestructura');
    insertar_roles(28, 'gestor de proyectos');
    insertar_roles(29, 'auditor de seguridad');
    insertar_roles(30, 'analista de soporte técnico');
    
    COMMIT;
END;

BEGIN
    -- inserciones de departamentos utilizando el procedimiento insertar_departamentos
    insertar_departamentos(16, 'Seguridad');
    insertar_departamentos(17, 'Innovación');
    insertar_departamentos(18, 'Desarrollo de Producto');
    insertar_departamentos(19, 'Comunicación Corporativa');
    insertar_departamentos(20, 'Gestión de Proyectos');
    insertar_departamentos(21, 'Redes y Comunicaciones');
    insertar_departamentos(22, 'Gestión de Talento');
    insertar_departamentos(23, 'Servicio al Cliente');
    insertar_departamentos(24, 'Expansión de Mercado');
    insertar_departamentos(25, 'Auditoría Interna');
    insertar_departamentos(26, 'Relaciones Internacionales');
    insertar_departamentos(27, 'Estrategia y Planeación');
    insertar_departamentos(28, 'Alianzas Estratégicas');
    insertar_departamentos(29, 'Desarrollo de Negocios');
    insertar_departamentos(30, 'Customer Success');
    
    COMMIT;
END;

