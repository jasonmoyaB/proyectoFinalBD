SELECT name, value 
FROM v$parameter 
WHERE name = 'common_user_prefix';
 
/
CREATE USER proyectoMain IDENTIFIED BY mbrenes12;
 

ALTER SYSTEM SET common_user_prefix='' scope=spfile;
 
Grant CREATE session TO proyectoMain;
 
/
Grant DBA to proyectoMain;
 
/
Grant resource to proyectoMain;

grant all privileges to proyectoMain;


