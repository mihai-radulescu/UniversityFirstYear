--Lab 10  
--Subcerei necorelate + corelate

1. Folosind subcereri, sã se afiºeze numele ºi data angajãrii pentru salariaþii care au fost angajaþi dupã Gates.
SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date --11-07-1998
                    FROM employees
                    WHERE INITCAP(last_name)='Gates')
order by 2; --34 rez
1". Folosind subcereri, sã se afiºeze numele ºi data angajãrii pentru salariaþii care au fost angajaþi dupã Gates 
si au salariul mai mare decat el.

SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
                    FROM employees
                    WHERE INITCAP(last_name)='Gates')
and salary > ( SELECT salary
                    FROM employees
                    WHERE INITCAP(last_name)='Gates') ;  --19 rez   

SELECT last_name, hire_date
FROM employees
WHERE (hire_date, salary) IN (SELECT hire_date, salary
                              FROM employees
                              WHERE INITCAP(last_name)='Gates');   
                              
SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
                    FROM employees
                    WHERE INITCAP(last_name)='King');
                    --ORA-01427: o subinterogare de o singura linie returneaza mai mult decât o linie                         
                              
--avem 2 King
17-06-1987
30-01-1996
                              
SELECT last_name, hire_date
FROM employees
WHERE hire_date >any (SELECT hire_date  --mai mare ca minimul
                      FROM employees
                      WHERE INITCAP(last_name)='King')
order by hire_date;   
Whalen	17-09-1987
Kochhar	21-09-1989
Hunold	03-01-1990
Ernst	21-05-1991
De Haan	13-01-1993
Mavris	07-06-1994
Higgins	07-06-1994

SELECT last_name, hire_date
FROM employees
WHERE hire_date >all (SELECT hire_date  --mai mare ca maximul
                    FROM employees
                    WHERE INITCAP(last_name)='King')
order by hire_date; 

Bell	04-02-1996
Hartstein	17-02-1996
Sully	04-03-1996
Abel	11-05-1996
Mallin	14-06-1996
Weiss	18-07-1996
McEwen	01-08-1996
Russell	01-10-1996
Partners	05-01-1997
Davies	29-01-1997

Daca subcererea intoarce o multime de valori, se va folosi in cererea
parinte unul din operatorii IN, NOT IN, ANY, ALL.
WHERE col1 = ANY (SELECT …)  == WHERE col1 IN (SELECT …)
WHERE col1 > ANY (SELECT …) ==  mai mare ca minimul;
WHERE col1 < ANY (SELECT …) == mai mic ca maximul;
WHERE col1 > ALL (SELECT …) == mai mare ca maximul;
WHERE col1 < ALL (SELECT …) == mai mic ca minimul;
WHERE col 1 != ALL (SELECT …)  == WHERE col1 NOT IN (SELECT …)

2. Folosind subcereri, scrieþi o cerere pentru a afiºa numele ºi salariul pentru toþi colegii (din acelaºi departament)
lui Gates. Se va exclude Gates.

SELECT last_name, salary
FROM employees
WHERE department_id In (SELECT department_id -- = 
                        FROM employees
                        WHERE LOWER(last_name)='gates')
AND LOWER(last_name) <> 'gates';  --44 rez

SELECT last_name, salary
FROM employees
WHERE department_id = (SELECT department_id 
                        FROM employees
                        WHERE LOWER(last_name)='gates')
AND LOWER(last_name) <> 'gates';  --44 rez

--King

SELECT last_name, salary, department_id
FROM employees
WHERE department_id In (SELECT department_id  -- nu merege pt =
                        FROM employees
                        WHERE LOWER(last_name)='king')
AND LOWER(last_name) <> 'king';

--incorect
SELECT last_name, salary, department_id
FROM employees
WHERE department_id = (SELECT department_id  -- nu merege pt =
                        FROM employees
                        WHERE LOWER(last_name)='king')
AND LOWER(last_name) <> 'king';
--ORA-01427: o subinterogare de o singura linie returneaza mai mult decât o linie

3.. Folosind subcereri, sã se afiºeze numele ºi salariul angajaþilor conduºi direct de preºedintele 
companiei (acesta este considerat angajatul care nu are manager).
select last_name, salary
from employees
where manager_id = (select employee_id
                      from employees
                      where manager_id is null); --14 rez
                      
select last_name, salary
from employees
where manager_id in (select employee_id
                      from employees
                      where manager_id is null); --14 rez                      

4. Scrie?i o cerere pentru a afiºa numele, codul departamentului ?i salariul angaja?ilor al cãror cod de departament 
?i salariu coincid cu codul departamentului ?i salariul unui angajat care câ?tigã comision.

SELECT department_id, salary 
FROM employees 
WHERE commission_pct IS NOT NULL ; -- 35 rez

SELECT last_name, department_id, salary
FROM employees 
WHERE (department_id, salary) IN ( SELECT department_id, salary 
                                    FROM employees 
                                    WHERE commission_pct IS NOT NULL ); --34 REZ                                  
                                    
5. sã se afi?eze codul, numele ?i salariul tuturor angaja?ilor care ca?tigã mai mult 
decât salariul mediu pentru job-ul corespunzãtor ?i lucreazã într-un departament cu cel pu?in unul 
dintre angaja?ii al cãror nume con?ine litera “t”. Vom considera salariul mediu al unui job ca fiind egal 
cu media aritmeticã a limitelor sale admise (specificate în coloanele min_salary, max_salary din tabelul JOBS).

SELECT e.employee_id,e.last_name,e.salary 
FROM employees e 
WHERE e.salary > ( SELECT (j.min_salary+j.max_salary)/2 
                  FROM jobs j 
                  WHERE j.job_id=e.job_id )
AND e.department_id IN ( SELECT department_id
                          FROM employees 
                          WHERE  LOWER(last_name) LIKE '%t%' ); --24 rez

SELECT e.employee_id,e.last_name,e.salary 
FROM employees e 
WHERE e.salary > ( SELECT (j.min_salary+j.max_salary)/2 
                  FROM jobs j 
                  WHERE j.job_id=e.job_id )
AND e.job_id IN ( SELECT job_id     
                  FROM employees m 
                  WHERE e.department_id=m.department_id 
                  AND LOWER(m.last_name) LIKE '%t%' ); --21 rez

 -- lucreaza pe acelasi job ca si colegii de departament care contin litera t                  
                  
6. Scrieti o cerere pentru a afi?a angaja?ii care câ?tigã mai mult decât oricare func?ionar (job-ul conþine ºirul “CLERK”). Sorta?i rezultatele dupa salariu, în ordine descrescãtoare.
Ce rezultat este returnat dacã se înlocuieºte “ALL” cu “ANY”?
SELECT * 
FROM employees e 
WHERE salary > ALL ( SELECT salary  ---mai mare ca maximul
                    FROM employees 
                    WHERE upper(job_id) LIKE '%CLERK%' )
order by salary;     ---4400 .... 24000               

SELECT salary 
FROM employees 
WHERE upper(job_id) LIKE '%CLERK%'
order by 1; --2100.....4200

SELECT * 
FROM employees e 
WHERE salary > any ( SELECT salary  ---mai mare ca minimul
                    FROM employees 
                    WHERE upper(job_id) LIKE '%CLERK%' )
order by salary; --2200 -24000
--106 rez

--Care este salariul minim din firma?
select min(salary) --2100
from employees;

--Care este salariatul cu salariul minim?
select *
from employees
where salary = (select min(salary) --2100
                from employees);
                --132	TJ	Olson	TJOLSON	650.124.8234	10-04-1999	ST_CLERK	2100		121	50
??? 
de ce nu merge:
select last_name,  min(salary)  ----Care este salariatul cu salariul minim?
from employees;
--ORA-00937: nu exista o functie de grupare de tip grup singular
--Aflam spre finalul lab acesta

7.. Scrieþi o cerere pentru a afiºa numele salariatului, numele departamentului ºi salariul angajaþilor 
care câºtigã comision,dar al cãror ºef direct nu câºtigã comision.(modificata)

select e.last_name, d.department_name, e.salary
from employees e, departments d
where e.department_id = d.department_id(+) -- ca sa tinem cont si de cei care nu au setat departamentul
and e.commission_pct is not null 
and e.manager_id in (select a.employee_id  -- al cãror ºef direct nu câºtigã comision
                      from employees a 
                      where a.commission_pct is null);

---GRUPARE
select max(salary)
from employees; --24000

select  department_id, max(salary)
from employees
group by department_id;

100	12000
30	11000
null 7000
90	24000
20	13000
70	10000
110	12000
50	8200
80	14000
40	6500
60	9000
10	4400

select salary
from employees
where department_id =60
order by 1;
4200
4800
4800
6000
9000

select count(*)
from employees; --107 rez

select count(*), department_id
from employees
group by department_id;
6	100
6	30
1	null
3	90
2	20
1	70
2	110
45	50
34	80
1	40
5	60
1	10

select count(department_id), department_id --nu ia in considereare valori null
from employees
group by department_id;

select count(employee_id), department_id
from employees
group by department_id;

-- Sa se afiseze valoarea medie a comisionului in firma
CORECT:
SELECT AVG(commission_pct) as MEDIE
FROM employees; --0,2228571428571428571428571428571428571429

SELECT SUM(commission_pct)/COUNT(commission_pct) as "MEDIE", COUNT(commission_pct)
FROM employees; --0,2228571428571428571428571428571428571429 , 35

INCORECT ( de ce? ) :
SELECT SUM(commission_pct)/COUNT(*) as "MEDIE GRESITA", count(*)
FROM employees; --0,072897196261682242990654205607476635514 , 107

Sa scriem o cerere pentru a afisa pentru fiecare job titlul,
codul si valorile comisioanelor nenule ale angajatilor ce-l
practica. Se vor afisa si comisioanele angajatilor pentru care nu
se cunoaste jobul, dar care au comision.

SELECT NVL(j.job_title,'Necunoscut') AS "JOBUL", j.job_id, e.commission_pct
FROM employees e, jobs j
WHERE e.job_id=j.job_id(+)
AND e.commission_pct IS NOT NULL
ORDER BY j.job_id,e.commission_pct; --35 rez

Sa se afiseze valoarea medie a comisioanelor cunoscute la nivel de job
= media comisioanelor pt fiecare job(la care lucreaza angajati ce au comisionul setat)

SELECT NVL(j.job_title,'Necunoscut') AS "JOBUL", j.job_id, avg( e.commission_pct)
FROM employees e, jobs j
WHERE e.job_id=j.job_id(+)
AND e.commission_pct IS NOT NULL
group BY j.job_id; --ORA-00979: nu este o expresie GROUP BY


SELECT NVL(j.job_title,'Necunoscut') AS "JOBUL", j.job_id, avg( e.commission_pct)
FROM employees e, jobs j
WHERE e.job_id=j.job_id(+)
AND e.commission_pct IS NOT NULL
group BY j.job_id, j.job_title;
--Sales Representative	SA_REP	0,21
--Sales Manager	SA_MAN	0,3
!!!!!!
Toate coloanele si expresiile de proiectie (din SELECT)
care NU sunt functii de grup TREBUIE scrise in GROUP BY !!!

--job-urile care au media comisioanelor mai mare de 0.25
!!!!!!!NUUUUUUUUUUUUUUUUUU
SELECT NVL(j.job_title,'Necunoscut') AS "JOBUL", j.job_id, avg( e.commission_pct)
FROM employees e, jobs j
WHERE e.job_id=j.job_id(+)
AND e.commission_pct IS NOT NULL
and avg( e.commission_pct)>0.25  --ORA-00934: functia de grupare nu este permisa aici
group BY j.job_id, j.job_title;

--job-urile care au media comisioanelor mai mare de 0.25
SELECT NVL(j.job_title,'Necunoscut') AS "JOBUL", j.job_id, avg( e.commission_pct)
FROM employees e, jobs j
WHERE e.job_id=j.job_id(+)
AND e.commission_pct IS NOT NULL
group BY j.job_id, j.job_title
having avg( e.commission_pct)>0.25;
--Sales Manager	SA_MAN	0,3

11. Sã se afiºeze cel mai mare salariu, cel mai mic salariu, suma ºi media salariilor tuturor angajaþilor. 
Etichetaþi coloanele Maxim, Minim, Suma, respectiv Media. Sã se rotunjeascã rezultatele.

select max(salary) Maxim, min(salary) MINIM, sum(salary) TOTAL, round(avg(salary)) MEDIA
from employees;
--24000	2100	691400	6462

12. Sã se afiºeze minimul, maximul, suma ºi media salariilor pentru fiecare job.

select job_id, max(salary) Maxim, min(salary) MINIM, sum(salary) TOTAL, round(avg(salary)) MEDIA, 
        count(employee_id) NR_ang
from employees
group by job_id; --19 rez


13. Sã se afiºeze numãrul de angajaþi pentru fiecare job.

select job_id, count(*)
from employees
group by job_id; --19 rez

14. Sã se determine numãrul de angajaþi care sunt ºefi. Eticheta?i coloana “Nr. manageri”.
Observa?ie: Este necesar cuvântul cheie DISTINCT. Ce obþinem dacã îl omitem?
select distinct manager_id
from employees
where manager_id is not null; --18 rez

--lista sefilor angajatilor
select distinct manager_id
from employees; --19 (deoarece nu l am exclus pe cel cu null)

select count(distinct manager_id)
from employees; --18 sefi

select count(distinct manager_id)
from employees
where manager_id is not null;

15.. Sã se afiºeze diferenþa dintre cel mai mare ?i cel mai mic salariu mediu pe departamente. 
Eticheta?i coloana “Diferenta”.

select max(salary) - min(salary), department_id, count(*)
from employees
group by department_id;

16.. Scrieþi o cerere pentru a se afiºa numele departamentului, locaþia, numãrul de angajaþi ºi
salariul mediu pentru angajaþii din acel departament. Coloanele vor fi etichetate corespunzãtor.
Observa?ie: În clauza GROUP BY se trec obligatoriu toate coloanele prezente în clauza SELECT,
care nu sunt argument al funcþiilor grup (a se vedea ultima observaþie de la punctul I).


select department_name, city, count(employee_id), round(avg(salary))
from employees e, departments d, locations l
where d.department_id = e.department_id
and d.location_id= l.location_id
group by d.department_id; 
--ORA-00979: nu este o expresie GROUP BY
select department_name, city, count(employee_id), round(avg(salary))
from employees e, departments d, locations l
where d.department_id = e.department_id
and d.location_id= l.location_id
group by d.department_id,  department_name, city;

17. Sã se afiºeze codul ºi numele angajaþilor care câstigã mai mult decât 
salariul mediu din firmã. Se va sorta rezultatul în ordine descrescãtoare a salariilor.

select employee_id, last_name, salary
from employees
where salary> (select avg(salary)
                from employees)
order by salary desc;        --51 rez    
--123	Vollman	6500

17". Sã se afiºeze codul ºi numele angajaþilor care câstigã mai mult decât 
salariul mediu din departamentul in care lucreaza. Se va sorta rezultatul în ordine descrescãtoare a salariilor.

select e.employee_id, e.last_name, e.salary, department_id
from employees e
where e.salary> (select avg(a.salary)
                from employees a
                where a.department_id = e.department_id)
order by  e.salary desc;  --38 rez

--141	Rajs	3500 50

select avg(a.salary)
from employees a
where a.department_id = 50; --3475,555555555555555555555555555555555556


select employee_id, salary
from employees a
where a.department_id = 50
order by 2;
---------------------------------------------------------------
--lab 11 
18. Pentru fiecare ºef, sã se afiºeze codul sãu ºi salariul celui mai pu?in platit subordonat al sãu. 
Se vor exclude cei pentru care codul managerului nu este cunoscut. De asemenea, se vor exclude grupurile 
în care salariul minim este mai mic de 4000$. Sortaþi rezultatul în ordine descrescãtoare a salariilor.

select e.manager_id, min(e.salary)
from employees e
where e.manager_id is not null --Se vor exclude cei pentru care codul managerului nu este cunoscut
group by e.manager_id
having min(salary) >4000 --se vor exclude grupurile în care salariul minim este mai mic de 4000$.
order by 2; --12 rez

19. Pentru departamentele in care salariul maxim depãºeºte 7000$, sã se obþinã codul, numele acestor 
departamente ºi salariul maxim pe departament.

SELECT D.DEPARTMENT_ID,D.DEPARTMENT_NAME,MAX(E.SALARY)
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID,D.DEPARTMENT_NAME
HAVING MAX(E.SALARY)>7000; --9 rez

--sã se obþinã codul, numele acestor departamente ºi salariul mediu pe departament.(pt fiecare departament)

SELECT D.DEPARTMENT_ID,D.DEPARTMENT_NAME,round(avg(E.SALARY)), max(salary)
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID,D.DEPARTMENT_NAME;


22. Sã se afiºeze maximul salariilor medii pe departamente.
Vrem SUPER-AGREGAREA: Maximul salariului mediu per departament.

SELECT D.DEPARTMENT_ID,D.DEPARTMENT_NAME,max(round(avg(E.SALARY)))
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID,D.DEPARTMENT_NAME; --ORA-00937: nu exista o functie de grupare de tip grup singular

SELECT MAX(round(AVG(SALARY)))
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID; --19333

--pt a afisa si id-ul si denumirea departamentului care are cel mai mare salariu mediu

SELECT D.DEPARTMENT_ID,D.DEPARTMENT_NAME,round(avg(E.SALARY))
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID,D.DEPARTMENT_NAME
having round(avg(E.SALARY)) = (SELECT MAX(round(AVG(SALARY)))
                                FROM EMPLOYEES E,DEPARTMENTS D
                                WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
                                GROUP BY E.DEPARTMENT_ID );
 


