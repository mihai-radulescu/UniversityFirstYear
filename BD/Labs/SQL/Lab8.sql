1.	a) S� se afi�eze informa�ii despre angaja�ii al c�ror salariu dep�e�te 
valoarea medie a salariilor colegilor s�i de departament.
SELECT  e.last_name, e.salary, e.department_id
FROM    employees e
WHERE   e.salary > (SELECT   AVG(salary)
        /*24000*/  FROM     employees
                  WHERE    department_id = e.department_id); --38 rez
                                              /*90*/
  
  select avg(salary)
  from employees
  where department_id = 90; --19333,3333333333333333333333333333333333
  
  select *
  from employees
  where department_id = 90;
100	Steven	King	SKING	515.123.4567	17-06-1987	AD_PRES	24000			90
101	Neena	Kochhar	NKOCHHAR	515.123.4568	21-09-1989	AD_VP	17000		100	90
102	Lex	De Haan	LDEHAAN	515.123.4569	13-01-1993	AD_VP	17000		100	90
  
  select avg(salary)
  from employees
  group by department_id;
  
SELECT  last_name, salary, department_id, (SELECT   AVG(salary)
                                            FROM     employees
                                            WHERE    department_id = e.department_id) media
FROM    employees e
WHERE   salary > (SELECT   AVG(salary)
                  FROM     employees
                  WHERE    department_id = e.department_id);  
                  
b) Analog cu cererea precedent�, afi��ndu-se �i numele departamentului, media salariilor 
acestuia �i num�rul de angaja�i. Se cer 2 solu?ii (cu subcerere nesincronizat� �n clauza FROM ?i
cu subcerere sincronizat� �n clauza SELECT).

 select count(*)
  from employees
  where department_id = 90;
   I -   subcerere sincronizat� �n clauza SELECT
   
SELECT  last_name, salary, department_id,
        (SELECT   round(AVG(salary))
          FROM     employees
          WHERE    department_id = e.department_id) Media,
       (select department_name
       from departments
       where department_id = e.department_id)  Nume_dept,
       (select count(*)
       from employees
       where department_id = e.department_id ) nr_ang
FROM    employees e
WHERE   salary > (SELECT   AVG(salary)
                  FROM     employees
                  WHERE    department_id = e.department_id);   
                  
     II -subcerere nesincronizat� �n clauza FROM 
select last_name, salary, d.department_id, round(k.medie), d.department_name, k.nr_ang
from employees e, (select  department_id dep_id, count(employee_id) nr_ang, (avg(salary)) medie
                    from employees
                    group by department_id) k,  departments d
where e.department_id = k.dep_id
and salary > k.medie 
and d.department_id = e.department_id; --38 rez

2.	S� se afi�eze numele �i salariul angaja�ilor al c�ror salariu este mai mare 
dec�t salariile medii din toate departamentele. 
Se cer 2 variante de rezolvare: cu operatorul ALL ?i cu func�ia MAX.
select (avg(salary))
from employees
group by department_id;

select max(avg(salary))
from employees
group by department_id;

select last_name, first_name, salary
from employees
where salary > (select max(avg(salary))
                from employees
                group by department_id); --King	Steven	24000

select last_name, first_name, salary
from employees
where salary > all (select (avg(salary))
                    from employees
                    group by department_id);               

3.	S� se afi?eze numele ?i salariul celor mai pu?in pl�ti?i angaja?i din fiecare departament 
(3 solu?ii: cu ?i f�r� sincronizare, subcerere �n clauza FROM).
I - cu sincoronizare:
select e1.last_name, e1.first_name, e1.salary, e1.department_id
from employees e1
where e1.salary = ( select min(e2.salary)
                    from employees e2
                    where e1.department_id = e2.department_id); --12 rez
                    

II - fara sincronizare
select e2.department_id, min(e2.salary)
from employees e2
where department_id is not null
group by e2.department_id;

II - fara sincronizare
select e1.last_name, e1.first_name, e1.salary
from employees e1
where (e1.department_id,  e1.salary) IN (select e2.department_id, min(e2.salary)
                                        from employees e2
                                        where department_id is not null
                                        group by e2.department_id); --12 rez
--nuuuu                                       
 select e1.last_name, e1.first_name, e1.salary, e1.department_id, 
                  (select min(e2.salary)
                    from employees e2
                    where e1.department_id = e2.department_id) sal_minim_din_Dept
from employees e1
where ( e1.salary) IN (select  min(e2.salary)
                      from employees e2
                      group by e2.department_id);
Mavris	Susan	6500	40	6500
Vollman	Shanta	6500	50	2100
Sarchand	Nandita	4200	50	2100                                        

III- Subcerere in clauza FROM
select e.last_name, e.salary
from employees e, (select min(salary) as sal, department_id
                  from employees
                  group by department_id )aux
where aux.sal = e.salary 
and e.department_id = aux.department_id;

4.	Pentru fiecare departament, s� se ob?in� denumirea acestuia ?i numele salariatului
av�nd cea mai mare vechime din departament. S� se ordoneze rezultatul dup� numele departamentului.
I - cu sincronizare:
select d.department_name, e.last_name
from departments d, employees e
where e.department_id = d.department_id
and e.hire_date = (
                    select min(e1.hire_date)
                    from employees e1
                    where e.department_id = e1.department_id
                    )
 order by 1;--12 rez
 
 II - fara sincronizare
select d.department_name, e.last_name
from departments d, employees e
where e.department_id = d.department_id
and (e.hire_date, e.department_id) in (select min(e1.hire_date), e1.department_id
                                        from employees e1
                                        where e1.department_id is not null
                                        group by e1.department_id)
order by 1;

III- Subcerere in clauza FROM

select d.department_name, e.last_name
from departments d, employees e, (select min(e1.hire_date) hire, e1.department_id dep_id
                                        from employees e1
                                        group by e1.department_id) aux
where e.department_id = d.department_id
and  e.department_id = aux.dep_id
and e.hire_date= aux.hire
order by 1;

8.	S� se determine loca�iile �n care se afl� cel pu�in un departament.
Observa?ie: Ca alternativ� a lui EXISTS, poate fi utilizat operatorul IN. Scrie�i �i aceast� variant� de rezolvare.
select l.location_id, l.city
from locations l
where exists (select 'x'
              from departments d
              where d.location_id = l.location_id); --7 rez
              
select distinct l.location_id, city
from locations l, departments d
where l.location_id = d.location_id;

Observa?ie: Ca alternativ� a lui EXISTS, poate fi utilizat operatorul IN. Scrie�i �i aceast� variant� de rezolvare.
select l.location_id, l.city
from locations l
where l.location_id in  (select location_id
                        from departments d
                       );
 
5.	S� se ob?in� numele salaria?ilor care lucreaz� �ntr-un departament �n care exist� 
cel pu?in un angajat cu salariul egal cu salariul maxim din departamentul 30.

SELECT last_name, salary, department_id
FROM    employees e  --e.department_id
WHERE EXISTS (SELECT 1    
              FROM  employees
              WHERE e.department_id = department_id  -- in acelasi departament cu linia candidat
              AND salary = (SELECT MAX(salary)
                            FROM    employees
                            WHERE department_id =30));    
Observa?ie: Deoarece nu este necesar ca instruc�iunea SELECT interioar� 
(subcererea) s� returneze o anumit� valoare, se poate selecta o constant� (�x�, 1 etc.).
De altfel, din punct de vedere al performan�ei, selectarea unei constante este mai
eficient� dec�t selectarea unei coloane, nemaifiind necesar� accesarea datei respective.
SELECT distinct department_id   
              FROM  employees
              --WHERE e.department_id = department_id 
              where   salary = (SELECT MAX(salary)
                              FROM    employees
                            WHERE department_id =30);
                            30,80

9.	S� se determine departamentele �n care nu exist� nici un angajat.
Observa?ie: Se va utiliza NOT EXISTS. Acest exemplu poate fi rezolvat �i printr-o subcerere necorelat�, 
utiliz�nd operatorul NOT IN (vezi laboratorul 3). Aten�ie la valorile NULL! (fie pune�i condi�ia
IS NOT NULL �n subcerere, fie utiliza�i func�ia NVL). Scrie�i �i aceast� variant� de rezolvare.

select department_id, department_name
from departments d -- d.department_id
where not exists ( select employee_id  --select 1
                  from employees e
                  where e.department_id = d.department_id); --16 dep
                  
 select distinct department_id 
 from employees; --apare null
 
 select department_id, department_name
from departments d
where department_id not in (select distinct department_id 
                             from employees
                             where department_id is not null
                             ); 
select department_id
from departments d
minus
select distinct department_id 
from employees
where department_id is not null;

7.	S� se afi�eze codul, numele �i prenumele angaja�ilor care au cel pu�in doi subord_directi. 
--Pt fiecare angajat sa afisam id-ul si numele sau complet impreuna cu
-- id-ul si numele  managerului sau.

Select e.employee_id, e.last_name||' '||e.first_name,e. manager_id,
        (select m.last_name||' '||m.first_name
        from employees m
        where m.employee_id =e.manager_id)
from employees e; --107 linii


--managerii cu numarul de subord_directi
select manager_id, count(*)
from employees
where manager_id is not null
group by manager_id
order by 1;--18 rezultate

select *
from(select manager_id, count(*) nr
      from employees
      where manager_id is not null
      group by manager_id) aux
where aux.nr >=2
order by 1; --15 rezultate

select e.employee_id, e.last_name, e.first_name
from(select manager_id, count(*) nr
      from employees
      where manager_id is not null
      group by manager_id) aux, employees e
where aux.nr >=2
and e.employee_id =aux.manager_id
order by 1; 

SELECT employee_id, last_name, first_name
FROM employees e
WHERE 2 <= (SELECT COUNT(*)
            FROM employees p
            WHERE p.manager_id = e.employee_id);
                           --15 rezultate     
            
SELECT employee_id, last_name, first_name
FROM employees e
WHERE exists (SELECT COUNT(*)
            FROM employees
            WHERE manager_id = e.employee_id
            having count(*)>=2); -- 15 rez
            
 IV. [Clauza WITH]
� Cu ajutorul clauzei WITH se poate defini un bloc de cerere �nainte ca acesta s� fie utilizat �ntr-o interogare.
� Clauza permite reutilizarea aceluia�i bloc de cerere �ntr-o instruc�iune SELECT complex�. 
Acest lucru este util atunci c�nd o cerere face referin�� de mai multe ori la acela�i bloc de cerere, 
care con�ine opera�ii join �i func�ii agregat.

10. Utiliz�nd clauza WITH, s� se scrie o cerere care afi�eaz� numele departamentelor 
�i valoarea total� a salariilor din cadrul acestora. 
Se vor considera departamentele a c�ror valoare total� a salariilor 
este mai mare dec�t media valorilor totale ale salariilor tuturor angajatilor.(sum(sal_dep)/nr_dept)
WITH val_dep AS (
                  select department_name, sum(salary) as suma_Per_dept
                  from departments d, employees e
                  where e.department_id =d.department_id
                  group by department_name ),
val_medie AS (select sum(suma_Per_dept)/count(*) as medie 
              from val_dep )  --62218,1818181818181818181818181818181818
SELECT * 
FROM val_dep
WHERE suma_Per_dept > (SELECT medie FROM val_medie) 
ORDER BY department_name;     
--Sales	304500
--Shipping	156400

11. S� se afi�eze codul, prenumele �i numele (pe aceea�i coloan�), codul job-ului �i data angaj�rii,
ale subordona�ilor direc�i ai lui Steven King care au cea mai mare vechime.

with subord_directi as (select employee_id, last_name, first_name, hire_date
                        from employees
                        where manager_id = (select employee_id
                                            from employees
                                            where initcap(first_name) ='Steven'
                                            and initcap(last_name) ='King')),
 vechime_maxima as ( select min(hire_date) maxim
                    from subord_directi) --21-09-1989
select * 
from subord_directi
where hire_date = (select maxim from vechime_maxima);
--101	Kochhar	Neena	21-09-1989

11". S� se afi�eze codul, prenumele �i numele (pe aceea�i coloan�), codul job-ului �i data angaj�rii,
ale subalternii subordona�ilor direc�i ai lui Steven King care au cea mai mare vechime.  

with subord_directi as (select employee_id, last_name, first_name, hire_date
                    from employees
                    where manager_id = (select employee_id
                                        from employees
                                        where initcap(first_name) ='Steven'
                                        and initcap(last_name) ='King')),
 subalterni as (select employee_id, last_name, first_name, hire_date
               from employees
               where manager_id in (select employee_id
                                    from subord_directi)),     --82 rez                                  
 vechime_maxima as ( select min(hire_date) maxim
                    from subalterni) --17-09-1987
select * 
from subalterni
where hire_date = (select maxim from vechime_maxima); --200	Whalen	Jennifer	17-09-1987

V. [Analiza top-n]
Pentru aflarea primelor n rezultate ale unei cereri, este util� func?ia ROWNUM. 
Aceasta returneaz� num�rul de ordine al unei linii �n rezultat. Condi?ia ce utilizeaz� 
aceast� func?ie trebuie aplicat� asupra unei mul?imi ordonate de �nregistr�ri. Cum ob?inem acea mul?ime?

-- care sunt primele 10 randuri din employees?

select employee_id, last_name, first_name, salary
from employees
where rownum <=10;

100	King	Steven	24000
101	Kochhar	Neena	17000
102	De Haan	Lex	17000
103	Hunold	Alexander	9000
104	Ernst	Bruce	6000
105	Austin	David	4800
106	Pataballa	Valli	4800
107	Lorentz	Diana	4200
108	Greenberg	Nancy	12000
109	Faviet	Daniel	9000

select employee_id, last_name, first_name, salary
from employees
order by salary desc;

100	King	Steven	24000
101	Kochhar	Neena	17000
102	De Haan	Lex	17000
145	Russell	John	14000
146	Partners	Karen	13500
201	Hartstein	Michael	13000
108	Greenberg	Nancy	12000
147	Errazuriz	Alberto	12000
205	Higgins	Shelley	12000
168	Ozer	Lisa	11500
174	Abel	Ellen	11000
148	Cambrault	Gerald	11000

--NUUUUUUUU
select employee_id, last_name, first_name, salary
from employees
where rownum <=10
order by salary desc;

100	King	Steven	24000
101	Kochhar	Neena	17000
102	De Haan	Lex	17000
108	Greenberg	Nancy	12000
103	Hunold	Alexander	9000
109	Faviet	Daniel	9000
104	Ernst	Bruce	6000
105	Austin	David	4800
106	Pataballa	Valli	4800
107	Lorentz	Diana	4200

12. S� se detemine primii 10 cei mai bine pl�ti�i angaja�i.

select *
from (select employee_id, last_name, first_name, salary
      from employees
      order by salary desc) t
where rownum<=10;

100	King	Steven	24000
101	Kochhar	Neena	17000
102	De Haan	Lex	17000
145	Russell	John	14000
146	Partners	Karen	13500
201	Hartstein	Michael	13000
108	Greenberg	Nancy	12000
147	Errazuriz	Alberto	12000
205	Higgins	Shelley	12000
168	Ozer	Lisa	11500


Care sunt top 7 salarii cele mai mari si cine este platit cu acele salarii?

with salarii7 as ( select * 
                  from (select distinct salary
                          from employees 
                          order by salary desc)
                  where rownum<=7)
select employee_id, salary
from employees
where salary in (select * from salarii7); --10 angajati
            

13. S� se determine cele mai slab pl�tite 3 job-uri, din punct de vedere al mediei salariilor acestora.
select *
from (select job_id, avg(salary) medie
      from employees
      group by job_id
      order by medie asc
) where rownum < 4;