use sakila;

-- 1 --------------------------- 

SELECT
    country.country_id,
    country.country,
    COUNT(city.city_id) AS cantidad_ciudades
FROM
    country
JOIN
    city ON country.country_id = city.country_id
GROUP BY
    country.country_id, country.country
ORDER BY 
    country.country_id;


-- 2 ---------------------------

SELECT
    country.country_id,
    country.country,
    COUNT(city.city_id) AS cantidad_ciudades
FROM
    country
JOIN
    city ON country.country_id = city.country_id
GROUP BY
    country.country_id, country.country
HAVING
    COUNT(city.city_id) > 10
ORDER BY
    cantidad_ciudades DESC;


-- 3 ---------------------------


SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS nombre_completo,
    a.address AS direccion,
    COUNT(r.rental_id) AS total_peliculas_alquiladas,
    SUM(p.amount) AS total_gastado
FROM 
    customer c
JOIN 
    address a ON c.address_id = a.address_id
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    payment p ON r.rental_id = p.rental_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name, a.address
ORDER BY 
    total_gastado DESC;

-- 4 ---------------------------

SELECT 
    category.name AS categoria,
    AVG(film.length) AS promedio_duracion
FROM 
    film 
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY
    category.category_id, category.name
ORDER BY 
    promedio_duracion DESC;

-- 5 ---------------------------

SELECT 
    film.title AS pelicula,
    SUM(payment.amount) AS ventas_totales
FROM 
    film 
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
JOIN 
    payment ON rental.rental_id = payment.rental_id
GROUP BY 
    film.film_id, film.title
ORDER BY 
    ventas_totales DESC;
