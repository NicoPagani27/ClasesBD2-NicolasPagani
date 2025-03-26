-- 1 --------------

SELECT a.last_name, a.first_name
FROM actor a
INNER JOIN (
    SELECT last_name
    FROM actor
    GROUP BY last_name
    HAVING COUNT(*) > 1
) AS duplicados ON a.last_name = duplicados.last_name
ORDER BY a.last_name, a.first_name;

-- 2 --------------

select a.first_name, a.last_name from actor a 
where not exists (
    select 1 from film_actor fa
    where fa.actor_id = a.actor_id
);

-- 3 --------------

SELECT *  FROM customer WHERE customer_id IN (SELECT customer_id FROM rental GROUP BY customer_id HAVING COUNT(*) = 1);

-- 4 --------------

SELECT *  FROM customer WHERE customer_id IN (SELECT customer_id FROM rental GROUP BY customer_id HAVING COUNT(*) > 1);

-- 5 --------------

SELECT * FROM actor WHERE actor_id IN 
(SELECT actor_id FROM film_actor WHERE film_id IN 
(SELECT film_id FROM film WHERE title IN ('BETRAYED REAR', 'CATCH AMISTAD')));

-- 6 --------------

SELECT * 
FROM actor 
WHERE actor_id IN (
    SELECT actor_id 
    FROM film_actor 
    WHERE film_id = (
        SELECT film_id 
        FROM film 
        WHERE title = 'BETRAYED REAR'
    )
) 
AND actor_id NOT IN (
    SELECT actor_id 
    FROM film_actor 
    WHERE film_id = (
        SELECT film_id 
        FROM film 
        WHERE title = 'CATCH AMISTAD'
    )
);

-- 7 --------------

SELECT * 
FROM actor 
WHERE actor_id IN (
    SELECT actor_id 
    FROM film_actor 
    WHERE film_id = (
        SELECT film_id 
        FROM film 
        WHERE title = 'BETRAYED REAR'
    )
) 
AND actor_id IN (
    SELECT actor_id 
    FROM film_actor 
    WHERE film_id = (
        SELECT film_id 
        FROM film 
        WHERE title = 'CATCH AMISTAD'
    )
);

-- 8 --------------

SELECT * FROM actor WHERE actor_id IN 
(SELECT actor_id FROM film_actor WHERE film_id IN 
(SELECT film_id FROM film WHERE title NOT IN ('BETRAYED REAR', 'CATCH AMISTAD')));