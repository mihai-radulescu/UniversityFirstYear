--Lab 5
--Pt fiecare salariat afisati id-ul, numele, id-ul de departamnet si denumirea departamentului in care lucreaza ei.
select employee_id, last_name, department_id, department_name
from employees, departments
where employees.department_id = departments.department_id; --:  department_id ->coloana definita ambiguu 


--corect : pentru a realiza un join între n tabele, va fi nevoie de cel puþin n – 1 condiþii de join.
select employee_id, last_name, employees.department_id, department_name
from employees, departments
where employees.department_id = departments.department_id
order by 2; --106 rez  (nu afiseaza pe salariatul 178)

--In employees sunt 107 angajati
--angajatul care nu are departamentul setat
select *
from employees
where department_id is null;  -- 1 ang
--178	Kimberely	Grant	KGRANT	011.44.1644.429263	24-05-1999	SA_REP	7000	0,15	149	null

select employee_id, last_name, employees.department_id, departments.DEPARTMENT_ID, department_name
from employees, departments
where employees.department_id = departments.department_id;

select employee_id, last_name, e.department_id, d.DEPARTMENT_ID, department_name
from employees e, departments d
where e.department_id = d.department_id;

select e.employee_id, e.last_name, e.department_id, d.DEPARTMENT_ID, e.department_name --"E"."DEPARTMENT_NAME": identificator nevalid
from employees e, departments d
where e.department_id = d.department_id;
--department_name nu exista in employees

--corect
select e.employee_id, e.last_name, e.department_id, d.DEPARTMENT_ID, d.department_name 
from employees e, departments d
where e.department_id = d.department_id;

--afisam toate coloanele atat din employees, cat si din departments
select e.*, d.*
from employees e, departments d
where e.department_id = d.department_id;

--Atentie!!!
select *
from employees e, departments d
where e.department_id = d.department_id;

select e.employee_id, e.last_name, e.department_id "ID_dept_afisat_din EMP", 
      d.DEPARTMENT_ID "Id_dept_afisat din DEPT", d.department_name,
    e.manager_id "Mng_direct_al_ang", d.manager_id "Mng_dept_in_care_lucr_ang"
from employees e, departments d
where e.department_id = d.department_id; --106 rez

                                                      King(100) sef dept 90
                                                      /         \
                                           Kochhar(101)         De Haan(102)    ---90
                                           /                         \
                       Greenberg(108)/*sef dept 100 */           Hunold(103) --- sef dept 60
               /      /      \     \       \                     /     |     |      \
          Faviet  Chen  Sciarra  Urman  Popp /* dept 100 */   Ernst  Austin Pataballa Lorentz   -- dept 60
                                                          
                                                            
 --produs cartezian
select e.employee_id, e.department_id, d.*
from employees e, departments d
order by 1;        --107 ang x 27 dept = 2889 linii       

select e.employee_id, e.department_id, d.*
from employees e cross join departments d
order by 1;  
                                        
--Sa se obtina lista tuturor posibilitatilor de amplasare a departamentelor firmei in orase.

SELECT department_id, city
FROM departments, locations; --621 rez = 27 dept X 23 orase

select city
from locations; --23 orase

SELECT department_id,city
FROM departments CROSS JOIN locations;


Sã se afiºeze pentru toþi  angajaþii    numele   salariatului, codul
departamentului ºi numele departamentului din care face parte.


--V1
select e.last_name, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e, departments d
where e.DEPARTMENT_ID = d.DEPARTMENT_ID; --106 linii

select e.last_name, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
from employees e join departments d on (e.DEPARTMENT_ID = d.DEPARTMENT_ID); 

--V2
select last_name, departments.department_id, department_name
from departments join employees
on (departments.department_id = employees.department_id);

select last_name, departments.department_id, department_name
from departments , employees
where departments.department_id = employees.department_id;

Sã se afiºeze numele job-ului, codul si numele angajatului, codul ºi numele departamentului
pentru toþi angajaþii care lucreazã în Oxford.

--incomplet
select j.job_title, e.employee_id, e.last_name, d.department_id, d.department_name, l.city
from jobs j join employees e on (j.job_id = e.job_id)
join departments d on (e.department_id = d.department_id)
join locations l on ( d.location_id = l.location_id); --106 rez

--numele departamentului care este localizat in Oxford.

select d.department_id, d.department_name
from departments d, locations l
where d.location_id =l.location_id
and lower(l.city) = 'oxford';
--80	Sales

--corect
select j.job_title, e.employee_id, e.last_name, d.department_id, d.department_name
from jobs j join employees e on (j.job_id = e.job_id)
join departments d on (e.department_id = d.department_id)
join locations l on ( d.location_id = l.location_id)
where lower(l.city)='oxford'; --34 rez

--corect
select j.job_title, e.employee_id, e.last_name, d.department_id, d.department_name
from  jobs j , employees e, departments d, locations l
where j.job_id= e.job_id
and e.department_id = d.department_id
and d.location_id = l.location_id
and lower(l.city) = 'oxford'; --34 rez

select j.job_title, e.employee_id, e.last_name, d.department_id, d.department_name
from jobs j join employees e using (job_id)
join departments d using (department_id)
join locations l using ( location_id )
where lower(l.city)='oxford'; --ORA-25154: componenta coloana a clauzei USING nu poate avea specificator

select j.job_title, e.employee_id, e.last_name, department_id, d.department_name -- atentie! s-a scos aliasul tabelei 
from  jobs j join employees e using  (job_id)                                    -- din fata coloanei department_id
join departments d using (department_id)
join locations l using (location_id) 
where lower(l.city) = 'oxford'; --34 rez


--afisati pentru fiecare salariat numele jobului pe care lucreaza el

select job_id, j.job_title, e.employee_id, e.last_name
from  jobs j join employees e using  (job_id); --107 rezultate

select job_id, j.job_title, e.employee_id, e.last_name
from  jobs j  natural join employees e; --107 rezultate


-- Observatie!!!!
select last_name, e.manager_id, department_id, department_name
from employees e join departments using (department_id); --106 reziltate

select last_name, e.manager_id, department_id, department_name
from employees e natural join departments; -- coloana utilizata în asocierea NATURAL nu poate avea specificator

--Observam ca { department_id, manage_id} sunt comune in tabelele employees, departments

select employee_id, last_name,manager_id, department_id, department_name
from employees e natural join departments;   
--department_id + manager_id -> 32 rezultate  De ce?
-- angajatii pentru care  managerul direct este si manager de departament in care lucreaza ei

select employee_id,last_name, e.manager_id,d.manager_id, e.department_id, department_name
from employees e, departments d
where e.department_id = d.Department_id
and e.manager_id = d.manager_id;

select last_name, manager_id, department_id, department_name
from employees e join departments using (department_id, manager_id);

--101	Kochhar	100	100	90	Executive
--102	De Haan	100	100	90	Executive
--104	Ernst	103	103	60	IT
--105	Austin	103	103	60	IT
--106	Pataballa	103	103	60	IT
--107	Lorentz	103	103	60	IT

--self join
1. Scrie?i o cerere pentru a se afisa numele, luna (în litere) ºi anul angajãrii pentru to?i salaria?ii 
din acelasi departament cu Gates, al cãror nume conþine litera “a”. Se va exclude Gates. 
Se vor da 2 soluþii pentru determinarea apariþiei literei “A” în nume. De asemenea, pentru una din metode 
se va da ºi varianta join-ului conform standardului SQL3.

select e1.last_name, to_char(e1.hire_date, 'MON-YYYY')
from employees e1, employees e2
where (e1.last_name != 'Gates')
and (e2.last_name = 'Gates')
and (e1.department_id = e2.department_id)
and (e1.last_name like '%a%');

--nu este rezolvarea
select e1.department_id
from employees e1
where  lower(e1.last_name) = 'gates'; --info despre Gates

--colegii lui Gates : angajatii(in afara de Gates) care lucreaza in dept 50
select e2.last_name
from employees e2
where e2.department_id = 50
and lower(e2.last_name) like '%a%'
and lower( e2.last_name) != 'gates'  -- pt a nu l afisa pe gates ca fiind coleg de departament cu el insusi
order by 1;  
--23 rezultate

--corect
select e2.last_name Colegi
from employees e2,  -- info despre colegi de departament ai lui Gates
employees e1 --info despre gates
where  lower(e1.last_name) = 'gates' --- in e1. ... am informatii coresp lui Gates (e1.department_id avem departamentul in care lucreaza Gates)
and e2.department_id = e1.department_id
and lower(e2.last_name) like '%a%'
and lower( e2.last_name) != 'gates' 
order by 1; 
--23 rezultate


-----------------------------------------------------------
--self join
2.	Sã se afi?eze codul ºi numele angajaþilor care lucreazã în acela?i departament 
cu cel puþin un angajat al cãrui nume conþine litera “t”. Se vor afiºa, de asemenea, 
codul ºi numele departamentului respectiv. Rezultatul va fi ordonat alfabetic dupã nume.
Daþi ºi soluþia care utilizeazã sintaxa specificã Oracle (anterioarã SQL3) pentru join. 

--angajatii care contin litera "t"

select e2.last_name, e2.department_id
from employees e2  -- angajati al cãror nume conþine litera “t”
where lower(e2.last_name) like '%t%'
order by 2;  --32 rez
--Hartstein	20
--Tobias	30
--Everett	50
--Taylor	50
--Grant	50
--Matos	50
--Gates	50
--Atkinson	50
--Philtanker	50
--Stiles	50
--Patel	50
--Bissot	50

SELECT e1.employee_id "id colegi", e1.last_name"nume colegi",
      e1.department_id "id_dept colegi", d.department_name "denumire dept", 
      e2.last_name "Cu cine sunt colegi", e2.department_id
FROM employees e1,  --colegii
employees e2,  ---cei care contin litera t -> e2.department_id gasim departamenele celor care contin litera t
departments d  -- pt numele departamentului
WHERE e1.department_id = e2.department_id 
      AND e1.department_id = d.department_id -- pt denumirea de dept
      AND LOWER(e2.last_name) LIKE '%t%'
ORDER BY e1.last_name;--atentie

SELECT distinct e1.employee_id "id colegi", e1.last_name"nume colegi",
      e1.department_id "id_dept colegi", d.department_name "denumire dept", 
      e2.last_name "Cu cine sunt colegi", e2.department_id
FROM employees e1,  --colegii
employees e2,  ---cei care contin litera t -> e2.department_id gasim departamenele celor care contin litera t
departments d  -- pt numele departamentului
WHERE e1.department_id = e2.department_id 
      AND e1.department_id = d.department_id -- pt denumirea de dept
      AND LOWER(e2.last_name) LIKE '%t%'
ORDER BY e1.last_name;--atentie

SELECT  e1.employee_id, e1.last_name, e1.department_id, d.department_name ---distinct elimina duplicatele
FROM employees e1, 
employees e2,  ---cei care contin litera t
departments d  -- pt numele departamentului
WHERE e1.department_id = e2.department_id 
      AND e1.department_id = d.department_id
      AND LOWER(e2.last_name) LIKE '%t%'
ORDER BY e1.last_name; --13 X Abel

SELECT distinct e1.employee_id, e1.last_name, e1.department_id, d.department_name ---distinct elimina duplicatele
FROM employees e1, 
employees e2,  ---cei care contin litera t
departments d  -- pt numele departamentului
WHERE e1.department_id = e2.department_id 
      AND e1.department_id = d.department_id
      AND LOWER(e2.last_name) LIKE '%t%'
ORDER BY e1.last_name; --100 rez
---------------------------------------------------------------------------------------------------------


--nonequijoin
6.	Sã se modifice cererea de la problema 2 astfel încât sã afi?eze codul, numele ?i salariul 
tuturor angaja?ilor care ca?tigã mai mult decât salariul mediu pentru job-ul corespunzãtor
?i lucreazã într-un departament cu cel pu?in unul dintre angaja?ii al cãror nume con?ine litera “t”. 
Vom considera salariul mediu al unui job ca fiind egal cu media aritmeticã a limitelor sale admise
(specificate în coloanele min_salary, max_salary din tabelul JOBS).;

SELECT distinct e1.employee_id, e1.last_name, e1.department_id, d.department_name ---distinct elimina duplicatele
FROM employees e1, 
employees e2,  ---cei care contin litera t
departments d  -- pt numele departamentului
,jobs j
WHERE e1.department_id = e2.department_id 
      AND e1.department_id = d.department_id
      AND LOWER(e2.last_name) LIKE '%t%'
      and e1.job_id = j.job_id  --pt a face filtrarea in fct de media salariala a job-ului pe care lucreaza fieacre salariat
      and e1.salary > (j.MIN_SALARY + j.MAX_SALARY)/2
ORDER BY e1.last_name; --24 rez

--incorect
SELECT distinct e1.employee_id, e1.last_name, e1.department_id, d.department_name,e1.salary "sal Angajat",
(j.MIN_SALARY + j.MAX_SALARY)/2 "Sal mediu", e1.job_id "Job din EMP", j.job_id "Job din JOBS" ---distinct elimina duplicatele
FROM employees e1, 
employees e2,  ---cei care contin litera t
departments d  -- pt numele departamentului
,jobs j
WHERE e1.department_id = e2.department_id 
      AND e1.department_id = d.department_id
      AND LOWER(e2.last_name) LIKE '%t%'
      --and e1.job_id = j.job_id  --pt a face filtrarea in fct de media salariala a job-ului pe care lucreaza fieacre salariat
      and e1.salary > (j.MIN_SALARY + j.MAX_SALARY)/2
ORDER BY e1.last_name; --24 rez

188	Chung	50	Shipping	3800	3500	SH_CLERK	ST_CLERK  
--Job-ul SH-CLERTK are salariul mediu de 4000

--corect
SELECT distinct e1.employee_id, e1.last_name, e1.department_id, d.department_name,e1.salary "sal Angajat",
(j.MIN_SALARY + j.MAX_SALARY)/2 "Sal mediu", e1.job_id "Job din EMP", j.job_id "Job din JOBS" ---distinct elimina duplicatele
FROM employees e1, 
employees e2,  ---cei care contin litera t
departments d  -- pt numele departamentului
,jobs j
WHERE e1.department_id = e2.department_id 
      AND e1.department_id = d.department_id
      AND LOWER(e2.last_name) LIKE '%t%'
      and e1.job_id = j.job_id  --pt a face filtrarea in fct de media salariala a job-ului pe care lucreaza fieacre salariat
      and e1.salary > (j.MIN_SALARY + j.MAX_SALARY)/2
ORDER BY 1; --24 rez
--184	Sarchand	50	Shipping	4200	4000	SH_CLERK	SH_CLERK
--185	Bull	50	Shipping	4100	4000	SH_CLERK	SH_CLERK
--201	Hartstein	20	Marketing	13000	12000	MK_MAN	MK_MAN
--206	Gietz	110	Accounting	8300	6600	AC_ACCOUNT	AC_ACCOUNT

--corect
SELECT UNIQUE e1.employee_id, e1.last_name, e1.salary
FROM employees e1 
JOIN employees e2 ON (e2.department_id = e1.department_id)
JOIN jobs j ON (j.job_id = e1.job_id)
WHERE LOWER(e2.last_name) LIKE '%t%' --INSTR(LOWER(e2.last_name), 't') != 0)
AND e1.salary > (j.min_salary + j.max_salary) / 2
ORDER BY e1.last_name;

select distinct a.employee_id, a.last_name, a.department_id, c.department_name, a.salary
from employees a, employees b, departments c, jobs j
WHERE lower(b.last_name) like '%t%'
and a.department_id = b.department_id
and a.department_id = c.department_id
and a.job_id = j.JOB_ID
and a.salary > (j.max_salary+j.min_salary)/2
order by 2; --24 rez

-- de rezolvat
4.	Sã se afi?eze codul departamentului, numele departamentului, numele ?i job-ul 
tuturor angaja?ilor din departamentele al cãror nume conþine ºirul ‘ti’. De asemenea,
se va lista salariul angajaþilor, în formatul “$99,999.00”. Rezultatul se va ordona alfabetic
dupã numele departamentului, ºi în cadrul acestuia, dupã numele angajaþilor.

--outer join
3.	Sã se afi?eze numele, salariul, titlul job-ului, oraºul ºi þara în care lucreazã angaja?ii 
condu?i direct de King. Daþi douã metode de rezolvare a acestui exerciþiu.

select m.employee_id
from employees m
where lower(m.last_name) = 'king';

--100
--156

---Care sunt subordonatii salariatului 156
select last_name
from employees
where manager_id =156; -- 0 rezultate

select last_name
from employees
where manager_id =100; -- 14 rezultate

select s.employee_id, s.last_name, m.employee_id
from employees m, employees s
where lower(m.last_name) = 'king'
and s.manager_id = m.employee_id; --14 subordonati ai managerului 100



select e.employee_id, e.last_name, e.salary, j.job_title, l.city, c.country_name
from employees m, employees e, jobs j, departments d, locations l, countries c
where lower(m.last_name) = 'king'
and e.manager_id = m.employee_id
and e.job_id = j.job_id
and e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id; --14 rez


3" .Sã se afi?eze numele, salariul, titlul job-ului, oraºul ºi þara în care lucreazã 
angaja?ii condu?i direct de Zlotkey.
Daþi douã metode de rezolvare a acestui exerciþiu.

select *
from employees 
where department_id is null;

select * from employees where employee_id =149; --Zlotkey

select last_name
from employees
where manager_id =149; --6 rezultate

--subordonatii lui Zlotkey
select s.employee_id, s.last_name, m.employee_id "Manager", s.department_id "Dept in care lucreaza ang"
from employees m, employees s
where initcap(m.last_name) = 'Zlotkey'
and s.manager_id = m.employee_id; --6 rez

174	Abel	149	80
175	Hutton	149	80
176	Taylor	149	80
177	Livingston	149	80
178	Grant	149	null
179	Johnson	149	80

select s.employee_id, s.last_name, m.employee_id, s.department_id
from employees m, employees s
where initcap(m.last_name) = 'Zlotkey'
and s.manager_id = m.employee_id;--6 rezultate

select s.employee_id, s.last_name, m.employee_id, s.department_id, l.city, c.COUNTRY_NAME
from employees m, employees s, jobs j,departments d,  locations l, countries c
where initcap(m.last_name) = 'Zlotkey'
and s.manager_id = m.employee_id
and j.job_id = s.job_id
and d.department_id = s.department_id 
and d.location_id = l.LOCATION_ID
and l.COUNTRY_ID = c.COUNTRY_ID; --5 rezultate ?????


select s.employee_id, s.last_name, m.employee_id, s.department_id, d.department_name
from employees m, employees s /*subalterni*/, departments d
where initcap(m.last_name) = 'Zlotkey'
and s.manager_id = m.employee_id
and  d.department_id = s.department_id;

select s.employee_id, s.last_name, m.employee_id, s.department_id, d.department_name
from employees m, employees s, departments d
where initcap(m.last_name) = 'Zlotkey'
and s.manager_id = m.employee_id
and  d.department_id(+) = s.department_id; --+ pune null la informatiile despre departament

select s.employee_id, s.last_name, m.employee_id, s.department_id, l.city, c.COUNTRY_NAME
from employees m, employees s, jobs j,departments d,  locations l, countries c
where initcap(m.last_name) = 'Zlotkey'
and s.manager_id = m.employee_id
and j.job_id = s.job_id
and d.department_id(+) = s.department_id
and d.location_id = l.LOCATION_ID
and l.COUNTRY_ID = c.COUNTRY_ID; 


select s.employee_id, s.last_name, m.employee_id, s.department_id, l.city, c.COUNTRY_NAME
from employees m, employees s, jobs j,departments d,  locations l, countries c
where initcap(m.last_name) = 'Zlotkey'
and s.manager_id = m.employee_id
and j.job_id = s.job_id
and d.department_id(+) = s.department_id
and d.location_id = l.LOCATION_ID(+)
and l.COUNTRY_ID = c.COUNTRY_ID(+); --6 rezultate 

--rezolvarea finala
select e.employee_id, e.last_name, e.salary, j.job_title, l.city, c.country_name
from employees m, employees e, jobs j, departments d, locations l, countries c
where lower(m.last_name) = 'king'
and e.manager_id = m.employee_id
and e.job_id = j.job_id
and e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
and l.country_id = c.country_id(+); --14 rez

select e.employee_id, e.last_name, e.salary, j.job_title, l.city, c.country_name
from employees m join  employees e on (e.manager_id = m.employee_id)
join jobs j on (e.job_id = j.job_id) 
left join departments d on (e.department_id = d.department_id)
left join locations l on d.location_id = l.location_id
left join countries c on l.country_id = c.country_id
where lower(m.last_name) = 'king';

select e.employee_id, e.last_name, e.salary, j.job_title, l.city, c.country_name
from employees m join  employees e on (e.manager_id = m.employee_id)
join jobs j on (e.job_id = j.job_id) 
left join departments d on (e.department_id = d.department_id)
left join locations l on d.location_id = l.location_id
left join countries c on l.country_id = c.country_id
where lower(m.last_name) = 'zlotkey';


7.	Sã se afiºeze numele salariaþilor ºi numele departamentelor în care lucreazã.
Se vor afiºa ºi salariaþii care nu au asociat un departament. (outer join, 2 variante).

select e. last_name, e.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id; --106 rezultate
 --pt salariatul 178 e. department_id este null
 
select e. last_name, e.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id = d.department_id(+); --107 rezultate

select e. last_name, e.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where  d.department_id(+) = e.department_id ; --107 rezultate

select e. last_name, e.department_id, d.department_name, d.LOCATION_ID
from employees e left outer join departments d
on e.department_id = d.department_id; --107 rezultate

select e. last_name, e.department_id, d.department_name, d.LOCATION_ID
from departments d  right outer join employees e
on e.department_id = d.department_id; --107 rezultate

8.	Sã se afiºeze numele departamentelor ºi numele salariaþilor care lucreazã 
în ele. Se vor afiºa ºi departamentele care nu au salariaþi. (outer join, 2 variante)

select e. last_name, e.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id(+) = d.department_id; --atentie e.department_id

select e. last_name, d.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id(+) = d.department_id;

select e. last_name, e.department_id "id de dept din emp",d.department_id "Id-ul dep (afis din DERT)"
,  d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id(+) = d.department_id; --106 + 16(dept la care nu lucreaza nimeni) = 122 rezultate

select e.last_name, d.department_id, d.department_name, d.LOCATION_ID
from employees e right outer join departments d
on e.department_id = d.department_id; --122 rezultate

select e. last_name, d.department_id, d.department_name, d.LOCATION_ID
from departments d  left outer join employees e
on e.department_id = d.department_id; --122 rezultate

9.	Cum se poate implementa full outer join?  
Sã se afiºeze numele salariaþilor ºi numele departamentelor în care lucreazã.
Se vor afiºa ºi salariaþii care nu au asociat un departament, 
cat si departamentele in care nu lucreaza niciun salariat. (outer join, 2 variante).

--ORA-01468: un predicat poate referi numai o tabela anexata de tip cu întoarcere erori
select e. last_name, e.department_id ,d.department_id,  d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id(+) = d.department_id(+); --incorect

select e. last_name, d.department_id, d.department_name, d.LOCATION_ID
from departments d  full outer join employees e
on e.department_id = d.department_id; -- 106+16+1 =123

select e.last_name, e.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id = d.department_id(+) --106+1
union
select e.last_name, e.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id(+) = d.department_id; --106+16
-- Corect: 106+1+16 rezultate
--Dar returneaza 121 ?!?!??!


--corect
select e.employee_id,e.last_name, d.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id = d.department_id(+) --106+1
union
select e.employee_id,  e.last_name, d.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id(+) = d.department_id; --106+16
--123 rezultate

--ORA-01789: blocul de interogare are numarul coloanelor rezultat incorect
--atentie la nr de coloane afisate
select e.employee_id,e.last_name, d.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id = d.department_id(+) --106+1
union
select e.last_name, d.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id(+) = d.department_id; --106+16

--ORA-01790: expresia trebuie sa aiba acelasi tip de data ca si expresia corespondenta
--atentie la tipurile de date ale coloanelor
select e.employee_id,e.last_name, d.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id = d.department_id(+) --106+1
union
select  e.last_name, e.employee_id, d.department_id, d.department_name, d.LOCATION_ID
from employees e, departments d
where e.department_id(+) = d.department_id; --106+16
----------------------------------------------------------------------------------------------------------------

10.	Se cer codurile departamentelor al cãror nume conþine ºirul “re” sau în care 
lucreazã angajaþi având codul job-ului “SA_REP”.
--codurile departamentelor al cãror nume conþine ºirul “re”
select department_id "Id de departamente"
from departments
where lower(department_name) like '%re%'
Union
-- codurile departamentelor în care lucreazã angajaþi având codul job-ului “SA_REP”.
select department_id "Id2"
from employees 
where lower(job_id) like 'sa_rep'; --9 rez (unul este null)

--codurile departamentelor al cãror nume conþine ºirul “re”
select department_id "Id de departamente"
from departments
where lower(department_name) like '%re%'
Union all
-- codurile departamentelor în care lucreazã angajaþi având codul job-ului “SA_REP”.
select department_id "Id2"
from employees 
where lower(job_id) like 'sa_rep';


--corect
--numele departamentelor al cãror nume conþine ºirul “re”
select department_name "Nume departamente"
from departments
where lower(department_name) like '%re%'
Union
-- numele departamentelor în care lucreazã angajaþi având codul job-ului “SA_REP”.
select department_name "Nume2"
from employees e, departments d
where lower(job_id) like 'sa_rep'
and e.department_id = d.department_id; --8 rez

--ATENTIE!!!!
--ORA-01790: expresia trebuie sa aiba acelasi tip de data ca si expresia corespondenta !
--numele departamentelor al cãror nume conþine ºirul “re”
select department_name "Nume departamente"
from departments
where lower(department_name) like '%re%'
Union
-- codurile departamentelor în care lucreazã angajaþi având codul job-ului “SA_REP”.
select d.department_id "Nume2"
from employees e, departments d
where lower(job_id) like 'sa_rep'
and e.department_id = d.department_id; 

--ATENTIE!!!!
--functioneaza
--numele departamentelor al cãror nume conþine ºirul “re”
select department_name "Nume departamente", To_char(department_id)
from departments
where lower(department_name) like '%re%'
Union
--numele angajaþilor având codul job-ului “SA_REP”.
select last_name "Nume angajat", job_id
from employees e, departments d
where lower(job_id) like 'sa_rep'
and e.department_id = d.department_id; --35 rez


--codurile departamentelor al cãror nume conþine ºirul “re”
select department_id "Id de departamente"
from departments
where lower(department_name) like '%re%'
Union
-- codurile departamentelor în care lucreazã angajaþi având codul job-ului “SA_REP”.
select d.department_id "Id2"
from employees e, departments d
where lower(job_id) like 'sa_rep'
and e.department_id = d.department_id; --8 rez

--union all
select department_name "Nume departamente"
from departments
where lower(department_name) like '%re%'
Union all
-- codurile departamentelor în care lucreazã angajaþi având codul job-ului “SA_REP”.
select department_name "Nume2"
from employees e, departments d
where lower(job_id) like 'sa_rep'
and e.department_id = d.department_id; --36 rez

--codurile departamentelor al cãror nume conþine ºirul “re”
select department_name "Nume departamente", 'Departament'
from departments
where lower(department_name) like '%re%'
Union all
-- codurile departamentelor în care lucreazã angajaþi având codul job-ului “SA_REP”.
select department_name "Nume2", last_name
from employees e, departments d
where lower(job_id) like 'sa_rep'
and e.department_id = d.department_id; --36 rez


select (d.department_id)
from departments d
where lower(d.department_name) like '%re%' 
union
select (e.department_id)
from  employees e
where upper(e.job_id) like '%SA_REP%' ;

--atentie
select (d.department_id)
from departments d
where lower(d.department_name) like '%re%' 
union all
select (e.department_id)
from  employees e
where upper(e.job_id) like 'SA_REP' ;

12.	Se cer codurile departamentelor al cãror nume conþine ºirul “re” ºi în care 
lucreazã angajaþi având codul job-ului “HR_REP”. 

--codurile departamentelor al cãror nume conþine ºirul “re”
select department_id "Id de departamente"
from departments
where lower(department_name) like '%re%'
Intersect
-- codurile departamentelor în care lucreazã angajaþi având codul job-ului “HR_REP”.
select d.department_id "Id2"
from employees e, departments d
where lower(job_id) like 'hr_rep'
and e.department_id = d.department_id; -- 1 rez : Dep 40


select d.department_id "Id2"
from employees e, departments d
where lower(job_id) like 'hr_rep'
and e.department_id = d.department_id
and  lower(department_name) like '%re%'; -- 1 rez : Dep 40
---------------------------------------------------------------


11.	Sã se ob?inã codurile departamentelor în care nu lucreazã nimeni 
(nu este introdus nici un salariat în tabelul employees). Se cer douã soluþii (MINUS, NOT IN).
Observa?ie: Operatorii pe mulþimi pot fi utilizaþi în subcereri. 
Coloanele care apar în clauza WHERE a interogãrii trebuie sã corespundã, 
ca numãr ºi tip de date, celor din clauza SELECT a subcererii. 
Comenta?i necesitatea tratãrii valorilor null în varianta utilizãrii operatorului NOT IN. 

Solu?ie:;

SELECT d.department_id
FROM departments d ---lista tututor departamentelor din firma
MINUS
SELECT UNIQUE department_id
FROM employees; --lista departamentelor in care lucreaza angajatii
--16 rez

SELECT d.department_id
FROM departments d ---lista tututor departamentelor din firma
MINUS
SELECT department_id
FROM employees;

SELECT d.department_id
FROM departments d ---lista tututor departamentelor din firma
MINUS
SELECT department_id
FROM employees; --lista departamentelor in care lucreaza angajatii

select distinct department_id
from employees; --12 (+null)

-subcerere
select d.department_id
from departments d
where d.department_id not in ( SELECT UNIQUE department_id
                                 FROM employees e); --contine null

--corect
select d.department_id
from departments d
where d.department_id not in ( SELECT UNIQUE dd.department_id
                                 FROM employees e, departments dd
                                 where e.department_id = dd.department_id);        

SELECT department_id
FROM departments
WHERE department_id NOT IN (
                              SELECT d.department_id
                              FROM departments d
                              JOIN employees e ON(d.department_id=e.department_id)
                              );
