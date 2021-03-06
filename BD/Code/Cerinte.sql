-- Cerinta 11

-- 1
-- Pentru toate produsele din categoriile al caror nume incepe cu "Pant" se va 
-- afisa stoclu total. Daca in stoc sunt mai putin de 30 de produse stocul se 
-- considera limit. Categoria pantofi are prioritate fata de categoria pantaloni. 
-- Am utilizat; clauza CASE, 2 operatii de join, LIKE, clauza DECODE

select cat.categorie_id, cat.numecategorie, p.titlu, suma.Stoc, 
case
    when suma.stoc = 0 then 'Stoc epuizat'
    when suma.Stoc <= 30 then 'Stoc limitat'
    else 'Stoc suficient'
end DetaliStoc
from categorie cat
inner join produs p on cat.categorie_id = p.categorie_id
inner join (select produs_id, sum(cantitate) as Stoc from StocDepozit
            group by produs_id) suma
on suma.produs_id = p.produs_id 
where cat.numecategorie like 'Pant%' and p.produs_id in suma.produs_id
order by decode(
    cat.numecategorie,
    'Pantaloni', 'B',
    'Pantofi', 'A',
    'Z'
);

-- 2
-- Pentru fiecare utilizator afiseaza ultima data cand a facut o achizitie
-- Pentru fiecare utilizator, dorim sa afisam id-ul ultimei comenzi si data
-- cand a fost plasata aceasta.
-- Am utilizat: clauza WITH, grupare de date, operatie de join, subcerere 
-- sincronizata.

with UltimaComanda(utilizator_id, MaxData) as
    (select utilizator_id, Max(data) as MaxData from comanda
    group by utilizator_id)
select u.utilizator_id, u.nume, u.prenume, MaxData, 
(select comanda_id from comanda where comanda.utilizator_id = u.utilizator_id) as "Numar comanda"
from utilizator u
inner join UltimaComanda k
on u.utilizator_id = k.utilizator_id;

-- 3
-- Dorim sa aflam toti utilizatorii care au facut o comanda in ultima luna, dar 
-- excludem utilizatorii care nu au tip "Utilizator" sau null.
-- Am utilizat: nvl, add_months, subcerere sincronizata.

select u.utilizator_id, u.nume, u.prenume, (select comanda_id from comanda 
    where comanda.utilizator_id = u.utilizator_id
    and comanda.data >= ADD_MONTHS((select current_date from dual), -1)) as "Id Comanda" 
from utilizator u
where u.tip = nvl('Utilizator', initcap('utilizator'))
order by utilizator_id;

-- 4
-- Dorim sa afisam toate produsele comandate de un utilizator in ultimele 3 luni
-- ordonate dupa id-ul comenzii.
-- Am utilizat: subcerere sincronizata, add_months, join intre 4 tabele.

select c.utilizator_id, u.nume, u.prenume, pc.comanda_id, p.produs_id, p.titlu from produs p 
inner join plasarecomanda pc on pc.produs_id = p.produs_id
inner join comanda c on c.comanda_id = pc.comanda_id
inner join utilizator u on u.utilizator_id = c.utilizator_id 
where exists
    (select comanda_id from comanda 
        where comanda.utilizator_id = 1 and 
        comanda.comanda_id = pc.comanda_id and 
        comanda.data >= ADD_MONTHS((select current_date from dual), -3))
order by c.comanda_id;

-- 5
-- Dorim sa vedem cat am pierde din profitul nostru daca am aplica o reducere 
-- de 15% produselor care un au fost vandute panda acum.
-- Am utilizat? subcerere sincronizata
select p.produs_id, p.titlu, p.pret, round((p.pret * 0.85), 2) as PretNou, round((p.pret - (p.pret * 0.85)), 2) as Dif from produs p
where p.produs_id not in (select pc.produs_id from PlasareComanda pc
    where p.produs_id = pc.produs_id);

-- Cerinta 12

-- Actualizarea pretului maxim pentru toate categoriile
update categorie cat
set cat.pretMaxim = (select max(p.pret) from produs p
    where p.categorie_id = cat.categorie_id);

-- Actualizarea pretului minim pentru toate categoriile    
update categorie cat
set cat.pretMinim = (select min(p.pret) from produs p
    where p.categorie_id = cat.categorie_id);

-- Stergerea depozitelor care nu am nici un produs in stoc sau toate produsele figureaza cu stoc = 0  
delete from depozit
where depozit_id in (
    with stocindepozit(depozit_id, stoc) as
        (select d2.depozit_id, nr.stoc from depozit d2
        inner join
            (select sd.depozit_id, sum(sd.cantitate) as stoc from stocdepozit sd
            group by sd.depozit_id) nr on d2.depozit_id = nr.depozit_id)   
    select d.depozit_id from depozit d
    where d.depozit_id not in (select d2.depozit_id from stocdepozit d2)
    or  d.depozit_id in (   
            select depozit_id from stocindepozit
            where stocindepozit.stoc = 0)
);

-- Cerinta 13

insert into locatie values(1, 'Splaiul Independentei 204', 'Bucuresti', 'Romania');
insert into locatie values(2, 'Bulevardul Iuliu Maniua 104', 'Bucuresti', 'Romania');
insert into locatie values(3, 'Strada Zavoiului 39', 'Chisinau', 'Republica Moldova');
insert into locatie values(4, 'Bergen Strasse 3', 'Berlin', 'Germania');
insert into locatie values(5, 'Bulevardul Alba Iulia 69', 'Cluj-Napoca', 'Romania');

insert into depozit values(1, 1, '0747111111', 'depozit1@email.com');
insert into depozit values(2, 2, '0737222222', 'depozit2@email.com');
insert into depozit values(3, 4, '0737222322', 'depozit3@email.com');
insert into depozit values(4, 5, '0737222422', 'depozit4@email.com');
insert into depozit values(5, 3, '0737252222', 'depozit5@email.com');
insert into depozit values(6, 4, '0737252226', 'depozit6@email.com');
insert into depozit values(7, 4, '0737252227', 'depozit7@email.com');

insert into utilizator values(1, 'Ion', 'Popescu', 'Administrator', 'ion.popescu@email.com', '0737111111', sysdate, 4);
insert into utilizator values(2, 'Gicu', 'Gigel', 'Utilizator', 'gicu.gigel@email.com', '0737222222', sysdate, 3);
insert into utilizator values(3, 'Dorel', 'Dori', 'Partener', 'dorel.dori@email.com', '0737333333', sysdate, 1);
insert into utilizator values(4, 'Teo', 'Costel', 'Utilizator', 'teo.costel@email.com', '0737204222', sysdate, 4);
insert into utilizator values(5, 'Ana', 'Maria', 'Utilizator', 'ana.maria@email.com', '0737202202', sysdate, 2);
insert into utilizator values(6, 'Popescu', 'Stefania', null, 'popescu.stefania@email.com', '0737202252', sysdate, 1);

insert into categorie values(1, 'Tech', null, null);
insert into categorie values(2, 'Religie', null, null);
insert into categorie values(3, 'Pantaloni', null, null);
insert into categorie values(4, 'Incaltaminte', null, null);
insert into categorie values(5, 'Utilitare', null, null);
insert into categorie values(6, 'Pantofi', null, null);

insert into produs values(1, 3, 1, 'Iphone 115 Pro X Max', 'Max', 1099.99, 5);
insert into produs values(2, 1, 2, 'Biblia', 'Efectiv cartea cartilor', 333, 3);
insert into produs values(3, 3, 4, 'Crose alergat', 'Adidas cel mai bun pentru alergat, tripaloski', 699, 4);
insert into produs values(4, 3, 5, 'Banda adeziva', 'Repara orice', 15, 5);
insert into produs values(5, 3, 3, 'Pantaloni negri', 'O pereche de pantaloni', 49.99, 2.5);
insert into produs values(6, 3, 6, 'Pantofi negri', 'O pereche de pantofi', 69.99, 3.5);
insert into produs values(7, 3, 6, 'Pantofi maro', 'O pereche de pantofi', 59.99, 3);
insert into produs values(8, 3, 1, 'Samasug A20e', 'ieftin', 400.00, 3.5);

insert into StocDepozit values(1, 4, 40);
insert into StocDepozit values(1, 5, 50);
insert into StocDepozit values(1, 2, 100);
insert into StocDepozit values(1, 1, 220);
insert into StocDepozit values(2, 3, 100);
insert into StocDepozit values(2, 2, 10);
insert into StocDepozit values(2, 4, 25);
insert into StocDepozit values(3, 5, 69);
insert into StocDepozit values(3, 2, 420);
insert into StocDepozit values(3, 1, 12);
insert into StocDepozit values(4, 1, 55);
insert into StocDepozit values(4, 2, 69420);
insert into StocDepozit values(4, 3, 34);
insert into StocDepozit values(4, 4, 21);
insert into StocDepozit values(4, 5, 9);
insert into StocDepozit values(5, 3, 8);
insert into StocDepozit values(5, 5, 13);
insert into StocDepozit values(6, 3, 40);
insert into StocDepozit values(7, 2, 30);
insert into StocDepozit values(1, 7, 0);

insert into comanda values(1, 1, sysdate);
insert into comanda values(2, 5, sysdate);
insert into comanda values(3, 2, sysdate);
insert into comanda values(4, 3, sysdate);
insert into comanda values(5, 4, sysdate);

insert into PlasareComanda values(1, 1, 2);
insert into PlasareComanda values(1, 2, 4);
insert into PlasareComanda values(2, 4, 5);
insert into PlasareComanda values(2, 3, 8);
insert into PlasareComanda values(2, 5, 2);
insert into PlasareComanda values(3, 1, 1);
insert into PlasareComanda values(3, 2, 3);
insert into PlasareComanda values(3, 5, 1);
insert into PlasareComanda values(4, 4, 2);
insert into PlasareComanda values(4, 3, 7);
insert into PlasareComanda values(5, 3, 3);
insert into PlasareComanda values(5, 1, 2);

commit;

-- Cerinta 16 

-- Pentru fiecare depozit dorim sa afisam toate produsele care sunt mai putin 
-- de 30 in stoc.
select d.depozit_id, l.tara, dd.produs_id, p.titlu, dd.cantitate
from StocDepozit dd
left outer join depozit d on dd.depozit_id = d.depozit_id 
right outer join produs p on dd.produs_id = p.produs_id
right outer join locatie l on d.locatie_id = l.locatie_id
where dd.cantitate <= 30
order by depozit_id, produs_id, cantitate;

-- Dorim sa afisam toate produsele care nu au fost vandute.
select produs.produs_id, produs.titlu from produs
where produs.produs_id in 
    (select p.produs_id from produs p
    minus
        select k.produs_id from 
            (select pc.produs_id, sum(pc.cantitate) as Vand from plasarecomanda pc
                group by pc.produs_id) k);

-- Dorim sa afisam toti utilizatorii care nu au comandat nimic.     
select x.utilizator_id, x.nume, x.prenume from utilizator x
where x.utilizator_id in(
    select u.utilizator_id from utilizator u
    minus
    select c.utilizator_id from comanda c);
