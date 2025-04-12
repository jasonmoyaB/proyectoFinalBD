-- Crear la tabla Proyecto
CREATE TABLE FIDE_Proyectos_TB (
    id_proyecto NUMBER PRIMARY KEY,
    nombre_proyecto VARCHAR2(100) NOT NULL,
    descripcion_proyecto VARCHAR2(500),
    fechaInicio_p DATE,
    fechaFin_p DATE,
    estado_p VARCHAR2(50),
    fechaCreacion_p DATE DEFAULT SYSDATE
);

-- Crear secuencia para autoincremento del ID
CREATE SEQUENCE SEQ_PROYECTO_ID_PROYECTO
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

-- Crear trigger para autoincremento del ID
CREATE OR REPLACE TRIGGER TRG_PROYECTO_ID
BEFORE INSERT ON Proyecto
FOR EACH ROW
BEGIN
    SELECT SEQ_PROYECTO_ID_PROYECTO.NEXTVAL
    INTO :NEW.id
    FROM DUAL;
END;
/

-- Índices para optimizar búsquedas
CREATE INDEX IDX_PROYECTO_NOMBRE ON Proyecto(nombre);
CREATE INDEX IDX_PROYECTO_ESTADO ON Proyecto(estado);

-- Comentarios para la tabla y columnas
COMMENT ON TABLE Proyecto IS 'Tabla que almacena la información de los proyectos';
COMMENT ON COLUMN Proyecto.id IS 'Identificador único del proyecto';
COMMENT ON COLUMN Proyecto.nombre IS 'Nombre del proyecto';
COMMENT ON COLUMN Proyecto.descripcion IS 'Descripción detallada del proyecto';
COMMENT ON COLUMN Proyecto.fechaInicio IS 'Fecha de inicio del proyecto';
COMMENT ON COLUMN Proyecto.fechaFin IS 'Fecha de finalización del proyecto';
COMMENT ON COLUMN Proyecto.estado IS 'Estado actual del proyecto (Activo, Finalizado, Cancelado, etc.)';
COMMENT ON COLUMN Proyecto.fechaCreacion IS 'Fecha en que se creó el registro del proyecto';

-- Procedimientos almacenados básicos para CRUD

-- Insertar nuevo proyecto
CREATE OR REPLACE PROCEDURE SP_INSERTAR_PROYECTO (
    p_nombre IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fechaInicio IN DATE,
    p_fechaFin IN DATE,
    p_estado IN VARCHAR2
) AS
BEGIN
    INSERT INTO Proyecto (nombre, descripcion, fechaInicio, fechaFin, estado, fechaCreacion)
    VALUES (p_nombre, p_descripcion, p_fechaInicio, p_fechaFin, p_estado, SYSDATE);
    COMMIT;
END;
/

-- Actualizar proyecto existente
CREATE OR REPLACE PROCEDURE SP_ACTUALIZAR_PROYECTO (
    p_id IN NUMBER,
    p_nombre IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_fechaInicio IN DATE,
    p_fechaFin IN DATE,
    p_estado IN VARCHAR2
) AS
BEGIN
    UPDATE Proyecto
    SET nombre = p_nombre,
        descripcion = p_descripcion,
        fechaInicio = p_fechaInicio,
        fechaFin = p_fechaFin,
        estado = p_estado
    WHERE id = p_id;
    COMMIT;
END;
/

-- Eliminar proyecto
CREATE OR REPLACE PROCEDURE SP_ELIMINAR_PROYECTO (
    p_id IN NUMBER
) AS
BEGIN
    DELETE FROM Proyecto WHERE id = p_id;
    COMMIT;
END;
/

-- Consultar proyecto por ID
CREATE OR REPLACE FUNCTION FN_OBTENER_PROYECTO (
    p_id IN NUMBER
) RETURN SYS_REFCURSOR AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT id, nombre, descripcion, fechaInicio, fechaFin, estado, fechaCreacion
    FROM Proyecto
    WHERE id = p_id;
    
    RETURN v_cursor;
END;
/

-- Listar todos los proyectos
CREATE OR REPLACE FUNCTION FN_LISTAR_PROYECTOS RETURN SYS_REFCURSOR AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT id, nombre, descripcion, fechaInicio, fechaFin, estado, fechaCreacion
    FROM Proyecto
    ORDER BY fechaCreacion DESC;
    
    RETURN v_cursor;
END;
/

-- Listar proyectos por estado
CREATE OR REPLACE FUNCTION FN_LISTAR_PROYECTOS_POR_ESTADO (
    p_estado IN VARCHAR2
) RETURN SYS_REFCURSOR AS
    v_cursor SYS_REFCURSOR;
BEGIN
    OPEN v_cursor FOR
    SELECT id, nombre, descripcion, fechaInicio, fechaFin, estado, fechaCreacion
    FROM Proyecto
    WHERE estado = p_estado
    ORDER BY fechaCreacion DESC;
    
    RETURN v_cursor;
END;
/