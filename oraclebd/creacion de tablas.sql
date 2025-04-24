-- Tabla de roles
CREATE TABLE fide_roles_tb (
    rol_id NUMBER CONSTRAINT fide_roles_id_pk PRIMARY KEY,
    nombre_rol VARCHAR2(50)
);

-- Tabla de permisos
CREATE TABLE fide_permisos_tb (
    permiso_id NUMBER CONSTRAINT fide_permisos_id_pk PRIMARY KEY,
    nombre_permiso VARCHAR2(50)
);

-- Tabla de usuarios
CREATE TABLE fide_usuarios_tb (
    usuario_id NUMBER CONSTRAINT fide_usuarios_id_pk PRIMARY KEY,
    nombre VARCHAR2(100),
    correo VARCHAR2(100) UNIQUE,
    contrasena VARCHAR2(255),
    rol_id NUMBER,
    CONSTRAINT fide_usuarios_rol_fk FOREIGN KEY (rol_id) REFERENCES fide_roles_tb(rol_id)
);

-- Tabla de proyectos
CREATE TABLE fide_proyectos_tb (
    proyecto_id NUMBER CONSTRAINT fide_proyectos_id_pk PRIMARY KEY,
    nombre_proyecto VARCHAR2(100),
    descripcion CLOB,
    fecha_creacion DATE DEFAULT SYSDATE,
    usuario_id NUMBER,
    CONSTRAINT fide_proyectos_usuario_fk FOREIGN KEY (usuario_id) REFERENCES fide_usuarios_tb(usuario_id)
);

-- Tabla de tareas
CREATE TABLE fide_tareas_tb (
    tarea_id NUMBER CONSTRAINT fide_tareas_id_pk PRIMARY KEY,
    nombre_tarea VARCHAR2(100),
    descripcion CLOB,
    estado VARCHAR2(20),
    fecha_limite DATE,
    proyecto_id NUMBER,
    usuario_id NUMBER,
    CONSTRAINT fide_tareas_proyecto_fk FOREIGN KEY (proyecto_id) REFERENCES fide_proyectos_tb(proyecto_id),
    CONSTRAINT fide_tareas_usuario_fk FOREIGN KEY (usuario_id) REFERENCES fide_usuarios_tb(usuario_id)
);

-- Tabla de tiempo
CREATE TABLE fide_tiempo_tb (
    tiempo_id NUMBER CONSTRAINT fide_tiempo_id_pk PRIMARY KEY,
    tiempo_inicio TIMESTAMP,
    tiempo_fin TIMESTAMP,
    tarea_id NUMBER,
    CONSTRAINT fide_tiempo_tarea_fk FOREIGN KEY (tarea_id) REFERENCES fide_tareas_tb(tarea_id)
);

-- Tabla de calendario
CREATE TABLE fide_calendario_tb (
    calendario_id NUMBER CONSTRAINT fide_calendario_id_pk PRIMARY KEY,
    fecha DATE,
    tarea_id NUMBER,
    CONSTRAINT fide_calendario_tarea_fk FOREIGN KEY (tarea_id) REFERENCES fide_tareas_tb(tarea_id)
);

-- Tabla de clientes
CREATE TABLE fide_clientes_tb (
    id_cliente NUMBER CONSTRAINT fide_clientes_id_pk PRIMARY KEY,
    nombre_cliente VARCHAR2(100),
    correo_cliente VARCHAR2(100) UNIQUE,
    telefono VARCHAR2(20),
    id_proyecto NUMBER,
    CONSTRAINT fide_clientes_proyecto_fk FOREIGN KEY (id_proyecto) REFERENCES fide_proyectos_tb(proyecto_id)
);

-- Tabla de proveedores
CREATE TABLE fide_proveedores_tb (
    id_proveedor NUMBER CONSTRAINT fide_proveedores_id_pk PRIMARY KEY,
    nombre_proveedor VARCHAR2(100),
    contacto VARCHAR2(100),
    telefono VARCHAR2(20)
);

-- Tabla de recursos
CREATE TABLE fide_recursos_tb (
    id_recurso NUMBER CONSTRAINT fide_recursos_id_pk PRIMARY KEY,
    nombre_recurso VARCHAR2(100),
    descripcion CLOB,
    id_proveedor NUMBER,
    CONSTRAINT fide_recursos_proveedor_fk FOREIGN KEY (id_proveedor) REFERENCES fide_proveedores_tb(id_proveedor)
);

-- Tabla de asignación de recursos
CREATE TABLE fide_asignacion_recursos_tb (
    id_asignacion NUMBER CONSTRAINT fide_asignacion_recursos_id_pk PRIMARY KEY,
    id_tarea NUMBER,
    id_recurso NUMBER,
    CONSTRAINT fide_asignacion_tarea_fk FOREIGN KEY (id_tarea) REFERENCES fide_tareas_tb(tarea_id),
    CONSTRAINT fide_asignacion_recurso_fk FOREIGN KEY (id_recurso) REFERENCES fide_recursos_tb(id_recurso)
);

-- Tabla de comentarios
CREATE TABLE fide_comentarios_tb (
    id_comentario NUMBER CONSTRAINT fide_comentarios_id_pk PRIMARY KEY,
    contenido VARCHAR2(100),
    fecha_comentario DATE DEFAULT SYSDATE,
    id_usuario NUMBER,
    id_tarea NUMBER,
    CONSTRAINT fide_comentarios_usuario_fk FOREIGN KEY (id_usuario) REFERENCES fide_usuarios_tb(usuario_id),
    CONSTRAINT fide_comentarios_tarea_fk FOREIGN KEY (id_tarea) REFERENCES fide_tareas_tb(tarea_id)
);

-- Tabla de notificaciones
CREATE TABLE fide_notificaciones_tb (
    id_notificacion NUMBER CONSTRAINT fide_notificaciones_id_pk PRIMARY KEY,
    mensaje VARCHAR2(100),
    fecha_notificacion DATE DEFAULT SYSDATE,
    id_usuario NUMBER,
    leido VARCHAR2(1),
    CONSTRAINT fide_notificaciones_usuario_fk FOREIGN KEY (id_usuario) REFERENCES fide_usuarios_tb(usuario_id)
);

-- Tabla de historial
CREATE TABLE fide_historial_tb (
    id_historial NUMBER CONSTRAINT fide_historial_id_pk PRIMARY KEY,
    descripcion_cambio CLOB,
    fecha_cambio DATE DEFAULT SYSDATE,
    id_usuario NUMBER,
    id_tarea NUMBER,
    CONSTRAINT fide_historial_usuario_fk FOREIGN KEY (id_usuario) REFERENCES fide_usuarios_tb(usuario_id),
    CONSTRAINT fide_historial_tarea_fk FOREIGN KEY (id_tarea) REFERENCES fide_tareas_tb(tarea_id)
);

-- Tabla de categorías
CREATE TABLE fide_categorias_tb (
    id_categoria NUMBER CONSTRAINT fide_categorias_id_pk PRIMARY KEY,
    nombre_categoria VARCHAR2(100)
);
