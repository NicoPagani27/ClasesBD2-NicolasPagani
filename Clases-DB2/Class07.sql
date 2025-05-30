USE sakila; 

-- 1 ----------------------

select film.title, film.rating, film.length 
from film
where film.length <= all (select film.length from film);

-- 2 ----------------------

select title
from film 
where film.length < all (select film.length from film);

-- 3 ----------------------

select customer_id,
(select first_name from customer where customer_id = payment.customer_id) as nombre,
(select last_name from customer where customer_id = payment.customer_id) as apellido,
(select address from address where address.address_id = (select address_id from customer
where customer_id = payment.customer_id)) as address,
amount as pago_bajo
from payment
where amount = (select min(amount) from payment where customer_id = payment.customer_id);

select customer_id, 
(select first_name from customer where customer_id = payment.customer_id) as nombre, 
(select last_name from customer where customer_id = payment.customer_id) as apellido,
(select address from address where address.address_id = (select address_id from customer
where customer_id = payment.customer_id)) as address,
amount as pago_bajo
from payment
where amount <= all (select amount from payment where customer_id = payment.customer_id);

-- 4 ----------------------

select customer_id, concat((select min(amount) from payment where customer_id = p.customer_id), ' / ',
(select max(amount) from payment p2  where customer_id = p.customer_id)) as pago_alto_bajo
from payment p
group by customer_id;