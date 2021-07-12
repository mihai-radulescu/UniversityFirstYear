IV. [Exerci?ii � definire tabele]
1. S� se creeze tabelul ANGAJATI_mng (pnu se alcatuie�te din prima liter� din prenume �i primele dou� din numele studentului) corespunz�tor schemei rela�ionale:
ANGAJATI_mng(cod_ang number(4), nume varchar2(20), prenume varchar2(20), email char(15), data_ang date, job varchar2(10), cod_sef number(4), salariu number(8, 2), cod_dep number(2))
�n urm�toarele moduri:
Se presupune c� valoarea implicit� a coloanei data_ang este SYSDATE.
Observa?ie: Nu pot exista dou� tabele cu acela�i nume �n cadrul unei scheme, deci recrearea unui tabel va fi precedat� de suprimarea sa prin comanda:
DROP TABLE ANGAJATI_mng;

a) f�r� precizarea vreunei chei sau constr�ngeri;

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
  
b) cu precizarea cheilor primare la nivel de coloan� ?i a constr�ngerilor NOT NULL pentru coloanele nume �i salariu;
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



c) cu precizarea cheii primare la nivel de tabel ?i a constr�ngerilor NOT NULL pentru coloanele nume �i salariu.
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
  Observa?ie: Tipul constr�ngerilor este marcat prin:
� P � pentru cheie primar�
� R � pentru constr�ngerea de integritate referen�ial� (cheie extern�);
� U � pentru constr�ngerea de unicitate (UNIQUE);
� C � pentru constr�ngerile de tip CHECK.

--NULL_SALARIU_mng	C	ANGAJATI_mng
--NULL_NUME_mng	C	ANGAJATI_mng
--PK_ANG_mng	P	ANGAJATI_mng

2.	Ad?uga?i urm?toarele �nregistr?ri �n tabelul ANGAJATI_***:

Cod_ang	Nume	Prenume	Email	Data_ang	Job	Cod_sef	Salariu	Cod_dep
100	Nume1	Prenume1	Null	Null	Director	null	20000	10
101	Nume2	Prenume2	Nume2	02-02-2004	Inginer	100	10000	10
102	Nume3	Prenume3	Nume3	05-06-2004	Analist	101	5000	20
103	Nume4	Prenume4	Null	Null	Inginer	100	9000	20
104	Nume5	Prenume5	Nume5	Null	Analist	101	3000	30
Prima si a patra �nregistrare vor fi introduse specific�nd coloanele pentru care 
introduce?i date efectiv, iar celelalte vor fi inserate f?r? precizarea coloanelor �n comanda INSERT.
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

3. Crea�i tabelul ANGAJATI10_mng, prin copierea angaja�ilor din departamentul 10 
din tabelul ANGAJATI_mng. Lista�i structura noului tabel. Ce se observ�?

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

5. Este posibil� modificarea tipului coloanei comision �n NUMBER(6,2)?
alter table angajati_mng
modify (comision number(6,2));

--apoi pot sa micsorez?
alter table angajati_mng
modify (comision number(4,2));
--table ANGAJATI_mng altered. (toate infomatiiile din coloana comision sunt nule)

select * from angajati_mng;
5" .	Este posibil? modificarea tipului coloanei salariu �n NUMBER(6,2)?
--SALARIU  NOT NULL NUMBER(8,2) 
alter table angajati_mng
modify (salariu number(6,2));
--SQL Error: ORA-01440: coloana de modificat trebuie sa fie goala pentru a micsora precizia sau scala
------------------------------------------------------------------------------------------------
6. Seta�i o valoare DEFAULT pentru coloana salariu.

alter table angajati_mng
modify(salariu default 1111);

insert into angajati_mng (Cod_ang, Nume, Prenume, Job, Cod_sef, Cod_dep) --lipseste salariul 
values (105, 'Nume6', 'Prenume6', 'Inginer', 100, 20);

insert into angajati_mng (Cod_ang, Nume, Prenume, Job, Cod_sef, Cod_dep, salariu)
values (106, 'Num76', 'Prenume76', 'Inginer', 100, 20, 2222);

select * from angajati_mng;
--105	Nume6	Prenume6		14-04-2021	Inginer	100	1111	20	
-- 106	Num76	Prenume76		14-04-2021	Inginer	100	2222	20	

7. Modifica�i tipul coloanei comision �n NUMBER(2, 2) �i al coloanei salariu �n NUMBER(10,2), 
�n cadrul aceleia�i instruc�iuni.
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

8. Actualiza?i valoarea coloanei comision, set�nd-o la valoarea 0.1 pentru 
salaria�ii al c�ror job �ncepe cu litera I. (UPDATE)
select * from angajati_mng;

update angajati_mng
set comision=0.1
where lower(job)  like 'i%';

select * from angajati_mng;

12. Redenumi�i tabelul ANGAJATI_mng �n ANGAJATI3_mng.
rename angajati_mng to angajati3_mng; 
--angajati_mng TO succeeded.
select * from angajati_mng; --ORA-00942: tabelul sau vizualizarea nu exista
select * from angajati3_mng; 

13. Consulta�i vizualizarea TAB din dic�ionarul datelor. Redenumi�i angajati3_mng �n angajati_mng.
select * from tab;
rename angajati3_mng to angajati_mng;
select * from angajati_mng;
select * from angajati3_mng;  --ORA-00942: tabelul sau vizualizarea nu exista

14. Suprima�i con�inutul tabelului angajati10_mng, f�r� a suprima structura acestuia.

create table angajati10_mng as
  Select * from angajati_mng where cod_dep =10;
  
  select * from angajati10_mng;
  
  delete from angajati10_mng; --tabela goala
  rollback; --avem cele 2 inregistrari
  
  truncate table angajati10_mng; --se pastreaza structura tabelei (DELETE+COMMIT)
  rollback; -- in continuare tabela este goala
  
  drop table angajati10_mng;
  select * from angajati10_mng; --ORA-00942: tabelul sau vizualizarea nu exista
  
15. Crea�i tabelul DEPARTAMENTE_mng, corespunz�tor schemei rela�ionale:
DEPARTAMENTE_mng (cod_dep# number(2), nume varchar2(15), cod_director number(4))
specific�nd doar constr�ngerea NOT NULL pentru nume (nu preciza�i deocamdat� constr�ngerea de cheie primar�). 

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

16. Introduce�i urm�toarele �nregistr�ri �n tabelul DEPARTAMENTE_pnu:
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

17. Introduce?i const�ngerea de cheie primar� asupra coloanei cod_dep, f�r� suprimarea �i recrearea tabelului 
(comanda ALTER).
Observa?ie:
o Introducerea unei constr�ngeri dup� crearea tabelului presupune c� toate liniile existente �n tabel la 
momentul respectiv satisfac noua constr�ngere.
o Specificarea constr�ngerilor permite numirea acestora.
o In situa�ia in care constr�ngerile sunt precizate la nivel de coloan� sau tabel 
(�n CREATE TABLE) ele vor primi implicit nume atribuite de sistem, dac� nu se specific� vreun alt nume 
�ntr-o clauz� CONSTRAINT.
Exemplu : CREATE TABLE alfa (
X NUMBER CONSTRAINT nn_x NOT NULL,
Y VARCHAR2 (10) NOT NULL
);

alter table departamente_mng  --PK = Unique + NOT NULL
add constraint pk_depart_mng primary key (cod_director);
--SQL Error: ORA-01449: coloana contine valori NULL; nu se poate modifica �n NOT NULL

alter table departamente_mng
add constraint pk_dep_mng primary key (cod_dep); 
--SQL Error: ORA-02264: nume folosit deja de o constr�ngere existenta

alter table departamente_mng
add constraint pk_depart_mng primary key (cod_dep); 
--table DEPARTAMENTE_mng altered.

alter table departamente_mng
drop constraint pk_depart_mng;

18. S� se precizeze constr�ngerea de cheie extern� pentru coloana cod_dep din ANGAJATI_pnu:
a) f�r� suprimarea tabelului (ALTER TABLE);

alter table angajati_mng
add constraint fk_ang_depart_mng foreign key(cod_dep) references departamente_mng(cod_dep);

SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) = 'angajati_mng';

NULL_SALARIU_mng	C	ANGAJATI_mng
NULL_NUME_mng	C	ANGAJATI_mng
FK_ANG_DEPART_mng	R	ANGAJATI_mng --FK
PK_ANG_mng	P	ANGAJATI_mng  --PK

b) prin suprimarea �i recrearea tabelului, cu precizarea noii constr�ngeri la nivel de coloan� 
({DROP, CREATE} TABLE). De asemenea, se vor mai preciza constr�ngerile (la nivel de coloan�, 
�n m�sura �n care este posibil):
- PRIMARY KEY pentru cod_ang;
- FOREIGN KEY pentru cod_sef;
- UNIQUE pentru combina�ia nume + prenume;
- UNIQUE pentru email;
- NOT NULL pentru nume;
- verificarea cod_dep > 0;
- verificarea ca salariul s� fie mai mare dec�t comisionul*100.

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

19. Suprima�i �i recrea�i tabelul, specific�nd toate constr�ngerile la nivel de tabel 
(�n m�sura �n care este posibil).
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

25. (�ncerca�i s�) ad�uga�i o nou� �nregistrare �n tabelul ANGAJATI_pnu, care s� corespund� codului
de departament 50. Se poate?

insert into angajati_mng
values (105, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);
--SQL Error: ORA-00001: restrictia unica (GRUPA34.UNQ_NUME_PREN_mng) nu este respectata

insert into angajati_mng
values (105, 'Nume6', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);
--SQL Error: ORA-00001: restrictia unica (GRUPA34.UNQ_EMAIL_mng) nu este respectata

insert into angajati_mng
values (105, 'Nume6', 'Prenume6', 'Nume6@gmail.com', Null, 'Analist', 101, 3000, 50, 0.2);
SQL Error: ORA-02291: constr�ngere de integritate (GRUPA33.FK_DEPART_mng) violata - cheia parinte negasita
--dept 50 nu exista in lista de departamente

29. (�ncerca�i s�) introduce�i un nou angajat, specific�nd valoarea 114 pentru cod_sef. Ce se ob�ine?

insert into angajati_mng
values (105, 'Nume6', 'Prenume6', 'Nume6@gmail.com', null, 'Analist', 114, 3000, 20, 0.2);

SQL Error: ORA-02291: constr�ngere de integritate (GRUPA33.FK_ANG_ANG_mng) violata - cheia parinte negasita

--angajatul 114 nu exista in baza de date
30. Ad�uga�i un nou angajat, av�nd codul 114. �ncerca�i din nou introducerea �nregistr�rii de la exerci�iul 29.

insert into angajati_mng
values (114, 'Nume7', 'Prenume7', 'Nume7@gmail.com', null, 'Analist', 100, 3000, 20, 0.2); --1 rows inserted.

insert into angajati_mng
values (105, 'Nume6', 'Prenume6', 'Nume6@gmail.com', null, 'Analist', 114, 3000, 20, 0.2); --1 rows inserted.

select * from angajati_mng;

21. Ce se �nt�mpl� dac� se �ncearc� suprimarea tabelului departamente_pnu?

drop table departamente_mng; 
--SQL Error: ORA-02449: cheile unice/primare din tabela sunt referite de cheile externe
truncate table departamente_mng; 
--SQL Error: ORA-02266: cheile unice/primare din tabela sunt referite de cheile externe activate
delete from departamente_mng; 
--SQL Error: ORA-02292: constr�ngerea de integritate (GRUPA33.FK_DEPART_mng) violata - gasita �nregistrarea copil

26. Ad�uga�i un nou departament, cu numele Testare, codul 60 �i directorul null �n DEPARTAMENTE_pnu. COMMIT.
insert into departamente_mng
values(60,	'Testare',	null); --1 rows inserted.
commit;

27. (�ncerca�i s�) �terge�i departamentul 20 din tabelul DEPARTAMENTE_pnu. Comenta�i.
delete from departamente_mng
where cod_dep =20;
--SQL Error: ORA-02292: constr�ngerea de integritate (GRUPA34.FK_DEPART_mng) violata - gasita �nregistrarea copil
--lucreaza angajati in dept 20
select * from angajati_mng
where cod_dep =20;

28. �terge�i departamentul 60 din DEPARTAMENTE_pnu. ROLLBACK.

select * from departamente_mng;
delete from departamente_mng
where cod_dep =60; --1 rows deleted.

31. Se dore�te �tergerea automat� a angaja�ilor dintr-un departament, odat� cu suprimarea departamentului.
Pentru aceasta, este necesar� introducerea clauzei ON DELETE CASCADE �n definirea constr�ngerii de cheie extern�.
Suprima�i constr�ngerea de cheie extern� asupra tabelului ANGAJATI_pnu �i reintroduce�i aceast� constr�ngere, 
specific�nd clauza ON DELETE CASCADE.

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
32. �terge�i departamentul 20 din DEPARTAMENTE_pnu. Ce se �nt�mpl�? Rollback.

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

33. Introduce�i constr�ngerea de cheie extern� asupra coloanei cod_director a tabelului DEPARTAMENTE_pnu. 
Se dore�te ca �tergerea unui angajat care este director de departament s� implice setarea automat� a 
valorii coloanei cod_director la null.
34. Actualiza�i tabelul DEPARTAMENTE_PNU, astfel �nc�t angajatul av�nd codul 102 s� devin� directorul departamentului 30. �terge�i angajatul av�nd codul 102 din tabelul ANGAJATI_pnu. Analiza�i efectele comenzii. Rollback.
Este posibil� suprimarea angajatului av�nd codul 101? Comenta�i.
35. Ad�uga�i o constr�ngere de tip check asupra coloanei salariu, astfel �nc�t acesta s� nu poat� dep�i 30000.
36. �ncerca�i actualizarea salariului angajatului 100 la valoarea 35000.
37. Dezactiva�i constr�ngerea creat� anterior �i re�ncerca�i actualizarea. Ce se �nt�mpl� dac� �ncerc�m reactivarea constr�ngerii?



38. Crea�i o secven�� pentru generarea codurilor de departamente, SEQ_DEPT_PNU. 
Secven�a va �ncepe de la 400, va cre�te cu 10 de fiecare dat� �i va avea valoarea maxim� 
10000, nu va cicla �i nu va �nc�rca nici un num�r �nainte de cerere.

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
--SQL Error: ORA-01438: valoare mai mare dec�t precizia specificata permisa pentru aceasta coloana

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

40. Crea�i o secven�� pentru generarea codurilor de angaja�i, SEQ_EMP_PNU.

create sequence seq_ang_mng
start with 100
maxvalue 10000
nocycle
nocache;

41. S� se modifice toate liniile din angajati_mng (dac� nu mai exist�, �l recrea�i),
regener�nd codul angaja�ilor astfel �nc�t s� utilizeze secven�a SEQ_EMP_PNU �i 
s� avem continuitate �n codurile angaja�ilor.

update angajati_mng  --7 ang
set cod_ang = seq_ang_mng.nextval; --(100..106)
--SQL Error: ORA-02292: constr�ngerea de integritate (GRUPA34.FK_ANG_ANG_mng) violata - gasita �nregistrarea copil

select * from angajati_mng;

delete from angajati_mng
where cod_ang =105; --nu rezolva problema
commit;

update angajati_mng --6 ang
set cod_ang = seq_ang_mng.nextval; --(107---112)
--SQL Error: ORA-02292: constr�ngerea de integritate (GRUPA34.FK_ANG_ANG_mng) violata - gasita �nregistrarea copil


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
