SELECT * 
FROM actor
WHERE NOT first_name = 'PENELOPE';

SELECT * 
FROM actor
WHERE first_name <> 'PENELOPE'; /* We can also use != operator. */

SELECT * FROM actor
WHERE actor_id = (SELECT actor_id 
				FROM actor 
				WHERE first_name = 'NICK' AND last_name ='STALLONE'
                );

SELECT customer_id, rental_date
FROM rental
WHERE rental_date > '2005-06-16'; /* By default it takes the time as 00:00:00 hours. */

SELECT customer_id, rental_date
FROM rental
WHERE rental_date BETWEEN '2005-06-14' AND '2005-06-16'; /* Both conditions are also included. >= AND <= */

SELECT last_name, first_name
FROM customer
WHERE last_name LIKE 'FR%';

SELECT last_name, first_name
FROM customer
WHERE last_name BETWEEN 'FA' AND 'FR';

SELECT title, rating
FROM film
WHERE rating IN (SELECT DISTINCT rating
				FROM film
                WHERE title LIKE '%PET%'
                );

SELECT title, rating
FROM film
WHERE rating NOT IN ('PG-13','R', 'NC-17');

SELECT last_name
FROM customer
WHERE LEFT(last_name,1) = 'Q';

SELECT last_name
FROM customer
WHERE last_name LIKE 'Q_A__S%';

SELECT last_name, first_name
FROM customer
WHERE last_name REGEXP '^[QY]'; /* last name starting with 'Q' or 'Y', using regular expresssions. */

SELECT rental_id, return_date
FROM rental
WHERE return_date = 'NULL'; /* ERROR */

SELECT rental_id, return_date
FROM rental
WHERE return_date = NULL; /* Doesn't work */

SELECT rental_id, return_date
FROM rental
WHERE return_date IS NULL; 

SELECT rental_id, return_date
FROM rental
WHERE return_date IS NOT NULL; 

SELECT rental_id, return_date
FROM rental
WHERE return_date IS NULL OR return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';

SELECT *
FROM payment;

SELECT *
FROM payment
WHERE payment_id BETWEEN 101 AND 120 AND 
customer_id <> 5 AND (amount > 8 OR date(payment_date) = '2005-08-23');

SELECT *
FROM payment
WHERE payment_id BETWEEN 101 AND 120 AND 
customer_id = 5 AND NOT (amount > 6 OR date(payment_date) = '2005-06-19');

SELECT * 
FROM payment
WHERE amount IN (1.98, 7.98, 9.98);

SELECT *
FROM customer
WHERE last_name LIKE '_A%W%';
