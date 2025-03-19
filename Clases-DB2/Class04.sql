select * from film where rating = "PG-13";

select film_id,title, `length` from film;

select title, rental_duration, replacement_cost from film where replacement_cost between 20 and 24;

select * from film;

select film.title, film.film_id, film.rating, film_category.category_id, film.special_features from film inner join film_category on film.film_id = film_category.film_id where film.special_features = "Commentaries,Behind the Scenes";

select * from actor;
	

select actor.first_name, actor.last_name, actor.actor_id from actor inner join film_actor on actor.actor_id = film_actor.actor_id;

select actor.first_name, actor.last_name, film.title from actor
inner join film_actor on actor.actor_id = film_actor.actor_id 
inner join film on film_actor.film_id = film.film_id
where film.title = "ZOOLANDER FICTION"

select * from store;

SELECT address.address, city.city, country.country, store.store_id from country 
inner join city on country.country_id = city.country_id
inner join address on city.city_id = address.city_id
inner join store on store.address_id = address.address_id
where store.store_id = 1

select f.title, f.rating from film f inner join film f1 on f.rating = f1.rating;

select f.title AS pelicula, s.first_name AS NombreGerente, s.last_name AS ApellidoGerente from film f
inner join inventory i ON f.film_id = i.film_id
inner join store st ON i.store_id = st.store_id
inner join staff s ON st.manager_staff_id = s.staff_id
where i.store_id = 2;



