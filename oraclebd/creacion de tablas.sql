-- Tabla de roles
create table fide_roles_tb (
    rol_id number constraint fide_roles_id_pk primary key,
    nombre_rol varchar2(50)
);

-- Tabla de permisos
create table fide_permisos_tb (
    permiso_id number constraint fide_permisos_id_pk primary key,
    nombre_permiso varchar2(50)
);

-- Tabla de usuarios
create table fide_usuarios_tb (
    usuario_id number constraint fide_usuarios_id_pk primary key,
    nombre varchar2(100),
    correo varchar2(100) unique,
    contrasena varchar2(255),
    rol_id number constraint fide_usuarios_rol_fk references fide_roles_tb(rol_id)
);

-- Tabla de proyectos
create table fide_proyectos_tb (
    proyecto_id number constraint fide_proyectos_id_pk primary key,
    nombre_proyecto varchar2(100),
    descripcion clob,
    fecha_creacion date default sysdate,
    usuario_id number constraint fide_proyectos_usuario_fk references fide_usuarios_tb(usuario_id)
);

-- Tabla de tareas
create table fide_tareas_tb (
    tarea_id number constraint fide_tareas_id_pk primary key,
    nombre_tarea varchar2(100),
    descripcion clob,
    estado varchar2(20),
    fecha_limite date,
    proyecto_id number constraint fide_tareas_proyecto_fk references fide_proyectos_tb(proyecto_id),
    usuario_id number constraint fide_tareas_usuario_fk references fide_usuarios_tb(usuario_id)
);

-- Tabla de tiempo (registro de tiempo de trabajo en tareas)
create table fide_tiempo_tb (
    tiempo_id number constraint fide_tiempo_id_pk primary key,
    tiempo_inicio timestamp,
    tiempo_fin timestamp,
    tarea_id number constraint fide_tiempo_tarea_fk references fide_tareas_tb(tarea_id)
);

-- Tabla de calendario (registro de fechas importantes de tareas)
create table fide_calendario_tb (
    calendario_id number constraint fide_calendario_id_pk primary key,
    fecha date,
    tarea_id number constraint fide_calendario_tarea_fk references fide_tareas_tb(tarea_id)
);


insert into fide_usuarios_tb(usuario_id, nombre,correo,contrasena)
values(1,'jason','jason@gmail.com','holaMundo');

insert into fide_usuarios_tb(usuario_id, nombre,correo,contraseña)
values(2,'jose','jose@gmail.com','holaEr');

alter table fide_usuarios_tb
rename column contrasena to contraseña;
