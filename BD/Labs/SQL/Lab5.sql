IV. [Exerci?ii – definire tabele]
1. Sã se creeze tabelul ANGAJATI_mng (pnu se alcatuieºte din prima literã din prenume ºi primele douã din numele studentului) corespunzãtor schemei relaþionale:
ANGAJATI_mng(cod_ang number(4), nume varchar2(20), prenume varchar2(20), email char(15), data_ang date, job varchar2(10), cod_sef number(4), salariu number(8, 2), cod_dep number(2))
în urmãtoarele moduri:
Se presupune cã valoarea implicitã a coloanei data_ang este SYSDATE.
Observa?ie: Nu pot exista douã tabele cu acelaºi nume în cadrul unei scheme, deci recrearea unui tabel va fi precedatã de suprimarea sa prin comanda:
DROP TABLE ANGAJATI_mng;

a) fãrã precizarea vreunei chei sau constrângeri;

create table ANGAJATI_mng(
  cod_ang number(4), 
  nume varchar2(20), 
  prenume varchar2(20), 
  email char(15), 
  data_ang date, 
  job varchar2(10), 
  cod_sef number(4), 
  salariu number(8, 2), 
  cod_dep number(2)); --table ANGAJATI_mng created.
  
  select * from angajati_mng; --0 rez
  drop table angajati_mng; --table ANGAJATI_mng dropped.
  
b) cu precizarea cheilor primare la nivel de coloanã ?i a constrângerilor NOT NULL pentru coloanele nume ºi salariu;
create table ANGAJATI_mng(
  cod_ang number(4) primary key, 
  nume varchar2(20) not null, 
  prenume varchar2(20), 
  email char(15), 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4), 
  salariu number(8, 2) not null, 
  cod_dep number(2));
    
SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('angajati_mng');
--SYS_C00527493	C	ANGAJATI_mng
--SYS_C00527492	C	ANGAJATI_mng
--SYS_C00527494	P	ANGAJATI_mng  
 drop table angajati_mng;
--v2
create table ANGAJATI_mng(
  cod_ang number(4) constraint pk_ang_mng primary key, 
  nume varchar2(20) constraint null_nume_mng not null, 
  prenume varchar2(20), 
  email char(15), 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4), 
  salariu number(8, 2) not null, 
  cod_dep number(2));
  
--SYS_C00527502	C	ANGAJATI_mng --salariu
--NULL_NUME_mng	C	ANGAJATI_mng --nume
--PK_ANG_mng	P	ANGAJATI_mng  ---cod_ang



c) cu precizarea cheii primare la nivel de tabel ?i a constrângerilor NOT NULL pentru coloanele nume ºi salariu.
  drop table angajati_mng;
create table ANGAJATI_mng(
  cod_ang number(4), 
  nume varchar2(20) constraint null_nume_mng not null, 
  prenume varchar2(20), 
  email char(15), 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4), 
  salariu number(8, 2) constraint null_salariu_mng not null, 
  cod_dep number(2),
  constraint pk_ang_mng primary key(cod_ang)
  );
  
  select * from angajati_mng;
  SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('angajati_mng');
  Observa?ie: Tipul constrângerilor este marcat prin:
• P – pentru cheie primarã
• R – pentru constrângerea de integritate referenþialã (cheie externã);
• U – pentru constrângerea de unicitate (UNIQUE);
• C – pentru constrângerile de tip CHECK.

--NULL_SALARIU_mng	C	ANGAJATI_mng
--NULL_NUME_mng	C	ANGAJATI_mng
--PK_ANG_mng	P	ANGAJATI_mng

2.	Ad?uga?i urm?toarele înregistr?ri în tabelul ANGAJATI_***:

Cod_ang	Nume	Prenume	Email	Data_ang	Job	Cod_sef	Salariu	Cod_dep
100	Nume1	Prenume1	Null	Null	Director	null	20000	10
101	Nume2	Prenume2	Nume2	02-02-2004	Inginer	100	10000	10
102	Nume3	Prenume3	Nume3	05-06-2004	Analist	101	5000	20
103	Nume4	Prenume4	Null	Null	Inginer	100	9000	20
104	Nume5	Prenume5	Nume5	Null	Analist	101	3000	30
Prima si a patra înregistrare vor fi introduse specificând coloanele pentru care 
introduce?i date efectiv, iar celelalte vor fi inserate f?r? precizarea coloanelor în comanda INSERT.
Salva?i comenzile de inserare.

insert into angajati_mng(Cod_ang,	Nume	,Prenume,	Email,	Data_ang	,Job,	Cod_sef,	Salariu,	Cod_dep)
values( 100	,'Nume1',	'Prenume1',	Null	,Null,	'Director',	null,	20000	,10);
select * from angajati_mng;

insert into angajati_mng
values (101, 	'Nume2',	'Prenume2',	'Nume2@gmail.com', to_date(	'02-02-2004', 'dd-mm-yyyy'), 	'Inginer',	100,	10000	,10);

insert into angajati_mng
values (102, 'Nume3', 'Prenume3', 'Nume3@gmail.com', to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist', 101, 5000, 20);

insert into angajati_mng (Cod_ang, Nume, Prenume, Job, Cod_sef, Salariu, Cod_dep)
values (103, 'Nume4', 'Prenume4', 'Inginer', 100, 9000, 20);
--atentie la data de angajare a lui 103 

insert into angajati_mng
values (104, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30);

select * from angajati_mng;
commit;

3. Creaþi tabelul ANGAJATI10_mng, prin copierea angajaþilor din departamentul 10 
din tabelul ANGAJATI_mng. Listaþi structura noului tabel. Ce se observã?

create table angajati10_mng as
  Select * from angajati_mng where cod_dep =10;
  
  select * from angajati10_mng; --2 rez
  
  
SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('angajati10_mng');
--SYS_C00527544	C	ANGAJATI10_mng
--SYS_C00527543	C	ANGAJATI10_mng
--doar contrangerile de not null peste coloanele nume si salriu au fost copiate
desc angajati10_mng;
Name     Null     Type         
-------- -------- ------------ 
COD_ANG           NUMBER(4)    --lipseste pk
NUME     NOT NULL VARCHAR2(20) 
PRENUME           VARCHAR2(20) 
EMAIL             CHAR(15)     
DATA_ANG          DATE         
JOB               VARCHAR2(10) 
COD_SEF           NUMBER(4)    
SALARIU  NOT NULL NUMBER(8,2)  
COD_DEP           NUMBER(2)    

desc angajati_mng;

Name     Null     Type         
-------- -------- ------------ 
COD_ANG  NOT NULL NUMBER(4)    --este setata PK
NUME     NOT NULL VARCHAR2(20) 
PRENUME           VARCHAR2(20) 
EMAIL             CHAR(15)     
DATA_ANG          DATE         
JOB               VARCHAR2(10) 
COD_SEF           NUMBER(4)    
SALARIU  NOT NULL NUMBER(8,2)  
COD_DEP           NUMBER(2) 
----------------------------------------------------------------------------

drop table angajati10_mng;

4. Introduceti coloana comision in tabelul ANGAJATI_mng. Coloana va avea tipul de date NUMBER(4,2).

alter table angajati_mng
add (comision number(4,2));

select * from angajati_mng;

5. Este posibilã modificarea tipului coloanei comision în NUMBER(6,2)?
alter table angajati_mng
modify (comision number(6,2));

--apoi pot sa micsorez?
alter table angajati_mng
modify (comision number(4,2));
--table ANGAJATI_mng altered. (toate infomatiiile din coloana comision sunt nule)

select * from angajati_mng;
5" .	Este posibil? modificarea tipului coloanei salariu în NUMBER(6,2)?
--SALARIU  NOT NULL NUMBER(8,2) 
alter table angajati_mng
modify (salariu number(6,2));
--SQL Error: ORA-01440: coloana de modificat trebuie sa fie goala pentru a micsora precizia sau scala
------------------------------------------------------------------------------------------------
6. Setaþi o valoare DEFAULT pentru coloana salariu.

alter table angajati_mng
modify(salariu default 1111);

insert into angajati_mng (Cod_ang, Nume, Prenume, Job, Cod_sef, Cod_dep) --lipseste salariul 
values (105, 'Nume6', 'Prenume6', 'Inginer', 100, 20);

insert into angajati_mng (Cod_ang, Nume, Prenume, Job, Cod_sef, Cod_dep, salariu)
values (106, 'Num76', 'Prenume76', 'Inginer', 100, 20, 2222);

select * from angajati_mng;
--105	Nume6	Prenume6		14-04-2021	Inginer	100	1111	20	
-- 106	Num76	Prenume76		14-04-2021	Inginer	100	2222	20	

7. Modificaþi tipul coloanei comision în NUMBER(2, 2) ºi al coloanei salariu în NUMBER(10,2), 
în cadrul aceleiaºi instrucþiuni.
desc angajati_mng;

--inainte
SALARIU  NOT NULL NUMBER(8,2)  
COD_DEP           NUMBER(2)    
COMISION          NUMBER(4,2)  

alter table angajati_mng
modify ( salariu number(10,2),
          comision number(2,2)
          );

--dupa: 
SALARIU  NOT NULL NUMBER(10,2) 
COD_DEP           NUMBER(2)    
COMISION          NUMBER(2,2)           

8. Actualiza?i valoarea coloanei comision, setând-o la valoarea 0.1 pentru 
salariaþii al cãror job începe cu litera I. (UPDATE)
select * from angajati_mng;

update angajati_mng
set comision=0.1
where lower(job)  like 'i%';

select * from angajati_mng;

12. Redenumiþi tabelul ANGAJATI_mng în ANGAJATI3_mng.
rename angajati_mng to angajati3_mng; 
--angajati_mng TO succeeded.
select * from angajati_mng; --ORA-00942: tabelul sau vizualizarea nu exista
select * from angajati3_mng; 

13. Consultaþi vizualizarea TAB din dicþionarul datelor. Redenumiþi angajati3_mng în angajati_mng.
select * from tab;
rename angajati3_mng to angajati_mng;
select * from angajati_mng;
select * from angajati3_mng;  --ORA-00942: tabelul sau vizualizarea nu exista

14. Suprimaþi conþinutul tabelului angajati10_mng, fãrã a suprima structura acestuia.

create table angajati10_mng as
  Select * from angajati_mng where cod_dep =10;
  
  select * from angajati10_mng;
  
  delete from angajati10_mng; --tabela goala
  rollback; --avem cele 2 inregistrari
  
  truncate table angajati10_mng; --se pastreaza structura tabelei (DELETE+COMMIT)
  rollback; -- in continuare tabela este goala
  
  drop table angajati10_mng;
  select * from angajati10_mng; --ORA-00942: tabelul sau vizualizarea nu exista
  
15. Creaþi tabelul DEPARTAMENTE_mng, corespunzãtor schemei relaþionale:
DEPARTAMENTE_mng (cod_dep# number(2), nume varchar2(15), cod_director number(4))
specificând doar constrângerea NOT NULL pentru nume (nu precizaþi deocamdatã constrângerea de cheie primarã). 

CREATE TABLE departamente_mng 
(cod_dep number(2), 
nume varchar2(15) constraint NL_nume_mng NOT NULL, 
cod_director number(4)); 

DESC departamente_mng;

Name         Null     Type         
------------ -------- ------------ 
COD_DEP               NUMBER(2)    
NUME         NOT NULL VARCHAR2(15) 
COD_DIRECTOR          NUMBER(4)   

16. Introduceþi urmãtoarele înregistrãri în tabelul DEPARTAMENTE_pnu:
Cod_dep	Nume	Cod_director
10	Administrativ	100
20	Proiectare	101
30	Programare	Null

insert into departamente_mng
values(10,	'Administrativ',	100);
insert into departamente_mng
values(20, 'Proiectare',	101);
insert into departamente_mng
values(30,	'Programare',	Null);
--atentie
insert into departamente_mng
values(30,	'DE_STERS',	Null);

alter table departamente_mng
add constraint pk_depart_mng primary key (cod_dep); 
SQL Error: ORA-02437: (GRUPA32.PK_DEPART_MNG) nu a putut fi validata - cheia primara a fost violata

delete from departamente_mng
where nume = 'DE_STERS'; --1 rows deleted.

select * from departamente_mng;
commit;

17. Introduce?i constângerea de cheie primarã asupra coloanei cod_dep, fãrã suprimarea ºi recrearea tabelului 
(comanda ALTER).
Observa?ie:
o Introducerea unei constrângeri dupã crearea tabelului presupune cã toate liniile existente în tabel la 
momentul respectiv satisfac noua constrângere.
o Specificarea constrângerilor permite numirea acestora.
o In situaþia in care constrângerile sunt precizate la nivel de coloanã sau tabel 
(în CREATE TABLE) ele vor primi implicit nume atribuite de sistem, dacã nu se specificã vreun alt nume 
într-o clauzã CONSTRAINT.
Exemplu : CREATE TABLE alfa (
X NUMBER CONSTRAINT nn_x NOT NULL,
Y VARCHAR2 (10) NOT NULL
);

alter table departamente_mng  --PK = Unique + NOT NULL
add constraint pk_depart_mng primary key (cod_director);
--SQL Error: ORA-01449: coloana contine valori NULL; nu se poate modifica în NOT NULL

alter table departamente_mng
add constraint pk_dep_mng primary key (cod_dep); 
--SQL Error: ORA-02264: nume folosit deja de o constrângere existenta

alter table departamente_mng
add constraint pk_depart_mng primary key (cod_dep); 
--table DEPARTAMENTE_mng altered.

alter table departamente_mng
drop constraint pk_depart_mng;

18. Sã se precizeze constrângerea de cheie externã pentru coloana cod_dep din ANGAJATI_pnu:
a) fãrã suprimarea tabelului (ALTER TABLE);

alter table angajati_mng
add constraint fk_ang_depart_mng foreign key(cod_dep) references departamente_mng(cod_dep);

SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) = 'angajati_mng';

NULL_SALARIU_mng	C	ANGAJATI_mng
NULL_NUME_mng	C	ANGAJATI_mng
FK_ANG_DEPART_mng	R	ANGAJATI_mng --FK
PK_ANG_mng	P	ANGAJATI_mng  --PK

b) prin suprimarea ºi recrearea tabelului, cu precizarea noii constrângeri la nivel de coloanã 
({DROP, CREATE} TABLE). De asemenea, se vor mai preciza constrângerile (la nivel de coloanã, 
în mãsura în care este posibil):
- PRIMARY KEY pentru cod_ang;
- FOREIGN KEY pentru cod_sef;
- UNIQUE pentru combinaþia nume + prenume;
- UNIQUE pentru email;
- NOT NULL pentru nume;
- verificarea cod_dep > 0;
- verificarea ca salariul sã fie mai mare decât comisionul*100.

--drop table departamente_mng; --SQL Error: ORA-02449: cheile unice/primare din tabela sunt referite de cheile externe

drop table angajati_mng; --table ANGAJATI_mng dropped.

create table ANGAJATI_mng(
  cod_ang number(4) constraint pk_ang_mng primary key, 
  nume varchar2(20) constraint null_nume_mng not null, 
  prenume varchar2(20), 
  email char(15) constraint unq_email_mng unique, 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4) constraint fk_ang_ang_mng references angajati_mng(cod_ang), 
  salariu number(8, 2),
  cod_dep number(2) constraint ck_cod_dep_mng check(cod_dep>0), 
  comision number(4,2),
  constraint unq_nume_pren_mng unique(nume, prenume),
  constraint ck_sal_com_mng check( salariu>comision *100),
  constraint fk_ang_depart_mng foreign key(cod_dep) references departamente_mng(cod_dep)
    );


create table ANGAJATI_ (
  cod_ang number(4) constraint pk_ang_   primary key, 
  nume varchar2(20) constraint null_nume_    not null, 
  prenume varchar2(20), 
  email char(15) constraint unq_email_   unique, 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4) constraint fk_ang_ang_   references angajati_  (cod_ang), 
  salariu number(8, 2),
  cod_dep number(2) constraint ck_cod_dep_   check(cod_dep>0),
  comision number(4,2),
  constraint unq_nume_pren_    unique(nume, prenume),
  constraint ck_sal_com_    check( salariu>comision *100),
  constraint fk_ang_depart_ foreign key(cod_dep) references departamente_ (cod_dep)
    );
SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('angajati_mng');

CK_SAL_COM_mng	C	ANGAJATI_mng
CK_COD_DEP_mng	C	ANGAJATI_mng
NULL_NUME_mng	C	ANGAJATI_mng
FK_ANG_DEPART_MNG	R	ANGAJATI_MNG
FK_ANG_ANG_mng	R	ANGAJATI_mng
UNQ_NUME_PREN_mng	U	ANGAJATI_mng
UNQ_EMAIL_mng	U	ANGAJATI_mng
PK_ANG_mng	P	ANGAJATI_mng

19. Suprimaþi ºi recreaþi tabelul, specificând toate constrângerile la nivel de tabel 
(în mãsura în care este posibil).
/
--
drop table angajati_mng;

create table ANGAJATI_mng(
  cod_ang number(4) , 
  nume varchar2(20) constraint null_nume_mng not null, 
  prenume varchar2(20), 
  email char(15) , 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4) , 
  salariu number(8, 2),
  cod_dep number(2) ,
  comision number(4,2),
  constraint unq_nume_pren_mng unique(nume, prenume),
  constraint ck_sal_com_mng check(salariu>comision *100),
  constraint pk_ang_mng primary key(cod_ang),
  constraint unq_email_mng unique(email),
  constraint fk_ang_ang_mng foreign key(cod_sef) references angajati_mng(cod_ang),
  constraint ck_cod_dep_mng check(cod_dep>0),
  constraint fk_depart_mng foreign key(cod_dep) references departamente_mng(cod_dep)  
    );
    
    drop table ANGAJATI_mng;

create table ANGAJATI_  (
  cod_ang number(4) , 
  nume varchar2(20) constraint null_nume_   not null, 
  prenume varchar2(20), 
  email char(15) , 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4) , 
  salariu number(8, 2),
  cod_dep number(2) ,
  comision number(4,2),
  constraint unq_nume_pren_   unique(nume, prenume),
  constraint ck_sal_com_  check(salariu>comision *100),
  constraint pk_ang_   primary key(cod_ang),
  constraint unq_email_  unique(email),
  constraint fk_ang_ang_  foreign key(cod_sef) references angajati_ (cod_ang),
  constraint ck_cod_dep_  check(cod_dep>0),
  constraint fk_depart_  foreign key(cod_dep) references departamente_ (cod_dep)  
    );

  SELECT * FROM USER_CONSTRAINTS WHERE lower(TABLE_NAME) = 'angajati_mng';

CK_COD_DEP_mng	C
CK_SAL_COM_mng	C
NULL_NUME_mng	C
FK_DEPART_mng	R
FK_ANG_ANG_mng	R
UNQ_EMAIL_mng	U
UNQ_NUME_PREN_mng	U
PK_ANG_mng	P

insert into angajati_mng(Cod_ang,	Nume	,Prenume,	Email,	Data_ang	,Job,	Cod_sef,	Salariu,	Cod_dep)
values( 100	,'Nume1',	'Prenume1',	Null	,Null,	'Director',	null,	20000	,10);
select * from angajati_mng;

insert into angajati_mng
values (101, 	'Nume2',	'Prenume2',	'Nume2@gmail.com', to_date(	'02-02-2004', 'dd-mm-yyyy'), 	'Inginer',	100,	10000	,10, 0.1);

insert into angajati_mng
values (102, 'Nume3', 'Prenume3', 'Nume3@gmail.com', to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist', 101, 5000, 20, null);

insert into angajati_mng (Cod_ang, Nume, Prenume, Job, Cod_sef, Salariu, Cod_dep)
values (103, 'Nume4', 'Prenume4', 'Inginer', 100, 9000, 20);
--atentie la data de angajare a lui 103 

insert into angajati_mng
values (104, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);

select * from angajati_mng;
commit;

delete from angajati_mng;
rollback;
-----
insert into angajati_(Cod_ang, Nume ,Prenume, Email, Data_ang ,Job, Cod_sef, Salariu, Cod_dep)
values( 100 ,'Nume1', 'Prenume1', Null ,Null, 'Director', null, 20000 ,10);
select * from angajati_mng;
insert into angajati_
values (101, 'Nume2', 'Prenume2', 'Nume2@gmail.com', to_date( '02-02-2004', 'dd-mm-yyyy'), 'Inginer', 100, 10000 ,10, 0.1);
insert into angajati_
values (102, 'Nume3', 'Prenume3', 'Nume3@gmail.com', to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist', 101, 5000, 20, null);
insert into angajati_ (Cod_ang, Nume, Prenume, Job, Cod_sef, Salariu, Cod_dep)
values (103, 'Nume4', 'Prenume4', 'Inginer', 100, 9000, 20);
--atentie la data de angajare a lui 103
insert into angajati_
values (104, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);
-----------
commit;

25. (Încercaþi sã) adãugaþi o nouã înregistrare în tabelul ANGAJATI_pnu, care sã corespundã codului
de departament 50. Se poate?

insert into angajati_mng
values (105, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);
--SQL Error: ORA-00001: restrictia unica (GRUPA34.UNQ_NUME_PREN_mng) nu este respectata

insert into angajati_mng
values (105, 'Nume6', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);
--SQL Error: ORA-00001: restrictia unica (GRUPA34.UNQ_EMAIL_mng) nu este respectata

insert into angajati_mng
values (105, 'Nume6', 'Prenume6', 'Nume6@gmail.com', Null, 'Analist', 101, 3000, 50, 0.2);
SQL Error: ORA-02291: constrângere de integritate (GRUPA33.FK_DEPART_mng) violata - cheia parinte negasita
--dept 50 nu exista in lista de departamente

29. (Încercaþi sã) introduceþi un nou angajat, specificând valoarea 114 pentru cod_sef. Ce se obþine?

insert into angajati_mng
values (105, 'Nume6', 'Prenume6', 'Nume6@gmail.com', null, 'Analist', 114, 3000, 20, 0.2);

SQL Error: ORA-02291: constrângere de integritate (GRUPA33.FK_ANG_ANG_mng) violata - cheia parinte negasita

--angajatul 114 nu exista in baza de date
30. Adãugaþi un nou angajat, având codul 114. Încercaþi din nou introducerea înregistrãrii de la exerciþiul 29.

insert into angajati_mng
values (114, 'Nume7', 'Prenume7', 'Nume7@gmail.com', null, 'Analist', 100, 3000, 20, 0.2); --1 rows inserted.

insert into angajati_mng
values (105, 'Nume6', 'Prenume6', 'Nume6@gmail.com', null, 'Analist', 114, 3000, 20, 0.2); --1 rows inserted.

select * from angajati_mng;

21. Ce se întâmplã dacã se încearcã suprimarea tabelului departamente_pnu?

drop table departamente_mng; 
--SQL Error: ORA-02449: cheile unice/primare din tabela sunt referite de cheile externe
truncate table departamente_mng; 
--SQL Error: ORA-02266: cheile unice/primare din tabela sunt referite de cheile externe activate
delete from departamente_mng; 
--SQL Error: ORA-02292: constrângerea de integritate (GRUPA33.FK_DEPART_mng) violata - gasita înregistrarea copil

26. Adãugaþi un nou departament, cu numele Testare, codul 60 ºi directorul null în DEPARTAMENTE_pnu. COMMIT.
insert into departamente_mng
values(60,	'Testare',	null); --1 rows inserted.
commit;

27. (Încercaþi sã) ºtergeþi departamentul 20 din tabelul DEPARTAMENTE_pnu. Comentaþi.
delete from departamente_mng
where cod_dep =20;
--SQL Error: ORA-02292: constrângerea de integritate (GRUPA34.FK_DEPART_mng) violata - gasita înregistrarea copil
--lucreaza angajati in dept 20
select * from angajati_mng
where cod_dep =20;

28. ªtergeþi departamentul 60 din DEPARTAMENTE_pnu. ROLLBACK.

select * from departamente_mng;
delete from departamente_mng
where cod_dep =60; --1 rows deleted.

31. Se doreºte ºtergerea automatã a angajaþilor dintr-un departament, odatã cu suprimarea departamentului.
Pentru aceasta, este necesarã introducerea clauzei ON DELETE CASCADE în definirea constrângerii de cheie externã.
Suprimaþi constrângerea de cheie externã asupra tabelului ANGAJATI_pnu ºi reintroduceþi aceastã constrângere, 
specificând clauza ON DELETE CASCADE.

alter table angajati_mng
drop constraint fk_depart_mng;
--table ANGAJATI_mng altered.

alter table angajati_mng
add constraint fk_depart_mng2 foreign key(cod_dep) references departamente_mng(cod_dep) on delete cascade;
---
alter table angajati_
drop constraint fk_depart_ ;
alter table angajati_
add constraint fk_depart_ foreign key(cod_dep) references departamente_ (cod_dep) on delete cascade;
---
32. ªtergeþi departamentul 20 din DEPARTAMENTE_pnu. Ce se întâmplã? Rollback.

select * from angajati_mng;
-- 7 rez, dintre care 4 lucreaza in dept 20

delete from departamente_mng 
where cod_dep =20;
--1 rows deleted.

select * from angajati_mng;
--3 rez

rollback;
select * from angajati_mng; --7 rez
select * from departamente_mng; --3 rez

-- ON DELETE SET NULL

alter table angajati_mng
drop constraint fk_depart_mng2;
--table ANGAJATI_mng altered.

alter table angajati_mng
add constraint fk_depart_mng3 foreign key(cod_dep) references departamente_mng(cod_dep) on delete set null;


select * from angajati_mng;
-- 7 rez, dintre care 4 lucreaza in dept 20

delete from departamente_mng 
where cod_dep =20;
--1 rows deleted.

select * from angajati_mng;
--7 rez, cei care lucrau in dept 20, acum au dept setata null

33. Introduceþi constrângerea de cheie externã asupra coloanei cod_director a tabelului DEPARTAMENTE_pnu. 
Se doreºte ca ºtergerea unui angajat care este director de departament sã implice setarea automatã a 
valorii coloanei cod_director la null.
34. Actualizaþi tabelul DEPARTAMENTE_PNU, astfel încât angajatul având codul 102 sã devinã directorul departamentului 30. ªtergeþi angajatul având codul 102 din tabelul ANGAJATI_pnu. Analizaþi efectele comenzii. Rollback.
Este posibilã suprimarea angajatului având codul 101? Comentaþi.
35. Adãugaþi o constrângere de tip check asupra coloanei salariu, astfel încât acesta sã nu poatã depãºi 30000.
36. Încercaþi actualizarea salariului angajatului 100 la valoarea 35000.
37. Dezactivaþi constrângerea creatã anterior ºi reîncercaþi actualizarea. Ce se întâmplã dacã încercãm reactivarea constrângerii?



38. Creaþi o secvenþã pentru generarea codurilor de departamente, SEQ_DEPT_PNU. 
Secvenþa va începe de la 400, va creºte cu 10 de fiecare datã ºi va avea valoarea maximã 
10000, nu va cicla ºi nu va încãrca nici un numãr înainte de cerere.

create sequence seq_dept_mng
start with 400
increment by 10
maxvalue 10000
nocycle
nocache;

select seq_dept_mng.nextval
from dual;

--I -> 400
--II ->410

insert into departamente_mng
values(seq_dept_mng.nextval, 'Dept_sec', null);  --420
--SQL Error: ORA-01438: valoare mai mare decât precizia specificata permisa pentru aceasta coloana

desc departamente_mng;
Name         Null     Type         
------------ -------- ------------ 
COD_DEP      NOT NULL NUMBER(2)    
NUME         NOT NULL VARCHAR2(15) 
COD_DIRECTOR          NUMBER(4)    


insert into dept_mng
values(seq_dept_mng.nextval, 'Dept_sec', null, null); 
--1 rows inserted.
select * from dept_mng;
--430	Dept_sec		null null
--440	Dept_sec		null null 

40. Creaþi o secvenþã pentru generarea codurilor de angajaþi, SEQ_EMP_PNU.

create sequence seq_ang_mng
start with 100
maxvalue 10000
nocycle
nocache;

41. Sã se modifice toate liniile din angajati_mng (dacã nu mai existã, îl recreaþi),
regenerând codul angajaþilor astfel încât sã utilizeze secvenþa SEQ_EMP_PNU ºi 
sã avem continuitate în codurile angajaþilor.

update angajati_mng  --7 ang
set cod_ang = seq_ang_mng.nextval; --(100..106)
--SQL Error: ORA-02292: constrângerea de integritate (GRUPA34.FK_ANG_ANG_mng) violata - gasita înregistrarea copil

select * from angajati_mng;

delete from angajati_mng
where cod_ang =105; --nu rezolva problema
commit;

update angajati_mng --6 ang
set cod_ang = seq_ang_mng.nextval; --(107---112)
--SQL Error: ORA-02292: constrângerea de integritate (GRUPA34.FK_ANG_ANG_mng) violata - gasita înregistrarea copil


update angajati_mng
set cod_sef = null;
6 rows updated.

--dupa 2 update-uri esuate am ajuns la val 113

update angajati_mng
set cod_ang = seq_ang_mng.nextval;
6 rows updated.

--113	Nume1	Prenume1			Director		20000	10	
--114	Nume2	Prenume2	Nume2@gmail.com	02-02-2004	Inginer		10000	10	0,1
--115	Nume3	Prenume3	Nume3@gmail.com	05-06-2004	Analist		5000		
--116	Nume4	Prenume4		15-04-2021	Inginer		9000		
--117	Nume5	Prenume5	Nume5@gmail.com		Analist		3000	30	0,2
--118	Nume7	Prenume7	Nume7@gmail.com		Analist		3000		0,2

rollback;
--
--100	Nume1	Prenume1			Director		20000	10	
--101	Nume2	Prenume2	Nume2@gmail.com	02-02-2004	Inginer	100	10000	10	0,1
--102	Nume3	Prenume3	Nume3@gmail.com	05-06-2004	Analist	101	5000		
--103	Nume4	Prenume4		14-04-2021	Inginer	100	9000		
--104	Nume5	Prenume5	Nume5@gmail.com		Analist	101	3000	30	0,2
--114	Nume7	Prenume7	Nume7@gmail.com		Analist	100	3000		0,2


--modific codul unui angajat care nu este sef -> se poate
update angajati_mng 
set cod_ang = seq_ang_mng.nextval
where cod_ang =104;

--100	Nume1	Prenume1			Director		20000	10	
--101	Nume2	Prenume2	Nume2@gmail.com	02-02-2004	Inginer	100	10000	10	0,1
--102	Nume3	Prenume3	Nume3@gmail.com	05-06-2004	Analist	101	5000		
--103	Nume4	Prenume4		15-04-2021	Inginer	100	9000		
--119	Nume5	Prenume5	Nume5@gmail.com		Analist	101	3000	30	0,2
--114	Nume7	Prenume7	Nume7@gmail.com		Analist	100	3000		0,2
