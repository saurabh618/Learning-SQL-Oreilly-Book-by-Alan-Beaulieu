SELECT customer_id, COUNT(*) FROM rental
GROUP BY customer_id
ORDER BY 2 DESC;

SELECT customer_id FROM rental
GROUP BY customer_id;

SELECT customer_id, COUNT(*) AS films FROM rental
GROUP BY customer_id
HAVING films >= 40
ORDER BY 2 DESC;

SELECT MAX(amount) max_amt, MIN(amount) min_amt, AVG(amount) avg_amt, SUM(amount) tot_amt, COUNT(*) num_payments
FROM payment;

SELECT customer_id, COUNT(*), COUNT(DISTINCT staff_id) FROM rental
GROUP BY customer_id;

SELECT MAX(DATEDIFF(return_date, rental_date)) FROM rental;

SELECT actor_id, COUNT(*) FROM film_actor
GROUP BY actor_id ORDER BY 2 DESC;

SELECT * FROM film;

SELECT fa.actor_id, f.rating, COUNT(*)
FROM film f INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY fa.actor_id, f.rating
ORDER BY 1, 2;

SELECT EXTRACT(YEAR FROM rental_date), COUNT(*)
FROM rental
GROUP BY EXTRACT(YEAR FROM rental_date);

SELECT fa.actor_id, f.rating, COUNT(*)
FROM film f INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY fa.actor_id, f.rating WITH ROLLUP /* Here order matters in the GROUP BY clause */
ORDER BY 1, 2;

SELECT fa.actor_id, f.rating, COUNT(*)
FROM film f INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY f.rating, fa.actor_id WITH ROLLUP 
ORDER BY 1, 2;

SELECT fa.actor_id, f.rating, count(*)
FROM film_actor fa INNER JOIN film f
ON fa.film_id = f.film_id
WHERE f.rating IN ('G','PG')
GROUP BY fa.actor_id, f.rating
HAVING count(*) > 9
ORDER BY fa.actor_id;

SELECT customer_id, COUNT(*), SUM(amount) FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 40;
