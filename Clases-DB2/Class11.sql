use sakila;

-- 1 -----------------

select f.film_id, f.title, f.release_year, f.rating, f.length
from film f
left join inventory i on f.film_id = i.film_id
where i.film_id is null 

-- 2 -----------------

select
    i.inventory_id,
    f.title
from inventory i
join film f ON i.film_id = f.film_id
where i.inventory_id not in (
        select
            rental.inventory_id
        from rental
    );

-- 3 -----------------

select
    c.first_name as nombre,
    c.last_name as apellido,
    i.store_id,
    f.title,
    r.rental_date as fecha_alquiler,
    r.return_date as fecha_devolucion
from
    customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id
order by
    i.store_id,
    c.last_name;

-- 4 -----------------


select
    concat(ci.city, ', ', co.country) as ubicacion,
    concat(m.first_name, ' ', m.last_name) as gerente,
    s.store_id,
    sum(p.amount) as ventas_totales
from store s
join address a on s.address_id = a.address_id
join city ci on a.city_id = ci.city_id
join country co on ci.country_id = co.country_id
join staff m on s.manager_staff_id = m.staff_id
join customer c on s.store_id = c.store_id
join payment p on c.customer_id = p.customer_id
group by
    s.store_id, ubicacion, gerente



-- 5 -----------------
    
    
select
    concat(a.first_name, ' ', a.last_name) as actor,
    count(fa.film_id) AS cantidad_peliculas
from actor a
join film_actor fa on a.actor_id = fa.actor_id
group by
    a.actor_id, actor
order by
    cantidad_peliculas DESC
    
# Ahi funcionaria la consulta, que me muestra con count, los actores que aparecieron en peliculas, pero yo interpreto en la pregunta que me pide solo el actor que aparecio en mas peliculas por ende es solo 1 y por eso uso limit
    
LIMIT 1;

# Lo coloco al final de esta cosulta