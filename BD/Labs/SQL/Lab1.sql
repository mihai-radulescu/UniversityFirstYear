select *
from departments;

select *
from jobs;

select employee_id, last_name
from employees;

desc employees;

select *
from employees;

select *
from employees
where department_id is null;

select *
from employees
where employee_id =179;

select first_name, last_name, email, jobs.job_id, jobs.job_title, department_id
from employees , jobs 
where employee_id =106
and employees.job_id = jobs.job_id;


select *
from employees
order by salary;

describe departments;

describe employees;

describe jobs;
select *
from jobs;

select job_id, max_salary - Min_salARY 
from jobs
order by 2 desc;

select  max_salary - Min_salARY, job_id
from jobs
order by 2 desc; 
--ordonare dupa job_id

select  max_salary - Min_salARY, job_id
from jobs
order by 1 desc; --ordonare dupa diferenta intre limite salariala

select  max_salary - Min_salARY, job_id
from jobs
order by max_salary - min_salary desc;

select   job_id, max_salary - Min_salARY
from jobs
order by max_salary - min_salary desc;

select job_id, max_salary - Min_salARY  Diferenta_sal -- alias pt expresie
from jobs
order by Diferenta_sal desc;

select job_id, max_salary - Min_salARY as Diferenta_sal -- alias pt expresie
from jobs
order by Diferenta_sal desc;

select  max_salary - Min_salARY as Diferenta_sal, job_id  -- alias pt expresie
from jobs
order by Diferenta_sal desc;

select job_id, max_salary - Min_salARY  Diferenta sal
from jobs
order by 2; -- eroare

select col1, col2, col3 alias3, col4 alias4
from tabel; 

select job_id, max_salary - Min_salARY  Diferenta_sal
from jobs
order by Diferenta_sal desc; -- majuscule

select job_id, max_salary - Min_salARY as "DiferentA sal"
from jobs
order by "DiferentA sal" desc; -- case-sensitive

select job_id, max_salary - Min_salARY as "DiferentA sal"
from jobs
order by "Diferenta sal" desc; --eroare  "Diferenta sal": identificator nevalid

select EMPLOYEE_ID--, SALARY
from employees
order by salary;


--select last_name, first_name, e.department_id, department_name
--from employees e, departments d
--where e.department_id = d.department_id
--and employee_id in (100,101,102);
--
--
--select last_name, first_name , (select department_name from departments d where  d.department_id = e.department_id)
--from employees e
--where employee_id in (100,101,102);

/*7. Care dintre clauze (�n sintaxa simplificat�) sunt obligatorii?
In instructiunea urmatoare sunt 2 erori. Care sunt acestea?  */

SELECT employee_id, last_name, salary * 12 ANNUAL_SALARY
FROM employees;

SELECT employee_id, last_name, salary * 12 "ANNUAL SALARY"
FROM employees;

--Observa?ie: ANNUAL SALARY este un alias pentru c�mpul reprezent�nd salariul anual.

--ordonare dupa salariul anual
SELECT employee_id, last_name, salary * 12 "ANNUAL SALARY"
FROM employees
order by 3 ;

SELECT employee_id, last_name, salary * 12 "ANNUAL SALARY"
FROM employees
order by "ANNUAL SALARY" ;

SELECT employee_id, last_name, salary * 12 "ANNUAL SALARY"
FROM employees
order by salary * 12 ; 

-- ordonare alfabetica dupa first_name
SELECT employee_id,
  last_name,
  salary * 12 "ANNUAL SALARY"
  /*, first_name --doar pt verificare*/
FROM employees
ORDER BY first_name; --first_name este o coloana a tabelei employees


select * from employees;

--3.	S� se listeze structura tabelelor din schema HR (EMPLOYEES, DEPARTMENTS, JOBS, JOB_HISTORY, LOCATIONS, COUNTRIES, REGIONS), observ�nd tipurile de date ale coloanelor. 
--Obs: Se va utiliza comanda DESC[RIBE] nume_tabel.
describe employees;
desc departments;

--4. S� se listeze con�inutul tabelelor din schema considerat�, afi��nd valorile tuturor c�mpurilor.
select *
from DEPARTMENTS;

desc jobs;
select * from jobs;

--5. S� se afi�eze codul angajatului, numele, codul job-ului, data angajarii. 
--Ce fel de opera�ie este aceasta (selec�ie sau proiec�ie)?
select EMPLOYEE_ID, last_name, JOB_ID, HIRE_DATe -- , department_name
from employees;

6. Modifica?i cererea anterioar� astfel �nc�t, la rulare, capetele coloanelor s�
aib� numele cod, nume, cod job, data angajarii.

select EMPLOYEE_ID cod, LAST_NAME as "Nume", JOB_ID as "cod job", HIRE_DATe Data_angajarii
from employees;


select EMPLOYEE_ID as "Cod", last_name as nume, JOB_ID "Cod job", HIRE_DATE "Data angajaRII"
from employees;

select EMPLOYEE_ID as cod, last_name as nume, JOB_ID  "Cod job", HIRE_DATE as "data angajarii"
from employees;

select EMPLOYEE_ID  cod, last_name "Nume",first_name as Prenume, JOB_ID "Cod job", HIRE_DATE Data_angajarii
from employees;

select EMPLOYEE_ID, LAST_NAME, FIRST_NAME, JOB_ID, HIRE_DATE
from employees;

select EMPLOYEE_ID  as "cod", LAST_NAME "Nume", FIRST_NAME prenume, JOB_ID cod_job, HIRE_DATE "data angajarii"
from employees;

--7.	S� se listeze, cu �i f�r� duplicate, codurile job-urilor din tabelul EMPLOYEES.
--Obs: Se va utiliza op?iunea DISTINCT.

select distinct employee_id
from employees; 

--107 linii pt ca employee_id PK

select employee_id
from employees; --107 linii

select job_id
from employees; --107 linii

select distinct job_id
from employees; --19 linii

--8. S� se afi�eze numele concatenat cu job_id-ul, separate prin virgula ?i spatiu. Eticheta?i coloana �Angajat si titlu�.
--Obs: Operatorul de concatenare este �||�. �irurile de caractere se specific� �ntre apostrofuri (NU ghilimele, 
--caz �n care ar fi interpretate ca alias-uri).
Select last_name , job_id
from employees;

Select last_name ||', ' || job_id
from employees;

Select last_name || ', '|| job_id as "Angajat si titlu"
from employees;

Select first_name||' '||  last_name || ', '|| job_id "Angajat si titlu"
from employees;

Select first_name || job_id
from employees;

Select first_name|| ' '|| LAST_NAME || ', ' || job_id "Angajat si job"
from employees; --107 linii

--9.	Crea?i o cerere prin care s� se afi?eze toate datele din tabelul EMPLOYEES pe
--o singur� coloan�. Separa�i fiecare coloan� printr-o virgul�. Etichetati coloana �Informatii complete�.
describe EMPLOYEES;
select * from employees;

select employee_id || ', ' || first_name || ' ' || last_name || ', ' || email || ', ' ||
phone_number || ', ' || hire_date || ', ' || job_id || ', ' || salary || ', ' ||
commission_pct || ', ' || manager_id || ', ' || department_id as "Informatii complete"
from employees;

select employee_id || ', ' || first_name || ' ' || last_name || ', ' 
|| email || ', ' || phone_number || ', ' 
|| hire_date || ', ' || job_id || ', ' || salary || ', ' 
|| nvl(commission_pct, 0) || ', ' || manager_id || ', ' || department_id "Informatii complete"
from employees;

--10.	S� se listeze numele si salariul angaja�ilor care c�tig� mai mult de 2850. 
select last_name, salary
from employees
where salary >2850
order by salary;--86 linii

select last_name, salary
from employees
where salary <= 2850
order by salary; --21 linii cu sal intre 2100 si 2800

--11.	S� se creeze o cerere pentru a afi�a numele angajatului �i codul departamentului pentru angajatul av�nd codul 104.

select employee_id,FIRST_NAME || ' '||last_name as nume, department_id
from employees
where employee_id =104;
--12.	S� se afi�eze numele �i salariul angaja�ilor al c�ror salariu nu se afl� �n intervalul [1500, 2850]. 
--Obs: Pentru testarea apartenen�ei la un domeniu de valori se poate utiliza operatorul 
--[NOT] BETWEEN valoare1 AND valoare2.
select FIRST_NAME || ' '||last_name, salary
from employees
where salary   between 1500 and 2850 --salariu  se afl� �n intervalul [1500, 2850]. 
order by 2; --21 linii


select FIRST_NAME || ' '||last_name, salary
from employees
where salary  not between 1500 and 2850 ---din diagrama, rezultatul este echivalent cu cei casre au salary>2850
order by 2;--86 linii

-- pt verificare
select last_name, salary
from employees
where salary <2850
order by salary; --21 sal

--13.	S� se afi�eze numele, job-ul �i data la care au �nceput lucrul salaria�ii angaja�i �ntre 
--20 Februarie 1987 �i 1 Mai 1989. Rezultatul  va fi ordonat cresc�tor dup� data de �nceput.
SELECT * FROM V$NLS_PARAMETERS;
ALTER SESSION SET NLS_LANGUAGE=American; 
SELECT last_name, job_id, hire_date
FROM  employees
WHERE hire_date BETWEEN '20-FEB-1987' and '1-MAY-1989'
ORDER BY 3;
--King	AD_PRES	17-06-1987
--Whalen	AD_ASST	17-09-1987

ALTER SESSION SET NLS_LANGUAGE=Romanian; 
SELECT last_name, job_id, hire_date
FROM  employees
WHERE hire_date BETWEEN '20-FEB-1987' and '1-MAI-1989'
ORDER BY 3;

--14.	S� se afi�eze numele salaria�ilor �i codul departamentelor pentru toti angaja�ii din departamentele
--10, 30 si 50 �n ordine alfabetic� a numelor.
--Obs: Apartenen�a la o mul�ime finit� de valori se poate testa prin intermediul operatorului IN, 
--urmat de lista valorilor (specificate �ntre paranteze �i separate prin virgule):
--expresie IN (valoare_1, valoare_2, �, valoare_n) 

select last_name, department_id
from employees
where department_id in (10,30,50)
order by last_name;--52 linii

select last_name, department_id
from employees
where department_id = 10
      or department_id = 30
      or department_id = 50
order by last_name;--52 linii

--15.	S� se listeze numele �i salariile angaja?ilor care c�tig� mai mult dec�t 3000 �i lucreaz� �n
--departamentul 10, 30 sau 50. Se vor eticheta coloanele drept Angajat si Salariu lunar. 

select last_name Angajat, salary "salariu lunar"
from employees
where department_id in (10,30,50)
      and salary >=3000
order by last_name;--28 linii


select last_name Angajat, salary "Salariu lunar"
from employees
where department_id in (10,30,50)
and salary >=3000
order by last_name;

select last_name as angajat, department_id Dept, salary "Salariu lunar"
from employees
where department_id in (10,30,50) 
and salary >=3000
order by last_name;--28 linii

select last_name as angajat, department_id Dept, salary "Salariu lunar"
from employees
where department_id in (10,30,50) 
and salary >=3000
order by Dept;

select last_name as Angajat, department_id Departament, salary "Salariu lunar"
from employees
where department_id in (10,30,50)
      and salary >=3000
order by Departament, last_name;

select FIRST_NAME as Angajat,last_name, department_id Departament, salary "Salariu lunar"
from employees
where department_id in (10,30,50)
      and salary >3000
order by FIRST_NAME;
--Jennifer	50	3600
--Jennifer	10	4400
--Julia	50	3400
--Julia	50	3200
select FIRST_NAME as Angajat, LAST_NAME, department_id Departament, salary "Salariu lunar"
from employees
where department_id in (10,30,50)
      and salary >3000
order by FIRST_NAME, DEPARTMENT_ID, salary;
--Jennifer	10	4400
--Jennifer	50	3600
--Julia	50	3200
--Julia	50	3400

select last_name as Angajat, department_id Departmanet, salary "Salariu lunar"
from employees
where department_id in (10,30,50)
      and salary >3000
order by salary, department_id, last_name ;--26 linii

select FIRST_NAME as Angajat, department_id Departament, salary "Salariu lunar"
from employees
where (department_id in (10,30,50)
      and salary >3000)
      or department_id =80
order by DEPARTMENT_ID, salary;

--16.	Care este data curent�? Afi�a�i diferite formate ale acesteia.

select sysdate
from dual;

select 1+2
from dual;

select sysdate
from EMPLOYEES;


select 1+2
from EMPLOYEES;

select employee_id
from dual;--eroare


select to_char(sysdate, 'D')
from dual; -- ziua din saptamana

select to_char(sysdate, 'DD')
from dual; --ziua din luna

select to_char(sysdate, 'DDD')
from dual; --

select to_char(sysdate, 'DAY')
from dual; 

ALTER SESSION SET NLS_LANGUAGE=American; 
ALTER SESSION SET NLS_LANGUAGE=Romanian; 
SELECT * FROM V$NLS_PARAMETERS;

--134_1
select to_char(sysdate, 'YYYY')
from dual;

select to_char(sysdate, 'Year')
from dual; --Twenty Twenty-One

select to_char(sysdate, 'YEAR')
from dual; --TWENTY TWENTY-ONE

-- Afisati anul angajarii fiecarui salariat
select to_char(Hire_date, 'YYYY')
from employees;

select hire_date
from employees; --17-06-1987
select to_char(Hire_date, 'DD.MON.YYYY')
from employees
order by  to_char(Hire_date, 'YYYY');

select to_char(Hire_date, 'DD.MON.YYYY')
from employees
order by  HIRE_DATE;

select to_char(Hire_date, 'YYYY MM DD')
from employees;-- 1987 06 17

--Afisati salariatii angajati dupa anul 2000
select to_char(Hire_date, 'DD.MON.YYYY')
from employees
where to_char(hire_date, 'YYYY') >=2000
order by  to_char(Hire_date, 'YYYY');


select to_char(sysdate, 'DD-MM-YYYY HH24:MI')
from dual; 

select to_char(sysdate, 'DD-MM-YYYY HH12:MI:SS')
from dual; 

select to_char(sysdate, 'MON')
from dual; 

select to_char(sysdate, 'Month')
from dual; --Februarie 
select to_char(sysdate, 'MONTH')
from dual; --FEBRUARIE 


17. S� se afi?eze numele �i data angaj�rii pentru fiecare salariat care a fost
angajat �n 1987. Se cer 2 solu�ii: una �n care se lucreaz� cu formatul implicit
al datei �i alta prin care se formateaz� data.
Varianta1:
��������.
WHERE hire_date LIKE (�%87%�);
Varianta 2:
��������.
WHERE TO_CHAR(hire_date, �YYYY�)=�1987�;
Sunt obligatorii ghilimelele de la �irul de caractere �1987�? Ce observa�i?
Varianta 2�:
��������.
WHERE EXTRACT(YEAR from hire_date)=1987;
Obs: Elementele (c�mpuri ale valorilor de tip datetime) care pot fi utilizate 
�n cadrul acestei func?ii sunt: YEAR, MONTH, DAY, HOUR, MINUTE, SECOND.


select to_char(Hire_date, 'DD.MON.YYYY') Data_ang, last_name
from employees
where to_char(hire_date, 'YYYY')='1987';

select to_char(Hire_date, 'DD.MON.YYYY'), last_name
from employees
where to_char(hire_date, 'YYYY')=1987;  --conversie implicat de la varchar la number

select to_char(Hire_date, 'DD.MON.YYYY'), last_name
from employees
where to_number(to_char(hire_date, 'YYYY'))=1987;

select to_char(Hire_date, 'DD.MON.YYYY'), last_name
from employees
where hire_date like '%87' ;  --conversie implicita intre date si varchar
--10-10-1875 
--17-06-1987
--18-09-2087
--'%87' -- orice sir de carcatere care se termina in 87

select to_char(Hire_date, 'DD.MON.YYYY'), last_name
from employees
where hire_date like '%1987' ; 
select to_char(Hire_date, 'DD.MON.YYYY')Data_ang, last_name
from employees
where to_char(hire_date, 'YYYY') like '1987'; --to_char(hire_date, 'YYYY') = '1987';

select employee_id,hire_date, Extract(Year from hire_date) An, Extract(MONTH from hire_date) Luna,
        to_char(hire_date,'DD-MM-YYYY HH24:MI:SS') Data
from employees;

19.S� se afi�eze numele �i job-ul pentru to�i angaja�ii care nu au manager.
Select first_name, last_name, manager_id, job_id
from employees
where manager_id is  null; --Steven	King  null	AD_PRES

Select first_name, last_name, manager_id, job_id
from employees
where manager_id is not null; -- toti salariatii care au manager

20. S� se afi?eze numele, salariul ?i comisionul pentru toti salaria?ii care c�?tig� comision 
(se presupune c� aceasta �nseamn� prezen?a unei valori nenule �n coloana respectiv�).
S� se sorteze datele �n ordine descresc�toare a salariilor ?i comisioanelor.;

select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by 2 desc, 3 desc; --35 rezultate
--9. King	  10000	0,35
--10.Tucker	10000	0,3
--11.Bloom  10000	0,2
select last_name, salary, commission_pct
from employees
where COMMISSION_PCT>0;

select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by 2 desc, 3 asc;-- order by salary desc, commission_pct asc;
--9.  Bloom	  10000	0,2
--10. Tucker	10000	0,3
--11. King	  10000	0,35

select last_name, salary, commission_pct
from employees
where commission_pct is not null
order by 2 asc, 3 desc;
--25. King  	10000	0,35
--26. Tucker	10000	0,3
--27. Bloom  	10000	0,2

21. Elimina�i clauza WHERE din cererea anterioar�. Unde sunt plasate valorile NULL �n ordinea descresc�toare?;

select last_name, salary, commission_pct
from employees
--where commission_pct is not null
order by 2 desc, 3 desc; 
-- null cea mai mare valoare

--Baer	  10000	null
--King	  10000	0,35
--Tucker	10000	0,3
--Bloom	  10000	0,2

select last_name, salary, commission_pct
from employees
--where commission_pct is not null
order by 3 desc, 2 desc; --  ordonare mai intai dupa comision si apoi dupa salarii

22. S� se listeze numele tuturor angaja?ilor care au a treia liter� din nume �A�.
Obs: Pentru compararea �irurilor de caractere, �mpreun� cu operatorul LIKE se utilizeaz� caracterele wildcard:
? % - reprezent�nd orice �ir de caractere, inclusiv �irul vid;
? _ (underscore) � reprezent�nd un singur caracter �i numai unul.


select last_name
from employees
where last_name like '__A%'; --0 linii

select last_name
from employees
where last_name like '__a%'; --3 rezultate
-- numele salaratilor care se termina in a si au 3 litere
select last_name
from employees
where last_name like '__a';

--numele salaratiatii care se termina in a 
select last_name
from employees
where last_name like '%a'; --4 rez

-- '%a%' --sa contina un a in nume
select last_name
from employees
where last_name like '%a%'
order by 1; --52 rezultate

select last_name
from employees
where last_name like 'A%'; --4 rezultate

select last_name
from employees
where lower(last_name) like '%a%' -- nu mai este casa-sensitive
order by 1; --56 rezultate


select last_name
from employees
where last_name like '%a%'
or last_name like 'A%'
order by 1; --56 

select last_name
from employees
where last_name like 'H%' or 
last_name like '%h%' ; --19 rezulate -- lipseste De Han

select last_name
from employees
where upper(last_name) like '%A%' -- nu mai este casa-sensitive
order by 1; --56 rezultate
--incep cu litera a
select last_name
from employees
where lower(last_name) like 'a%';

select last_name, department_id
from employees
where (last_name) like '%h%';--13 rezultate

select last_name, department_id
from employees
where lower(last_name) like '%h%'; --20rezultate

select last_name, department_id
from employees
where upper(last_name) like '%H%';--20 rezultate

23. S� se listeze numele tuturor angajatilor care au 2 litere �L� in nume �i 
lucreaz� �n departamentul 30 sau managerul lor este 102.

select last_name, department_id, manager_id
from employees
where lower(last_name) like '%l%l%'; --13 rez

select last_name, department_id, manager_id
from employees
where (last_name) like '%L%L%';

select last_name, department_id, manager_id
from employees
where lower(last_name) like '%l%l%'
      and department_id =30
or 
manager_id =102; --Hunold	60 102

select last_name, department_id, manager_id
from employees
where  manager_id =102  -- Hunold
or
lower(last_name) like '%l%l%'  --0 rez (cei cu 2 de l in nume lucreaza in dept 50,60,80)
and department_id =30;

select last_name, department_id, manager_id
from employees
where lower(last_name) like '%l%l%'
      and  manager_id =102 --0 rezulate
or 
department_id =30; --6 salariati care lucreaza in dept 30

select last_name, department_id
from employees
where (last_name like '%l%l%'
and department_id =30); -- 0 rez

select last_name, department_id
from employees
where (last_name like '%l%l%'
and department_id =30)
or manager_id =102;  -- incorecta

select last_name, department_id
from employees
where lower(last_name) like '%l%l%'
and (department_id =30
    or manager_id =102); --0 rez  -- rezolvarea corecta

select last_name, department_id, manager_id
from employees
where lower(last_name) like '%l%l%'
and (department_id =50 --8 rez
or manager_id =102);


select last_name, department_id, manager_id
from employees
where lower(last_name) like '%l%l%'
and (department_id =30
or manager_id =103); --Pataballa	60	103

select last_name, department_id, manager_id
from employees
where lower(last_name) like '%l%l%'
and (department_id =50 --8 rez
or manager_id =103);  --1 rez
-- Final : 9 rez










http://www.nazmulhuda.info/setting-nls_lang-environment-variable-for-windows-and-unix-for-oracle-database
