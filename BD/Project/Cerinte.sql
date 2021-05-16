-- Toate comenzile unui client din ultimele 3 luni
select p.titlu, p.pret, pc.cantitate from produs  p, plasarecomanda pc
where p.produs_id in 
    (select produs_id from plasarecomanda
        where pc.comanda_id in 
            (select comanda_id from comanda
                where comanda.utilizator_id = 1 and comanda.data >= 
                    ADD_MONTHS((select current_date from dual), -3)));
                    
-- Media recenzilor pentru cel mai bine vandut produs din fiecare categorie


-- Lista utilizatorilor cu cel putin o comanda in ordine orasului
select u.utilizator_id, u.nume, u.prenume, locatie.oras
from utilizator u
inner join locatie on u.locatie_id = locatie.locatie_id
where (select count(c.utilizator_id) from comanda c) > 0
order by locatie.oras;
