-- Toate comenzile unui client din ultimele 3 luni
select p.titlu, p.rating from produs p 
where p.produs_id in
    (select produs_id from plasarecomanda
        where comanda_id in 
            (select comanda_id from comanda 
                where utilizator_id = 1  and comanda.data >= 
                    ADD_MONTHS((select current_date from dual), -3)));
                

-- Lista utilizatorilor cu cel putin o comanda in ordine orasului
select u.utilizator_id, u.nume, u.prenume, locatie.oras
from utilizator u
inner join locatie on u.locatie_id = locatie.locatie_id
where 
    (select count(c.utilizator_id) from comanda c) > 0
order by locatie.oras;


-- Afiseaza depozit_id si produs_id pentru toate produsele care sunt mai putin de 20 in stoc
select dd.produs_id, dd.depozit_id, produs.titlu, dd.cantitate
from disponibilitatedepozit dd
inner join depozit on dd.depozit_id = depozit.depozit_id 
inner join produs on dd.produs_id = produs.produs_id
where dd.cantitate <= 20
order by depozit_id, produs_id, cantitate;

-- Pentru fiecare utilizator afiseaza ultima data cand a facut o achizitie
select u.utilizator_id, u.nume, u.prenume, MaxData from utilizator u
Inner join (select utilizator_id, Max(data) as MaxData from comanda
group by utilizator_id) k
on u.utilizator_id = k.utilizator_id;
-- de adaugat WITH

