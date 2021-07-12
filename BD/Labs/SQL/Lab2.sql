Select to_char(-7, '9999.999')
from dual; --    -7.000

Select to_char(12345, '9999.99')
from dual; --######## nu se incadreaza in formatul in care vreau afisarea


Select to_char(12345, '99999.99')
from dual; -- 12345.00

Select to_char(12345, '99999999.999')
from dual; --    12345.000

select tO_DATE('26-MAR-2019','dd-mon-yyyy')
from dual;
select to_char( TO_DATE('26-MAR-2019','dd-mon-yyyy'), 'HH24:MI')
from dual; --00:00

select substr('Informatica', -5)
from dual; --atica

select substr('Informatica', 2, 3)
from dual; --nfo

select substr('Informatica', 2,1)
from dual;
--22. Sã se listeze numele tuturor angaja?ilor care au a treia literã din nume ‘A’.(no case-sensitive)
select last_name, first_name
from employees
where lower(substr(last_name, 3,1)) = 'a'; --3 rezultate
--Grant	Kimberely
--Grant	Douglas
--Whalen	Jennifer

select rtrim('infoxXXX               ') 
from dual;

select rtrim('infoxXXX               ') rt
from dual;

select ltrim('                             infoxXXX') lt
from dual;

select ('                             infoxXXX') lt
from dual; --                             infoxXXX

select ltrim('                             infoxXXX         ') lt
from dual;  --sterge spatille doar din stanga string-ului

select rtrim('infoxXXX', 'X')
from dual; --infox

select rtrim('infoxXXX ', 'X')
from dual; --infoxXXX are spatiu la final -> deci nu sterge nimic

select rtrim('infoxXXXyXXXyyyyy', 'Xy')
from dual;--infox
select rtrim('infoxXXXyXXmXyyyyy', 'Xy')
from dual;--infoxXXXyXXm

select ltrim('XXXXXXXinfoxXXX', 'X')
from dual; --infoxXXX

select rtrim('infoxXXXx', 'x')
from dual; --infoxXXX

select trim(Both 'X' from 'XXXinfoxXXX')
from dual; --infox

select ( '        XXXinfoxXXX         ')
from dual;

select trim(Both from '        XXXinfoxXXX         ') Afis
from dual; --XXXinfoxXXX
--echivalente
select trim('        XXXinfoxXXX         ') Afis
from dual; --XXXinfoxXXX

select replace('a$$b$aab$a', '$')
from dual;  --abaaba

select replace('a$$b$aab$a', '$', 'c')
from dual;
--accbcaabca

select replace('a$$b$aab$a', '$$', 'c')
from dual;
--acb$aab$a


1. Scrieþi o cerere care are urmãtorul rezultat pentru fiecare angajat:
<prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3 ori mai mare>. 
Etichetati coloana “Salariu ideal”. Pentru concatenare, utilizaþi atât funcþia CONCAT cât ºi operatorul “||”.
select concat (concat( concat (first_name, concat( ' ', last_name))  , ' castiga ' ), salary) ||
      ' lunar dar doreste ' || salary * 3 || '.' "Salariu ideal"
from employees;

select concat(concat(concat(concat(first_name,' '), last_name), ' castiga '), 
        concat(salary || ' lunar dar doreste ',salary * 3)) ||'.'
      as "Salariu ideal_MNG"
from employees; --107 rezultate


3. Sã se afiºeze, pentru angajaþii cu prenumele „Steven”, codul ºi numele acestora, 
precum ºi codul departamentului în care lucreazã. Cãutarea trebuie sã nu fie case-sensitive, 
iar eventualele blank-uri care preced sau urmeazã numelui trebuie ignorate.

select last_name,first_name, employee_id, department_id
from employees
where lower(trim(first_name)) ='steven';

Select first_name, last_name,employee_id, department_id
from employees
where trim(lower(first_name)) ='steven';

select employee_id, trim(first_name)||' '|| trim (last_name) Nume_mng, department_id
from employees
where trim(lower(first_name)) ='steven';

select trim(first_name), employee_id, last_name, department_id
from employees
where trim(upper(first_name)) like 'STEVEN';

select trim(first_name), employee_id, last_name, department_id
from employees
where trim(upper(first_name)) = 'STEVEN';

select last_name,first_name, employee_id, department_id
from employees
where lower(trim(first_name)) like 'steven';
select last_name,first_name, employee_id, department_id
from employees
where lower(trim(both from first_name)) like 'steven';

----------------------------------------------------------------------------
5. Sã se afiºeze detalii despre salariaþii care au lucrat un numãr întreg de sãptãmâni pânã la data curentã.

--data de ieri
select sysdate-1
from dual;

--observati ora si minutul
select to_char((sysdate-1), 'HH24:MI')
from dual; --19:29
--13:41
--17:42
--19:33

select sysdate-(sysdate-1), to_char( sysdate, 'DD-MM-YYYY HH24:MI'), to_char( sysdate-1, 'DD-MM-YYYY HH24:MI')
from dual;


select sysdate- to_date('09-03-2021', 'DD-MM-YYYY') Exact, 
        round(sysdate- to_date('09-03-2021', 'DD-MM-YYYY')) Aproximativ,  
        to_char( sysdate, 'DD-MM-YYYY HH24:MI') Azi,
        to_char( to_date('09-03-2021', 'DD-MM-YYYY') , 'DD-MM-YYYY HH24:MI') data_de_ieri
from dual; --1,73421296296296296296296296296296296296
--1,81134259259259259259259259259259259259
--1,42256944444444444444444444444444444444 --ora 10:08
--1,42436342592592592592592592592592592593 --ora 10:11

select sysdate- to_date('03-03-2021', 'DD-MM-YYYY') Exact, 
        round(sysdate- to_date('03-03-2021', 'DD-MM-YYYY')) Aproximativ,  
        to_char( sysdate, 'DD-MM-YYYY HH24:MI') Azi,
        to_char( to_date('03-03-2021', 'DD-MM-YYYY') , 'DD-MM-YYYY HH24:MI') data_de_ieri
from dual;
--1,57143518518518518518518518518518518519	2	04-03-2021 13:42	03-03-2021 00:00
--1,73824074074074074074074074074074074074	2	04-03-2021 17:43	03-03-2021 00:00


select to_char( to_date('02-03-2021', 'DD-MM-YYYY'), 'HH24:MI')
from dual; 

Select (sysdate-hire_date)  --numarul de zile lucrate
from employees
order by employee_id;

Select round(sysdate-hire_date)
from employees
order by employee_id;
12315
11488
10278
11384
10881

Select employee_id, round(sysdate-hire_date),round(sysdate-hire_date)/7 nr_sapt,  mod(round(sysdate-hire_date),7) rest 
from employees;

5. Sã se afiºeze detalii despre salariaþii care au lucrat un numãr întreg de sãptãmâni pânã la data curentã.

select e.*, round(sysdate-hire_date) zile
from employees e
where mod(round(sysdate-hire_date),7)=0;

select employee_id, last_name, round(sysdate-hire_date) zile
from employees
where mod(round(sysdate-hire_date),7)=0;

Rezolvati individual exercitiile!
Pentru fiecare coloana afisata veti adauga un alias corespunzator urmat de " _abc" (unde abc reprezinta 3 initiale din numele vostru). Exemplu pentru student cu numele Popescu Andrei Marian: 
select last_name as Nume_PAM  from employees;
Fisierul transmis va contine: 
Enunt 1, Rezolvare , Numar de rezultate returnate, Print-screen cu rularea rezolvarii,
Enunt 2, Rezolvare , Numar de rezultate returnate, Print-screen cu rularea rezolvarii etc.
Pentru obtinerea unui punctaj maxim este nevoie sa respectati toate indicatiile transmise. 
Tema 1 - Ex 18,24,25 din Lab1, Ex 2,4,6,7 din Lab2


select to_date(sysdate, 'DD-MM-YYYY') - to_date(hire_date, 'DD-MM-YYYY')
from employees
order by employee_id;
12314
11487
10277
11383
10880
-------------------------------------------------------------------
-- Lab4
select next_day('10-MAR-2021','Monday')
from dual; --ziua din saptamâna nu este valida pt ca este setata limba in romana
select next_day('10-MAR-2021','Luni')
from dual; --15-03-2021
select next_day('8-MAR-2021','Luni') -- 8-MAR-2021 Luni
from dual; --15-03-2021
select next_day('7-MAR-2021','Luni')  --7-MAR-2021 Duminica
from dual; --08-03-2021

select last_day('11-MAR-2021')
from dual; --31-03-2021

select last_day('11-Feb-2021')
from dual; --28-02-2021

select last_day('11-Feb-2024')
from dual; --29-02-2024

select last_day('11-02-2024') --conversie implicata de ls string la Data_calendaristica
from dual; 

select last_day('2024-11-02')
from dual; --: literalul nu corespunde sirului de formatare

select last_day(to_date('2024-11-02', 'YYYY-DD-MM')) --conversie explicita de ls string la Data_calendaristica
from dual;  --29-02-2024

select TO_CHAR(TRUNC(SYSDATE), 'dd/mm/yyyy HH24:MI')
from dual; --11/03/2021 00:00

select TO_CHAR((SYSDATE), 'dd/mm/yyyy HH24:MI') Acum, TO_CHAR(Round(SYSDATE), 'dd/mm/yyyy HH24:MI') aproximativ
from dual; 
--11/03/2021 18:16	12/03/2021 00:00

8. Sã se afiºeze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile.

select  to_char(sysdate, 'Month,Day, DD_MM_YYYY HH24:MI:SS') AZI,
        to_char(sysdate+30, 'Month,Day, DD_MM_YYYY HH24:MI:SS') "Peste 30 de zile"
from dual;  
--Martie    ,Miercuri, 10_03_2021 18:20:01	Aprilie   ,Vineri  , 09_04_2021 18:20:01
--Martie    ,Joi     , 11_03_2021 12:16:50	Aprilie   ,Sâmbata , 10_04_2021 12:16:50
--Martie    ,Joi     , 11_03_2021 16:16:01	Aprilie   ,Sâmbata , 10_04_2021 16:16:01
--Martie    ,Joi     , 11_03_2021 18:18:59	Aprilie   ,Sâmbata , 10_04_2021 18:18:59

9. Sã se afiºeze numãrul de zile rãmase pânã la sfârºitul anului.


Select to_date('31-DEC-2021') - (sysdate), to_char(sysdate, 'dd-mm-yyyy HH24:MI')
from dual; 
--295,562708333333333333333333333333333333  ora 10:00
--295,31900462962962962962962962962962963  ora 16:23
--295,232800925925925925925925925925925926 ora 18:27
--294,483634259259259259259259259259259259	11-03-2021 12:23
-- 294,319375	11-03-2021 16:20

Select to_date('31-DEC-2021') - trunc(sysdate)
from dual;
--296
--295

select 365 - to_char(sysdate, 'DDD') "zile ramase" , to_char(sysdate, 'DDD') "ziua din an"--31+28+10
from dual; --296
--31(ian)+28(feb)+11(mar) =70
--295

select  to_char(to_date('31-DEC-2021'),'DDD') - to_char(sysdate, 'DDD') "zile ramase" ,
        to_char(sysdate, 'DDD') "ziua din an", --31+28+10
        to_char(to_date('31-DEC-2021'),'DDD') "ultima zi din an"
from dual; --296
--295	070	365

select to_char(sysdate, 'YYYY')

select  to_char(to_date('31-DEC-'|| to_char(sysdate,'YYYY')),'DDD') - to_char(sysdate, 'DDD') "zile ramase" ,
        to_char(sysdate, 'DDD') "ziua din an", --31+28+10
        to_char(to_date('31-DEC-'|| to_char(sysdate,'YYYY')),'DDD') "ultima zi din an",
        to_date('31-DEC-'|| to_char(sysdate,'YYYY')) "Data ultimei zile din an"
from dual; --296
--295	070	365	31-12-2021

--data_calendaristica + nr_de_zile => noua data calendaristica
10. a) Sã se afiºeze data de peste 12 ore.-- cat reprezinta 12 ore dintr o zi?


select  to_char(sysdate, 'DD_MM_YYYY HH24:MI:SS') acum, to_char(sysdate+ 0.5, 'DD_MM_YYYY HH24:MI:SS') IN_12_ore
from dual;
--10_03_2021 16:27:50	11_03_2021 04:27:50
--10_03_2021 18:38:05	11_03_2021 06:38:05
--11_03_2021 12:36:58	12_03_2021 00:36:58
--11_03_2021 16:28:20	12_03_2021 04:28:20
--11_03_2021 18:32:14	12_03_2021 06:32:14

b) Sã se afiºeze data de peste 5 minute
Obs: Cât reprezintã 5 minute dintr-o zi?

select to_char(sysdate, 'DD_MM_YYYY HH24:MI:SS') acum, 
        to_char(sysdate + (1/(24*12)),'DD_MM_YYYY HH24:MI:SS') PESTE_5_Min
from dual;
--11_03_2021 12:39:46	11_03_2021 12:44:46
--11_03_2021 16:30:47	11_03_2021 16:35:47

select to_char(sysdate, 'DD_MM_YYYY HH24:MI:SS') acum, 
        to_char(sysdate + (5/(24*60)),'DD_MM_YYYY HH24:MI:SS') PESTE_5_Min
from dual;
--10_03_2021 16:30:09	10_03_2021 16:35:09
--10_03_2021 18:40:21	10_03_2021 18:45:21
--11_03_2021 18:34:07	11_03_2021 18:39:07

select to_char(sysdate, 'DD_MM_YYYY HH24:MI:SS') acum, 
        to_char(sysdate + (1/24) *(1/12),'DD_MM_YYYY HH24:MI:SS') PESTE_5_Min
from dual;

11. Sã se afiºeze numele ºi prenumele angajatului (într-o singurã coloanã), data 
angajãrii ºi data negocierii salariului, care este prima zi de Luni dupã 6 luni 
de serviciu. Etichetaþi aceastã coloanã “Negociere”.

select last_name || ' '|| first_name  as "Nume si prenume angajat", hire_date, 
        next_day(add_months(hire_date, 6), 'Luni')  as Negociere, add_months(hire_date, 6)
from employees;

select last_name || ' ' ||first_name, hire_date "Data angajare",add_months(hire_date, 6) "Dupa 6 luni",
        next_day(add_months(hire_date, 6), 'Luni') "Prima zi de Luni"
from employees; --107 rezultate

-- salariatii a caror data obtinuta dupa trecerea a 6 luni de munca pica intr o zi de Luni

select last_name || ' ' ||first_name, hire_date "Data angajare",add_months(hire_date, 6) "Dupa 6 luni",
        next_day(add_months(hire_date, 6), 'Luni') "Prima zi de Luni"
from employees
where add_months(hire_date, 6) = next_day(add_months(hire_date, 6), 'Luni'); --incorecta

select last_name || ' ' ||first_name, hire_date "Data angajare",add_months(hire_date, 6) "Dupa 6 luni",
        next_day(add_months(hire_date, 6), 'Luni') "Prima zi de Luni", to_char(add_months(hire_date, 6),'Day')
from employees
where to_char(add_months(hire_date, 6),'D') = 1; --11 rezultate - 1=Luni, 2=Marti (local)

select last_name || ' ' ||first_name, hire_date "Data angajare",add_months(hire_date, 6) "Dupa 6 luni",
        next_day(add_months(hire_date, 6), 'Luni') "Prima zi de Luni", to_char(add_months(hire_date, 6),'Day') zi
from employees;
where (to_char(add_months(hire_date, 6),'Day')) = 'Luni';  --0 rezultate --incorect 
--'Luni    ' /= 'Luni'

select last_name || ' ' ||first_name, hire_date "Data angajare",add_months(hire_date, 6) "Dupa 6 luni",
        next_day(add_months(hire_date, 6), 'Luni') "Urmatoarea zi de Luni", to_char(add_months(hire_date, 6),'Day')
from employees
--where trim(to_char(add_months(hire_date, 6),'Day')) = 'Luni'; --11 rezultate
--where trim(to_char(add_months(hire_date, 6),'day')) = 'Luni'; --0 rezultate 'luni' =/ 'Luni'
where Initcap(trim(to_char(add_months(hire_date, 6),'day'))) = 'Luni';  --11 rezultate

select last_name || ' ' ||first_name, hire_date "Data angajare",add_months(hire_date, 6) "Dupa 6 luni",
        next_day(add_months(hire_date, 6), 'Luni') "Urmatoarea zi de Luni", to_char(add_months(hire_date, 6),'Day')
from employees
where lower(to_char(add_months(hire_date, 6),'Day')) like '%luni%'; --11 rezultate

select last_name || ' ' ||first_name, hire_date "Data angajare",add_months(hire_date, 6) "Dupa 6 luni",
        next_day(add_months(hire_date, 6), 'Luni') "Urmatoarea zi de Luni"
from employees
where add_months(hire_date, 6) = next_day(add_months(hire_date, 6)-1, 'Luni'); --11 rezultate


select Last_name|| ' '||first_name,hire_date ANgajare, next_day(add_months(hire_date, 6),'Luni')  Negociere
from employees;

12. Pentru fiecare angajat sã se afiºeze numele ºi numãrul de luni de la data 
angajãrii. Etichetaþi coloana “Luni lucrate”. Sã se ordoneze rezultatul dupã 
numãrul de luni lucrate. Se va rotunji numãrul de luni la cel mai apropiat numãr întreg.
Obs: În clauza ORDER BY, precizarea criteriului de ordonare se poate realiza ºi prin indicarea 
alias-urilor coloanelor sau a poziþiilor acestora în clauza SELECT.

select last_name, (months_between(sysdate, Hire_date)) "Luni lucrate"
from employees
order by "Luni lucrate" desc; --ordonare dupa alias
--King	404,823983721624850657108721624850657109
select last_name, round(months_between(sysdate, Hire_date)) "Luni lucrate"
from employees
order by "Luni lucrate" desc; --ordonare dupa alias
--King	405
select last_name, trunc(months_between(sysdate, Hire_date)) "Luni lucrate"
from employees
order by "Luni lucrate" desc;
--King	404

select last_name, round(months_between(sysdate, Hire_date),3) "Luni lucrate"
from employees
order by "Luni lucrate" desc; --ordonare dupa alias
----aproximare la 2 zecimale 11.03.21
King	404,82
Whalen	401,82
Kochhar	377,69
---aproximare la 3 zecimale
King	404,824
Whalen	401,824
Kochhar	377,695

--aproximare la 2 zecimale 10.03.21
King	404,8
Whalen	401,8
Kochhar	377,67

--aproximare la 3 zecimale ora 17:00
King	404,797
Whalen	401,797
Kochhar	377,668

--aproximare la 3 zecimale ora 19;00
King	404,8
Whalen	401,8
Kochhar	377,671

select last_name, round(months_between(sysdate, Hire_date)) "Luni lucrate"
from employees
order by 2 desc; -- ordonare dupa nr col afisate

select last_name, round(months_between(sysdate, Hire_date)) "Luni lucrate"
from employees
order by  round(months_between(sysdate, Hire_date))  desc; -- ordonare dupa expresia aritmetica

--functii diverse

select nvl(null, 1)
from dual; --1

select nvl(20, 1) --20 =/ null
from dual; -- 20

select nvl('a', 1)
from dual; --'a' --(pt ca 1 se coverteste automat la stringul '1')

select nvl(1.50, 10.50)
from dual; --1,5  --> tip number

select nvl('1.50', '10.50')
from dual; --1.50   --> string

select nvl(1, 'a') --> nvl(number, string)
from dual; -- vrea sa converteasca 'a' la number -->eroare

select  nvl(to_char(1.50), 'a') --> nvl( string, string); 1.50  este number
from dual; -- 1,5

--NVL2(exp1, exp2_daca_nu_este_null_exp1, exp3_Altfel)

select NVL2( 1, 20, 30) -- 1/= null
from dual; --20

select nvl(1,30) -- 1/= null
from dual;  --1

select NVL2( null, 20, 30)
from dual; --30

--obs:
select nvl(20, 1) --20 =/ null
from dual; -- 20

select nvl2(20,20, 1) --20 =/ null
from dual; --20


[Funcþii diverse]
select 1 + null, 2 * null
from dual; --null, null

select employee_id,salary, commission_pct, commission_pct*salary Valoare_comision_gresita,
        salary+ commission_pct*salary Venit_gresit
from employees
where employee_id in (100,101,145, 146); -- atentie la cei care au comisionul NULL!!!!!


select employee_id,salary, commission_pct, commission_pct*salary Valoare_comision_gresita,
        salary+ commission_pct*salary Venit_gresit,
       nvl(commission_pct,0)*salary Valoare_comision_corecta, salary+ nvl(commission_pct,0)*salary Venit_CORECT
from employees
where employee_id in (100,101,145, 146);

14. Sã se afiºeze numele angajaþilor ºi comisionul. Dacã un angajat nu câºtigã comision, sã se scrie “Fara comision”.
Etichetaþi coloana “Comision”.

select last_name || ' ' || first_name nume,nvl(to_char(commission_pct,'0.99'),'Fara comision') comision
from employees;

--Vargas Peter	Fara comision
--Russell John	 0.40
--Partners Karen	 0.30

SELECT last_name, NVL(to_char(commission_pct),'Fara comision') Comision  --nvl(string, string)
FROM employees; --corect
--Matos	Fara comision
--Vargas	Fara comision
--Russell	,4
--Partners	,3

SELECT last_name, NVL((commission_pct),'Fara comision') Comision  --Nvl(number, string)
FROM employees; -- 'Fara comision' este numar nevalid 

SELECT last_name, NVL((commission_pct),999999999999999999999999) Comision --nvl(number, number)
FROM employees; 

--Matos	999999999999999999999999
--Vargas	999999999999999999999999
--Russell	0,4
--Partners	0,3
select DECODE ('1', '2', '3', '4') --1=/2  else 4
from dual; --4  --> else
select DECODE ('1', '2', '3', '4', '5','6') --1=/2, 1=/4  else 6
from dual; --6
select DECODE ('1', '2', '3', '4', '5') --1=/2, 1=/4  else null
from dual; --null
select DECODE ('1', '2', '3', '1', '5') --1=/2, 1=1  ->5
from dual;--5
select DECODE ('1', '2', '3') --1=/2 else null
from dual; --null

[Instrucþiunea CASE, comanda DECODE]
16. Sã se afiºeze numele, codul job-ului, salariul ºi o coloanã care sã arate salariul dupã mãrire.
Se presupune cã pentru IT_PROG are loc o mãrire de 20%,
pentru SA_REP creºterea este de 25%, 
iar pentru SA_MAN are loc o mãrire de 35%. 
Pentru ceilalþi angajaþi nu se acordã mãrire. Sã se denumeascã coloana "Salariu renegociat".


SELECT last_name, job_id, salary, 
        Case upper(job_id)
        WHEN 'IT_PROG' THEN salary* 1.2
        WHEN 'SA_REP' THEN salary*1.25
        WHEN 'SA_MAN' THEN salary*1.35
        ELSE salary
        end 
        AS "Salariu renegociat"
FROM employees;

SELECT last_name, job_id, salary, 
        decode (upper(job_id),
        'IT_PROG', salary*1.2,
        'SA_REP', salary*1.25,
        'SA_MAN', salary*1.35,
        salary)
        AS "Salariu renegociat"
FROM employees;

--Matos	ST_CLERK	2600	2600
--Vargas	ST_CLERK	2500	2500
--Russell	SA_MAN	14000	18900
--Partners	SA_MAN	13500	18225

SELECT last_name, job_id, salary, salary+ salary*
        decode (upper(job_id),
        'IT_PROG', 0.2,
        'SA_REP', 0.25,
        'SA_MAN', 0.35,
        salary)
        AS "Salariu renegociat"
FROM employees;


SELECT last_name, job_id, salary, salary+ salary*
        decode (upper(job_id),
        'IT_PROG', 0.2,
        'SA_REP', 0.25,
        'SA_MAN', 0.35)
        AS "Salariu renegociat"
FROM employees;
--King	AD_PRES	24000	null
--Kochhar	AD_VP	17000	null
--De Haan	AD_VP	17000	null
--Hunold	IT_PROG	9000	10800
--Ernst	IT_PROG	6000	7200
--Austin	IT_PROG	4800	5760
[Join]
17. Sã se afiºeze numele salariatului, codul ºi numele departamentului pentru toþi angajaþii.
SELECT last_name, employees.department_id, departments.department_name
FROM employees, departments
WHERE employees.department_id=departments.department_id; --join-ul dintre cele 2 tabele
sau

SELECT last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id; --corect


SELECT last_name, e.department_id, e.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id; --incorect


Obs: Am realizat operaþia de join între tabelele employees ºi departments, pe baza coloanei comune department_id. Observaþi utilizarea alias-urilor. Ce se întâmplã dacã eliminãm condiþia de join?
Obs: Numele sau alias-urile tabelelor sunt obligatorii în dreptul coloanelor care au acelaºi nume în mai multe tabele. Altfel, nu sunt necesare dar este recomandatã utilizarea lor pentru o mai bunã claritate a cererii.

SELECT e.*, d.* --afisam toate coloanele din employees si din departments
FROM employees e, departments d
WHERE e.department_id=d.department_id;

SELECT last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id; --corect

SELECT last_name, department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id; --department_id este coloana definita ambiguu


SELECT last_name, e.department_id Id_dep_din_EMP,d.department_id ID_DEPT_DIN_DEPARTMENTS, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id;


SELECT last_name, e.department_id Id_dep_din_EMP,d.department_id ID_DEPT_DIN_DEPARTMENTS, d.department_name, 
    e.manager_id "Mng_direct_al_ang", d.manager_id "Mng dept _in_care_lucreaza_ang"
FROM employees e, departments d
WHERE e.department_id=d.department_id; --106

--Lorentz	60	60	IT	103	103
--Greenberg	100	100	Finance	101	108
--Faviet	100	100	Finance	108	108

