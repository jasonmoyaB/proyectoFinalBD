-- tabla de permisos
create table fide_permisos_tb (
    id_permiso number constraint fide_permisos_pk primary key,
    nombre_permiso varchar2(50) not null
);

-- tabla de roles
create table fide_roles_tb (
    id_rol number constraint fide_roles_pk primary key,
    nombre_rol varchar2(50) not null
);

-- tabla de usuarios
create table fide_usuarios_tb (
    id_usuario number constraint fide_usuarios_pk primary key,
    nombre varchar2(50) not null,
    correo varchar2(100) constraint fide_usuarios_correo_unique unique not null,
    contraseña varchar2(100) not null,
    id_rol number constraint fide_usuarios_id_rol_fk references fide_roles_tb(id_rol)
);

-- tabla de proyectos
create table fide_proyectos_tb (
    id_proyecto number constraint fide_proyectos_pk primary key,
    nombre_proyecto varchar2(100) not null,
    descripcion varchar2(255),
    fecha_creacion date default sysdate not null,
    id_usuario number constraint fide_proyectos_id_usuario_fk references fide_usuarios_tb(id_usuario)
);
--tabla tareas
create table fide_tareas_tb (
    id_tarea number constraint fide_tareas_pk primary key,
    nombre_tarea varchar2(100) not null,
    descripcion varchar2(255),
    estado varchar2(20),
    fecha_limite date,
    id_proyecto number constraint fide_tareas_id_proyecto_fk references fide_proyectos_tb(id_proyecto),
    id_usuario number constraint fide_tareas_id_usuario_fk references fide_usuarios_tb(id_usuario)
);

create table fide_calendario_tb (
    id_calendario number constraint fide_calendario_pk primary key,
    fecha date not null,
    id_tarea number constraint fide_calendario_id_tarea_fk references fide_tareas_tb(id_tarea)
);


-- tabla de tiempo
create table fide_tiempo_tb (
    id_tiempo number constraint fide_tiempo_pk primary key,
    tiempo_inicio timestamp not null,
    tiempo_fin timestamp,
    id_tarea number constraint fide_tiempo_id_tarea_fk references fide_tareas_tb(id_tarea)
);