alter table fide_asignacion_recursos_tb
add (
    created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date
);
alter table fide_asignacion_recursos_tb
add accion varchar2(100);

alter table fide_calendario_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_categorias_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);

alter table fide_clientes_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_comentarios_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_departamento_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_historial_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_notificaciones_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_permisos_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_proveedores_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_proyectos_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_recursos_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_roles_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_tareas_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);
alter table fide_tiempo_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);

alter table fide_usuarios_tb
add(
created_by varchar2(100),
    creation_date date,
    last_update_by varchar2(100),
    last_update_date date,
    accion varchar2(100)
);