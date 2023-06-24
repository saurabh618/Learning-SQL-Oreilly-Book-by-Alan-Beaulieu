SELECT first_name, last_name
FROM customer;

SELECT first_name, last_name
FROM customer
WHERE last_name = 'ZIEGLER';

SELECT * 
FROM language;

SELECT language_id lang_id,
'COMMON' lang_usage, 
UPPER(name) lang_name, 
ROUND(language_id * 3.142856, 2) language_mult
FROM language;

SELECT language_id AS lang_id,
'COMMON' AS lang_usage, 
UPPER(name) AS lang_name, 
ROUND(language_id * 3.142856, 2) AS language_mult
FROM language;

SELECT user(), database(), version(), now();

SELECT * 
FROM film_actor
ORDER BY actor_id;

SELECT DISTINCT actor_id
FROM film_actor
ORDER BY actor_id;

SELECT CONCAT(first_name," ", last_name) AS full_name
FROM (SELECT first_name, last_name, email
		FROM customer 
        WHERE first_name = 'JESSIE'
	) AS cust; /* Here giving the table a name is mandatory, without it it won't work. */
    
CREATE TEMPORARY TABLE actor_s (
	actor_id SMALLINT(5),
    first_name VARCHAR(20),
    last_name VARCHAR(20)
);
    
desc actor_s;

INSERT INTO actor_s
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name LIKE 'S%';

SELECT * 
FROM actor_s; 

SELECT * 
FROM customer;

CREATE VIEW cust_view AS
SELECT customer_id, first_name, active
FROM customer;

SELECT customer_id, first_name
FROM cust_view
WHERE active = 0;

SELECT * 
FROM customer;

SELECT * 
FROM rental;

SELECT customer.customer_id, CONCAT(customer.first_name, " ", customer.last_name) AS full_name, 
	time(rental.rental_date) AS time
FROM customer
INNER JOIN rental
ON customer.customer_id = rental.customer_id
WHERE date(rental.rental_date) = '2005-06-14';

SELECT film_id, title 
FROM film
WHERE rental_duration >= 7 AND rating = 'G';

SELECT film_id, title 
FROM film
WHERE rental_duration >= 7 OR rating = 'G';

SELECT title, rating, rental_duration
FROM film
WHERE (rating = 'G' AND rental_duration >= 7)
	OR (rating = 'PG-13' AND rental_duration < 4);
    
SELECT c.customer_id, COUNT(*) AS times_rental
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id
HAVING COUNT(*) >= 40
ORDER BY COUNT(*);

SELECT c.first_name, c.last_name, count(*) AS times_rented
FROM customer c
INNER JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
HAVING times_rented >= 40
ORDER BY times_rented DESC, 1 DESC; /* Here '1' represents the first column. */

SELECT actor_id, first_name, last_name
FROM actor
ORDER BY 3,2;

SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name IN ('wILLIAMS', 'DAVIS');

SELECT DISTINCT customer_id
FROM rental
WHERE DATE(rental_date) = '2005-07-05'
ORDER BY customer_id;

SELECT c.email, r.return_date
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14'
ORDER BY r.return_date DESC, c.email;
