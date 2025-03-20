--Funcion que obtiene el nombre del usuario con mas tareas asignadas
CREATE OR REPLACE FUNCTION get_usuario_mas_tareas_FN RETURN VARCHAR2 IS
    v_nombre_usuario VARCHAR2(100);
BEGIN
    SELECT nombre INTO v_nombre_usuario 
    FROM fide_usuarios_tb 
    WHERE usuario_id = (SELECT usuario_id FROM fide_tareas_tb GROUP BY usuario_id ORDER BY COUNT(*) DESC FETCH FIRST 1 ROW ONLY);
    RETURN v_nombre_usuario;
END;
/
SELECT get_usuario_mas_tareas_FN() AS USUARIO_CON_MAS_TAREAS_ASIGNADAS FROM dual;
/
---- funcion que obtiene el nombre del proyecto con m�s tareas
CREATE OR REPLACE FUNCTION get_proyecto_mas_tareas_FN RETURN VARCHAR2 IS
    v_nombre_proyecto VARCHAR2(100);
BEGIN
    SELECT nombre_proyecto INTO v_nombre_proyecto 
    FROM fide_proyectos_tb 
    WHERE proyecto_id = (SELECT proyecto_id FROM fide_tareas_tb GROUP BY proyecto_id ORDER BY COUNT(*) DESC FETCH FIRST 1 ROW ONLY);
    RETURN v_nombre_proyecto;
END;
/
SELECT get_proyecto_mas_tareas_FN() AS PROYECTO_CON_MAS_TAREAS FROM dual;
/
-- Funcion que obtiene la cantidad de usuarios sin tareas asignadas
CREATE OR REPLACE FUNCTION get_usuarios_sin_tareas_FN RETURN NUMBER IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count 
    FROM fide_usuarios_tb 
    WHERE usuario_id NOT IN (SELECT usuario_id FROM fide_tareas_tb);
    RETURN v_count;
END;
/
SELECT get_usuarios_sin_tareas_FN() AS USUARIOS_SIN_TAREAS FROM dual;
/

--- Funcion que obtiene la tarea m�s cercana a su fecha l�mite
CREATE OR REPLACE FUNCTION get_tarea_mas_urgente_FN RETURN VARCHAR2 IS
    v_nombre_tarea VARCHAR2(100);
BEGIN
    SELECT nombre_tarea INTO v_nombre_tarea 
    FROM fide_tareas_tb 
    WHERE fecha_limite = (SELECT MIN(fecha_limite) FROM fide_tareas_tb WHERE estado != 'Completado');
    RETURN v_nombre_tarea;
END;
/
SELECT get_tarea_mas_urgente_FN() AS TAREA_MAS_CERCANA_FECHA_LIMITE FROM dual;
/ 

-- Obtiene el total de horas trabajadas en el sistema
CREATE OR REPLACE FUNCTION get_total_horas_trabajadas_FN RETURN NUMBER IS
    v_horas NUMBER;
BEGIN
    SELECT SUM(EXTRACT(HOUR FROM (tiempo_fin - tiempo_inicio))) INTO v_horas FROM fide_tiempo_tb;
    RETURN v_horas;
END;
/
SELECT get_total_horas_trabajadas_FN() AS HORAS_TRABAJADAS FROM dual;
/

-- Funcion que obtiene la fecha m�s importante en el calendario
CREATE OR REPLACE FUNCTION get_fecha_mas_importante_FN RETURN DATE IS
    v_fecha DATE;
BEGIN
    SELECT fecha INTO v_fecha FROM fide_calendario_tb ORDER BY fecha ASC FETCH FIRST 1 ROW ONLY;
    RETURN v_fecha;
END;
/
SELECT get_fecha_mas_importante_FN() AS FECHA_MAS_IMPORTANTE FROM dual;
/

-- Funcion que obtiene el estado m�s com�n de las tareas
CREATE OR REPLACE FUNCTION get_estado_mas_comun_FN RETURN VARCHAR2 IS
    v_estado VARCHAR2(20);
BEGIN
    SELECT estado INTO v_estado FROM fide_tareas_tb GROUP BY estado ORDER BY COUNT(*) DESC FETCH FIRST 1 ROW ONLY;
    RETURN v_estado;
END;
/
SELECT get_estado_mas_comun_FN() AS ESTADO FROM dual;
/

---Obtiene el promedio de tareas asignadas por usuario
CREATE OR REPLACE FUNCTION get_promedio_tareas_por_usuario_FN RETURN NUMBER IS
    v_promedio NUMBER;
BEGIN
    SELECT AVG(cnt) INTO v_promedio 
    FROM (SELECT COUNT(*) AS cnt FROM fide_tareas_tb GROUP BY usuario_id);
    RETURN v_promedio;
END;
/
SELECT get_promedio_tareas_por_usuario_FN() AS PROMEDIO_TAREAS_USUARIO FROM dual;




