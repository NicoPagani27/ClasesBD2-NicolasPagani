use sakila

-- 1 ------------------

select * from customer

insert into customer (store_id, first_name, last_name, email, address_id, active)
values (1, 'Nico', 'Pagani', 'nicopagani@gmail.com',
  (select address_id 
   from address 
   join city on address.city_id = city.city_id
   join country on country.country_id = city.country_id
   order by address.address_id desc
   limit 1
), 1)

select * from country

-- 2 ------------------

select * from rental

insert into rental (rental_date, inventory_id, customer_id, return_date, staff_id)

select NOW(),
    
-- Aca obtengo el id de inventario de la pelicula por titulo
    (select inventory.inventory_id
     from inventory
     join film on inventory.film_id = film.film_id
     where film.title LIKE '%PELÍCULA%'
     order by  inventory.inventory_id desc
     limit 1),

-- en esta subconsulta uso el cliente creado
    (select customer.customer_id
     from customer
     order by customer.customer_id desc
     limit 1),

-- fecha de devolucion dentro de 7 dias
    now() + interval 7 dat,

    (select staff.staff_id
     from staff
     where staff.store_id = 2
     limit 1)
     
-- 3 ------------------

select distinct release_year 
from film 
order by release_year desc

     
update film
set release_year = 2001
where rating = 'G'

update film
set release_year = 2002
where rating = 'PG'


update film
set release_year = 2004
where rating = 'R'


update film
set release_year = 2004
where rating = 'R'

-- 4 ------------------

-- busco el rental id que no ha sido devuelto

select rental_id
from rental
where return_date is null
order by rental_id desc
limit 1;

-- aca use el rental id para hacer el update

update rental
set return_date = now()
where rental_id = (
    select rental_id
    from (select rental_id
          from rental
          where return_date is null
          order by rental_id desc
          limit 1) as subconsulta
)

-- aca verifico 

select *
from rental
where rental_id = (select rental_id
    			   from rental
                   order by rental_id desc
				   limit 1
) 


-- 5 ------------------


-- suposicion

delete from film where film_id = 1

-- lo que ocurre es que:
-- si intento eliminar una película que está relacionada con otras tablas (como inventory, rental, etc.), MySQL me tira un error,
-- por restricción de clave foránea (foreign key constraint) porque otras tablas dependen de esa película.
-- SQL Error [1451] [23000]: Cannot delete or update a parent row: a foreign key 

-- Hay que eliminar todos los registros relacionados en tablas que tienen referencias (FK) a film, para despues eliminar la película.

-- elimino  pagos relacionado

delete from payment
where rental_id in (select rental_id
    				from rental
    				where inventory_id in (select inventory_id
        								   from inventory
        								   where film_id = 1)
)

-- elimino los alquileres relacionado con la peli

delete from rental
where inventory_id IN  (select inventory_id
					    from inventory
					    where film_id = 1
)

delete from inventory
where film_id = 1

delete from film
where film_id = 1


-- 6 ------------------

-- Busco un inventory que no se ha alquilado todavia


select inventory_id
from inventory
where inventory_id <> all (select inventory_id 
						   from rental)
limit 1


-- Veo los ultimos rental y payment para pdoer verificar
select * 
from rental 
order by rental_id desc

select * 
from payment 
order by payment_id desc

insert into rental (rental_date, inventory_id, customer_id, staff_id)
values (
    now(),
    (select inventory_id
     from inventory
     where inventory_id <> all (select inventory_id 
     							from rental)
     order by inventory_id asc
     limit 1),
     1,
     1
)


insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
values (
    (select customer_id from rental order by rental_id desc limit 1),
    (select staff_id from rental order by rental_id desc limit 1),
    (select MAX(rental_id) from rental),
    10,
    now()
);






