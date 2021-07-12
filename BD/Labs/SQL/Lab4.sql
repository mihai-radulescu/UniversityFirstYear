--Lab7
1. S� se creeze tabelele EMP_mng, DEPT_mng (�n �irul de caractere �pnu�, p reprezint� 
prima liter� a prenumelui, iar nu reprezint� primele dou� litere ale numelui dumneavoastr�),
prin copierea structurii �i con�inutului tabelelor EMPLOYEES, respectiv DEPARTMENTS. 

CREATE TABLE EMP_mng AS SELECT * FROM employees;
CREATE TABLE DEPT_mng AS SELECT * FROM departments; --table DEPT_mng created.

select *
from tab;
commit;
drop table emp_mng; --sterge tabelul emp_mng
drop table dept_mng;


--drop table dep_mta;--sterge tabelul impreuna cu informatiile din el

2. Lista�i structura tabelelor surs� �i a celor create anterior. Ce se observ�?

describe employees;
Name           Null     Type         
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    --PK : not null + unicitate
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)  

describe emp_mng;
Name           Null     Type         
-------------- -------- ------------ 
EMPLOYEE_ID             NUMBER(6)    --nu mai este setata cheia primara( si nici cea externa)
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)    

desc departments;
Name            Null     Type         
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)     --pk
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)    

desc dept_mng;
Name            Null     Type         
--------------- -------- ------------ 
DEPARTMENT_ID            NUMBER(4)     --nu avem setata cheia primara
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4) 

3. Lista�i con�inutul tabelelor create anterior.
select * from emp_uli; --107 rez
select * from dept_uli; --27 dept

4. Pentru introducerea constr�ngerilor de integritate, executa�i instruc�iunile LDD indicate �n continuare. 
Prezentarea detaliat� a LDD se va face �n cadrul laboratorului 5. 

ALTER TABLE emp_mng
ADD CONSTRAINT pk_emp_mng PRIMARY KEY(employee_id);
--table EMP_mng altered.

desc emp_mng;
Name           Null     Type         
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)     --pk
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)    

ALTER TABLE dept_mng 
ADD CONSTRAINT pk_dept_mng PRIMARY KEY(department_id); 
--table DEPT_mng altered.
desc dept_mng;
Name            Null     Type         
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)     --pk
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4) 

ALTER TABLE emp_mng
ADD CONSTRAINT fk_emp_dept_mng FOREIGN KEY(department_id) REFERENCES dept_mng(department_id);
--table EMP_mng altered.

--Suplimentar:
alter table emp_mng
drop constraint FK_EMP_DEPT_mng;

alter table dept_mng
drop constraint PK_DEPT_mng;
--cheie externa: ORA-02270: nu exista chei primare sau unice potrivite pentru aceasta lista-coloana

--ce contrangeri avem pe o tabela
select *
from user_constraints
where lower(table_name) = 'emp_mng';

select *
from user_constraints
where lower(table_name) = 'dept_mng';

--pe ce coloane sumt setate constrangerile
select *
 from user_cons_columns
 where lower(table_name) = 'dept_mng';

select *
 from user_cons_columns
 where lower(table_name) = 'emp_mng';
 
Observa?ie: Ce constr�ngere nu am implementat?
--manager_id
commit;

5. S� se insereze departamentul 300, cu numele Programare �n DEPT_mng.
Analiza�i cazurile, preciz�nd care este solu�ia corect� �i explic�nd erorile celorlalte variante. 
Pentru a anula efectul instruc�iunii(ilor) corecte, utiliza�i comanda ROLLBACK.

describe dept_mng;

Name            Null     Type         
--------------- -------- ------------ 
DEPARTMENT_ID   NOT NULL NUMBER(4)    
DEPARTMENT_NAME NOT NULL VARCHAR2(30) 
MANAGER_ID               NUMBER(6)    
LOCATION_ID              NUMBER(4)   
a)
INSERT INTO DEPT_mng
VALUES (300, 'Programare');
--ORA-00947: valori prea putine
--corect
INSERT INTO DEPT_mng
VALUES (300, 'Programare',null, null );

b)
INSERT INTO DEPT_mng (department_id, department_name)
VALUES (300, 'Programare');
--1 rows inserted.
select * from dept_mng where department_id =300;
--300	Programare null null 
--s-a pus null implicit pt colonale care lipseau din lista de coloane  --INSERT INTO DEPT_mng (department_id, department_name)
--incerc sa mai rulez inca odata insert-ul => eroare: ORA-00001: restrictia unica (GRUPA33.PK_DEPT_mng) nu este respectata
--(avem cheia primara setata pe tabelul dept)
rollback;
select * from dept_mng; --27 rez

c) 
INSERT INTO DEPT_mng (department_name, department_id)
VALUES (300, 'Programare'); 
--Programare --ORA-01722: numar nevalid

--corect
INSERT INTO DEPT_mng (department_name, department_id)
VALUES ( 'Programare', 300); 
d)
INSERT INTO DEPT_mng (department_id, department_name, location_id)
VALUES (300, 'Programare', null);
--1 rows inserted
--explicit pun null pt location_id
--implicit sa puna null pt manager_id
select * from dept_mng where department_id =300;
--300	Programare	null null
rollback;
e) 
INSERT INTO DEPT_mng (department_name, location_id)
VALUES ('Programare', null);
--ORA-01400: nu poate fi inserat NULL �n ("GRUPA33"."DEPT_mng"."DEPARTMENT_ID")

Executa�i varianta care a fost corect� de dou� ori. Ce se ob�ine �i de ce?
--avem chia primara setata


6. S� se insereze un angajat corespunz�tor departamentului introdus anterior �n tabelul EMP_mng,
preciz�nd valoarea NULL pentru coloanele a c�ror valoare nu este cunoscut� la inserare 
(metoda implicit� de inserare). Determina�i ca efectele instruc�iunii s� devin� permanente.
Aten�ie la constr�ngerile NOT NULL asupra coloanelor tabelului!

commit;
--id ang 252

describe emp_mng;

Name           Null     Type         
-------------- -------- ------------ 
EMPLOYEE_ID    NOT NULL NUMBER(6)    
FIRST_NAME              VARCHAR2(20) 
LAST_NAME      NOT NULL VARCHAR2(25) 
EMAIL          NOT NULL VARCHAR2(25) 
PHONE_NUMBER            VARCHAR2(20) 
HIRE_DATE      NOT NULL DATE         
JOB_ID         NOT NULL VARCHAR2(10) 
SALARY                  NUMBER(8,2)  
COMMISSION_PCT          NUMBER(2,2)  
MANAGER_ID              NUMBER(6)    
DEPARTMENT_ID           NUMBER(4)   

insert into emp_mng
values (252, null, 'Ozunu', 'natalia@gmail.com', null, sysdate, 'test_job', null, null, null, 300); --null explicit
--test_job -- nu am setat cehia externa catre tabela de jobs
ROLLBACK;
commit;

--stergem angajatul 252
delete from emp_mng
where employee_id =252;

select * from emp_mng
where employee_id =252;

--insert 252 + ROLLBACK => se sterge angajatul 252
--insert 252 + commit; Daca dam ROLLBACK, nu se sterge angajatul 252
--La final facem Insert 252 + commit

7. S� se mai introduc� un angajat corespunz�tor departamentului 300, preciz�nd dup� numele
tabelului lista coloanelor �n care se introduc valori (metoda explicit� de inserare). 
Se presupune c� data angaj�rii acestuia este cea curent� (SYSDATE). Salva�i �nregistrarea.

insert into emp_mng (employee_id, first_name, last_name, email, phone_number, hire_date, job_id,
                      salary, commission_pct, manager_id, department_id)
values (253, null, 'Ozunu', 'natalia@gmail.com', null, sysdate, 'test_job', null, null, null, 300); --null explicit

insert into emp_mng (employee_id, last_name, email,  hire_date, job_id,
                        department_id)
values (254, 'Ozunu', 'natalia@gmail.com', sysdate, 'test_job', 300); --null implicit


select * from emp_mng
where employee_id in (252, 253, 254);
rollback;

commit;
----Am facut Insert 252 + commit +rollback => a ramas doar angajatul 252
----Am facut Insert 252 + commit + Inseram 253, 254 + rollback => a ramas doar angajatul 252

----Am facut Insert 252 + commit + Inseram 253, 254 + commit + rollback 
      -- => In emp_mng se gasesc toti cei 3 ang: 252, 253, 254

--atentie la departament
insert into emp_mng (employee_id, last_name, email,  hire_date, job_id,
                        department_id)
values (255, 'Ozunu', 'natalia@gmail.com', sysdate, 'test_job', 600); 
--ORA-02291: constr�ngere de integritate (GRUPA33.FK_EMP_DEPT_mng) violata - cheia parinte negasita
--departamentul 600 nu exista
commit;

10. Crea�i un nou tabel, numit EMP1_mng, care va avea aceea�i structur� ca �i EMPLOYEES, dar nicio �nregistrare. 
Copia�i �n tabelul EMP1_mng salaria�ii (din tabelul EMPLOYEES) al c�ror comision dep�e�te 25% din salariu. 
 
--V1: Crea�i un nou tabel, numit EMP1_mng, care va avea aceea�i structur� ca �i EMPLOYEES, dar nicio �nregistrare. 
CREATE TABLE emp1_mng AS SELECT * FROM employees WHERE 1=0;

select * from emp1_mng; --0 rez

--stergem tabelul emp1
drop table emp1_mng;

--V2: Crea�i un nou tabel, numit EMP1_mng, care va avea aceea�i structur� ca �i EMPLOYEES, dar nicio �nregistrare. 
CREATE TABLE emp1_mng AS SELECT * FROM employees; --commit implicit
select * from emp1_mng; --107 rez
DELETE FROM emp1_mng; --necesar daca nu aveam clauza WHERE de mai sus
--107 rows deleted.
select * from emp1_mng; --0 rez

--salaria�ii (din tabelul EMPLOYEES) al c�ror comision dep�e�te 25% din salariu. 
SELECT * FROM employees WHERE commission_pct > 0.25; --11 rez

--Copia�i �n tabelul EMP1_mng salaria�ii (din tabelul EMPLOYEES) al c�ror comision dep�e�te 25% din salariu.
INSERT INTO emp1_mng 
SELECT * FROM employees WHERE commission_pct > 0.25; 
--11 rows inserted.

INSERT INTO emp1_mng (employee_id, last_name, email,  hire_date, job_id, department_id)
SELECT employee_id, last_name, email,  hire_date, job_id, department_id 
FROM employees WHERE commission_pct > 0.25;  --implicit valori de null pt restul coloanelor
--11 rows inserted

SELECT employee_id, last_name, salary, commission_pct FROM emp1_mng; --22 rez

Ce va con?ine tabelul EMP1_mng �n urma acestei succesiuni de comenzi?
ROLLBACK;

SELECT employee_id, last_name, salary, commission_pct FROM emp1_mng; --107 rez (tabel creat cu a doua varianta)

SELECT employee_id, last_name, salary, commission_pct FROM emp1_mng; --0 rez (tabel creat prin varianta 1)

desc emp1_mng;

drop table emp1_mng;

-- daca datele nu sunt corecte in tabelul emp_mng( le suprascriu cu cele din employees, atentie la 252, 253, 254)
update emp_na e
set e.salary = (select a.salary
                from employees a
                where a.employee_id = e.employee_id);
commit;
--UPDATE
15. M�ri�i salariul tuturor angaja�ilor din tabelul EMP_PNU cu 5%. Vizualiza?i, iar apoi anula�i modific�rile.

select employee_id, salary
from emp_mng;
100	24000
101	17000
102	17000
103	9000
rollback;

update emp_mng
set salary = salary + 0.05*salary; --110 rows updated. 107+3 ang noi
--set salary =  salary *1.05
select employee_id, salary
from emp_mng;
100	25200
101	17850
102	17850
103	9450
253	null
252	null
254	null

--luam in considerare ca avem si salary = null
update emp_mng
set salary = nvl(salary + 0.05*salary, 0); --110 rows updated. 107+3 ang noi
100	26460
101	18742,5
102	18742,5
103	9922,5
253	0
252	0
254	0

select null+1, 2*null
from dual; --null null

rollback; --revenim la valorile initiale
100	24000
101	17000
102	17000
103	9000

16. Schimba�i jobul tuturor salaria�ilor din departamentul 80 care au comision �n 'SA_REP'. Anula�i modific�rile.

--salaria�ii din departamentul 80 care au comision
select employee_id, department_id,commission_pct, job_id
from emp_mng
where department_id =80
and commission_pct is not null; --34 rez

145	80	0,4	SA_MAN
146	80	0,3	SA_MAN
147	80	0,3	SA_MAN

--rezolvarea:
update emp_mng
set job_id = 'SA_REP'
where department_id =80
and commission_pct is not null; --34 rows updated.

select employee_id, department_id,commission_pct, job_id from emp_mng
where department_id =80
and commission_pct is not null;

145	80	0,4	SA_REP
146	80	0,3	SA_REP
147	80	0,3	SA_REP
 rollback;
 
 -- --Lab 8
17. S� se promoveze Douglas Grant la func?ia de manager �n departamentul 20, 
av�nd o cre�tere de salariu de 1000. Se poate realiza modificarea prin 
intermediul unei singure comenzi?

select employee_id, salary
from emp_mng
where lower(first_name) = 'douglas'
and lower(last_name) = 'grant'; --199 2600

select manager_id
from dept_mng
where department_id =20; --201 
--initial mang pt dept 20 era 201, dupa update va fi 199

UPDATE nume_tabel [alias]
SET (col1,col2,...) = (subcerere)
[WHERE conditie];

update dept_mng
set manager_id = (select employee_id
                  from emp_mng
                  where lower(first_name) = 'douglas'
                  and lower(last_name) = 'grant')
where department_id =20;
 
 
update emp_mng
set salary = salary+1000
where employee_id = (select employee_id
                  from emp_mng
                  where lower(first_name) = 'douglas'
                  and lower(last_name) = 'grant');
 --199	3600                  
 --sau
update emp_mng
set salary = salary+1000
where lower(first_name) = 'douglas'
and lower(last_name) = 'grant';                 
-- 199	4600

 rollback;
 

 VIII. [Exerci?ii � DELETE]
20. �terge�i toate �nregistr�rile din tabelul DEPT_PNU. Ce �nregistr�ri se pot �terge? Anula�i modific�rile.

delete from dept_mng;
--SQL Error: ORA-02292: constr�ngerea de integritate (GRUPA33.FK_EMP_DEPT_mng) violata - gasita �nregistrarea copil
--02292. 00000 - "integrity constraint (%s.%s) violated - child record found"

22. Suprima�i departamentele care un au nici un angajat. Anula�i modific�rile.
 --v1
 --care sunt departamentele la care nu lucreaza niciun angajat?
 select department_id
 from dept_mng
 minus
 select distinct department_id  --lista departamenteor in care lucreaza angajati
 from emp_mng
 where department_id is not null; --16 dept
 
select department_id
 from dept_mng 
 where department_id not in (select distinct department_id  --lista departamenteor in care lucreaza angajati
                             from emp_mng
                             where department_id is not null);
 
 delete from dept_mng
 where department_id in ( select department_id
                           from dept_mng
                           minus
                           select department_id 
                           from emp_mng
                           where department_id is not null); --16 rows deleted.
  select * from dept_mng; --12 rez  
  rollback;
 --28 de dept in dept_mng
 
 --v2
 --stergem departamnele care nu se gasesc in lista de departamente in care LUCREZA angajati
 delete from dept_mng
 where department_id not in (select department_id 
                           from emp_mng
                           where department_id is not null); --16 rows deleted.
  rollback;                         

21. �terge�i angaja�ii care nu au comision. Anula�i modific�rile.

delete from emp_mng
where commission_pct is null; --75 rows deleted.

select * from emp_mng; --au ramas 35 ang
rollback;

 IX. [Exerci?ii � LMD, LCD]
23. S� se �tearg� un angajat din tabelul EMP_PNU. Modific�rile vor deveni permanente.

--stergeti angajatul 254
delete from emp_mng
where employee_id =254; --1 rows deleted.
commit;

select * from emp_mng; --109 ang

--select count(*)
--from emp_mng; --109 ang

24. S� se mai introduc� o linie in tabel.

insert into emp_mng (employee_id, last_name, email,  hire_date, job_id,
                        department_id)
values (255, 'Ozunu', 'natalia@gmail.com', sysdate, 'test_job', 300); --null implicit

25. S� se marcheze un punct intermediar in procesarea tranzac�iei.
SAVEPOINT acum;

26. S� se �tearg� tot con�inutul tabelului. Lista�i con�inutul tabelului.
delete from emp_mng; --110 rows deleted.

27. S� se renun�e la cea mai recent� opera�ie de �tergere, f�r� a renun�a la opera�ia precedent� de introducere.
ROLLBACK; --anuleaza atata delete+ insert 255
rollback to acum; --am anulat doar delete
28. Lista�i con�inutul tabelului. Determina�i ca modific�rile s� devin� permanente.
select * from emp_mng; --110 ang : 252, 253, 255
 commit;
 
 
 
 
 
 