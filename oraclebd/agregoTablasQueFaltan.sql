create table fide_clientes_tb (
    id_cliente number constraint fide_clientes_id_pk primary key,
    nombre_cliente varchar2(100),
    correo_cliente varchar2(100) unique,
    telefono varchar2(20),
    id_proyecto number constraint fide_clientes_proyecto_fk references fide_proyectos_tb(id_proyecto)
);



create table fide_proveedores_tb (
    id_proveedor number constraint fide_proveedores_id_pk primary key,
    nombre_proveedor varchar2(100),
    contacto varchar2(100),
    telefono varchar2(20)
);

create table fide_recursos_tb (
    id_recurso number constraint fide_recursos_id_pk primary key,
    nombre_recurso varchar2(100),
    descripcion clob,--el clob es para almacenar datos mas grandes
    id_proveedor number constraint fide_recursos_proveedor_fk references fide_proveedores_tb(id_proveedor)
);
create table fide_asignacion_recursos_tb (
    id_asignacion number constraint fide_asignacion_recursos_id_pk primary key,
    id_tarea number constraint fide_asignacion_tarea_fk references fide_tareas_tb(id_tarea),
    id_recurso number constraint fide_asignacion_recurso_fk references fide_recursos_tb(id_recurso)
);

create table fide_comentarios_tb (
    id_comentario number constraint fide_comentarios_id_pk primary key,
    contenido varchar2(100),
    fecha_comentario date default sysdate,
    id_usuario number constraint fide_comentarios_usuario_fk references fide_usuarios_tb(id_usuario),
    id_tarea number constraint fide_comentarios_tarea_fk references fide_tareas_tb(id_tarea)
);

create table fide_notificaciones_tb (
    id_notificacion number constraint fide_notificaciones_id_pk primary key,
    mensaje varchar2(100),
    fecha_notificacion date default sysdate,
    id_usuario number constraint fide_notificaciones_usuario_fk references fide_usuarios_tb(id_usuario),
    leido varchar2(1)
);

create table fide_historial_tb (
    id_historial number constraint fide_historial_id_pk primary key,
    descripcion_cambio clob,
    fecha_cambio date default sysdate,
    id_usuario number constraint fide_historial_usuario_fk references fide_usuarios_tb(id_usuario),
    id_tarea number constraint fide_historial_tarea_fk references fide_tareas_tb(id_tarea)
);

create table fide_categorias_tb (
    id_categoria number constraint fide_categorias_id_pk primary key,
    nombre_categoria varchar2(100)
);