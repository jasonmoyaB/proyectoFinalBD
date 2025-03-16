create sequence fide_roles_seq
start with 1
increment by 1
nocache
nocycle;

INSERT INTO fide_roles_tb (id_rol, nombre_rol)
VALUES (fide_roles_seq.NEXTVAL, 'nombre_del_rol');
SELECT fide_roles_seq.CURRVAL FROM dual;
SELECT MAX(id_rol) FROM fide_roles_tb;
ALTER SEQUENCE fide_roles_seq START WITH 3;

DROP SEQUENCE fide_roles_seq;

CREATE SEQUENCE fide_roles_seq
START WITH 3  -- o el valor que necesites
INCREMENT BY 1
NOCACHE
NOCYCLE;




INSERT INTO fide_roles_tb (id_rol, nombre_rol)
VALUES (fide_roles_seq.NEXTVAL, 'admin');
INSERT INTO fide_roles_tb (id_rol, nombre_rol)
VALUES (fide_roles_seq.NEXTVAL, 'user');

select * from fide_roles_tb;
select * from fide_usuarios_tb;

CREATE SEQUENCE fide_usuarios_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;
