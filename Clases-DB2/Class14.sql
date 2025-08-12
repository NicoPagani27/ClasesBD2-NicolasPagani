use sakila;

-- 1 ---------------

select * from customer

select 
    concat(customer.first_name, ' ', customer.last_name) as nombre_completo,
    address.address,
    city.city
from customer 
join address on customer.address_id = address.address_id
join city on address.city_id = city.city_id
join country on city.country_id = country.country_id
where country.country = 'Argentina';


-- 2 ---------------

select * from film

select 
    film.title,
    language.name as idioma,
    case film.rating
        when 'G' then 'All Ages Admitted'
        When 'PG' then 'Parental Guidance Suggested'
        when 'PG-13' then 'Parents Strongly Cautioned'
        when 'R' then 'Restricted'
        when 'NC-17' then 'No One 17 and Under Admitted'
        else 'Clasificación desconocida'
    end as clasificacion_completa
from film
join language on film.language_id = language.language_id;

-- 3 ---------------

select * from film

select 
    film.title,
    film.release_year
from film 
join film_actor  on film.film_id = film_actor.film_id
join actor on film_actor.actor_id = actor.actor_id
where actor.first_name like '%john%'
   or actor.last_name like '%travolta%';

-- 4 ---------------

select 
    film.title,
    concat(customer.first_name, ' ', customer.last_name) as cliente,
    case 
        when rental.return_date is not null then 'Sí'
        else 'No'
    end as devuelto
from rental
join inventory on rental.inventory_id = inventory.inventory_id
join film on inventory.film_id = film.film_id
join customer on rental.customer_id = customer.customer_id
where month(rental.rental_date) in (5, 6);

-- 5 ---------------

-- CAST: convertir a CHAR
select cast(film.release_year as char) as anio_texto
from film

-- CONVERT: convertir a CHAR
select convert(film.release_year, char) as anio_texto
from film

-- estas convierten el tipo de dato	

-- 6 ---------------

-- NVL: Devuelve expr2 si expr1 es NULL, de lo contrario devuelve expr1, funciona en oracle


-- ISNULL: En MySQL devuelve 1 si es NULL y 0 si no lo es.


-- IFNULL: 	Devuelve expr2 si expr1 es NULL, de lo contrario devuelve expr1.


-- COALESCE: Devuelve el primer valor no NULL en la lista.

-- IFNULL: reemplazar valores nulos en return_date
SELECT rental_id, IFNULL(return_date, 'No devuelto') AS estado
FROM rental;

-- COALESCE: primer valor no nulo entre varias columnas
SELECT rental_id, COALESCE(return_date, last_update, 'Sin fecha') AS fecha_util
FROM rental;

-- ISNULL: detectar nulos
SELECT rental_id, ISNULL(return_date) AS es_nulo
FROM rental;

