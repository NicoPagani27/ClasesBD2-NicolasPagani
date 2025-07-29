use sakila

-- 1 ------------

create view list_of_customers as
select
    customer.customer_id as identificacion_del_cliente,
    CONCAT(customer.first_name, ' ', customer.last_name) as nombre_completo,
    address.address as direccion,
    address.postal_code as codigo_postal,
    address.phone as telefono,
    city.city as ciudad,
    country.country as pais,
    case 
        when customer.active = 1 then 'activa'
        else 'inactiva'
    end as estado,
    customer.store_id as id_tienda
from
    customer 
    join address on customer.address_id = address.address_id
    join city on address.city_id = city.city_id
    join country on city.country_id = country.country_id


select * from list_of_customers


-- 2 -----------

create view film_details as
select
    film.film_id as id_pelicula,
    film.title as titulo,
    film.description as descripcion,
    category.name as categoria,
    film.rental_rate as precio,
    film.length as duracion,
    film.rating as calificacion,
    GROUP_CONCAT(CONCAT(actor.first_name, ' ', actor.last_name) SEPARATOR ', ') as actores
from
    film 
    join film_category on film.film_id = film_category.film_id
    join category on film_category.category_id = category.category_id
    join film_actor on film.film_id = film_actor.film_id
    join actor  on film_actor.actor_id = actor.actor_id
group by
    film.film_id, film.title, film.description, category.name, film.rental_rate, film.length, film.rating


select * from film_details


-- 3 -----------

create view sales_by_film_category as
select
    category.name as categoria,
    SUM(payment.amount) as total_alquiler
FROM
    payment
    join rental on payment.rental_id = rental.rental_id
    join inventory on rental.inventory_id = inventory.inventory_id
    join film on inventory.film_id = film.film_id
    join film_category on film.film_id = film_category.film_id
    join category on film_category.category_id = category.category_id
group by
    category.name


select * from sales_by_film_category

-- 4 -----------

create view actor_information as
select
    actor.actor_id AS id_actor,
    actor.first_name AS nombre,
    actor.last_name AS apellido,
    COUNT(film_actor.film_id) AS cantidad_peliculas
from
    actor 
    join film_actor on actor.actor_id = film_actor.actor_id
group by
    actor.actor_id, actor.first_name, actor.last_name
    
    
select * from actor_information


-- 5 -----------

-- el create view, crea una vista llamada actor_information

-- Una vista es como una tabla virtual que se puede consultar igual que una tabla normal

-- en el select seleccionamos 4 columnas que serán las columnas de la vista:

-- actor.actor_id AS id_actor: el identificador único del actor, renombrado como id_actor.

-- actor.first_name AS nombre: el nombre del actor, renombrado como nombre.

-- actor.last_name AS apellido: el apellido del actor, renombrado como apellido.

-- COUNT(film_actor.film_id) AS cantidad_peliculas: el conteo de las películas en las que el actor actuó. Se usa la función de agregación COUNT que cuenta cuántas filas coinciden para cada actor (las filas vienen de film_actor).

-- luego hago un JOIN entre las tablas actor y film_actor

-- Esto da como resultado un conjunto de filas donde cada fila representa a un actor participando en una película específica.

-- como estamos usando el COUNT(), necesitamos agrupar las filas que pertenecen a cada actor para sumar correctamente.

-- no hice subconsulta ya que la función de agregación COUNT() junto con el JOIN y el GROUP BY es lo que se usa para obtener el número de películas por actor.


-- 6 -------------


-- Una vista materializada es un objeto de base de datos 
-- que contiene el resultado de una consulta (como una tabla temporal pero permanente dentro del sistema). 
-- la vista materializada guarda sus datos en disco, permitiendo un acceso mucho más rápido a resultados complejos o agregados.


-- Mejora del rendimiento: Consultas complejas con agregaciones
-- Reducción de carga en el sistema: Se evita recalcular la misma consulta una y otra vez, especialmente útil para datos que no cambian frecuentemente.


-- Vistas normales (lógicas): No almacenan datos, sólo guardan la definición de la consulta y se ejecutan al momento. Son más flexibles porque siempre reflejan el estado actual de la base de datos, pero pueden ser lentas para consultas complejas.
-- Tablas de resumen (summary tables): Tablas físicas que se actualizan manualmente o con procesos automáticos. Son similares a vistas materializadas, pero requieren manejo explícito de la sincronización.


-- Existen verios soportes DBMS populares:
-- Algunos son: Oracle,. Postgre SQL, Microsofct SQL server, MySQL, Maria DB