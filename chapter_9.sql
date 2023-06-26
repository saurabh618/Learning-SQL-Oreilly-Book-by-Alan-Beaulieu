SELECT customer_id, first_name, last_name FROM customer
WHERE customer_id = (SELECT MAX(customer_id) FROM customer);

SELECT customer_id, first_name, last_name FROM customer c
WHERE customer_id = MAX(customer_id); /* This doesn't work. Gives error. */

SELECT city_id, city
FROM city
WHERE country_id <> (SELECT country_id FROM country WHERE country = 'India');

SELECT city_id, city FROM city
WHERE country_id IN (SELECT country_id FROM country
					WHERE country IN ('Canada','Mexico')
					);
                        
SELECT city_id, city FROM city
WHERE country_id NOT IN (SELECT country_id FROM country
						WHERE country IN ('Canada','Mexico')
                        );

SELECT city_id, city FROM city
WHERE country_id <> ALL (SELECT country_id FROM country
						WHERE country IN ('Canada','Mexico')
                        );

SELECT first_name, last_name FROM customer
WHERE customer_id NOT IN (122, 452, NULL);

SELECT first_name, last_name FROM customer
WHERE customer_id NOT IN (122, 452);

SELECT customer_id, count(*) FROM rental 
GROUP BY customer_id 
HAVING count(*) > ALL
(SELECT count(*) FROM rental r
INNER JOIN customer c
ON r.customer_id = c.customer_id
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
INNER JOIN country co
ON ct.country_id = co.country_id
WHERE co.country IN ('United States','Mexico','Canada')
GROUP BY r.customer_id
);

SELECT customer_id, sum(amount) FROM payment
GROUP BY customer_id
HAVING sum(amount) > ANY
(SELECT sum(p.amount) FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
INNER JOIN country co
ON ct.country_id = co.country_id
WHERE co.country IN ('Bolivia','Paraguay','Chile')
GROUP BY co.country
);

SELECT fa.actor_id, fa.film_id FROM film_actor fa
WHERE fa.actor_id IN (SELECT actor_id FROM actor WHERE last_name = 'MONROE')
AND fa.film_id IN (SELECT film_id FROM film WHERE rating = 'PG');

SELECT fa.actor_id, fa.film_id FROM film_actor fa
WHERE (fa.actor_id, fa.film_id) IN 
(SELECT a.actor_id, f.film_id FROM actor a
INNER JOIN film_actor fa2
ON a.actor_id = fa2.actor_id
INNER JOIN film f
ON fa2.film_id = f.film_id
WHERE a.last_name = 'MONROE' AND f.rating = 'PG'
);

SELECT fa.actor_id, fa.film_id FROM film_actor fa
WHERE (fa.actor_id, fa.film_id) IN 
(SELECT a.actor_id, f.film_id FROM actor a
CROSS JOIN film f
WHERE a.last_name = 'MONROE' AND f.rating = 'PG'
);

select * from rental;
select * from payment;

SELECT first_name, last_name FROM customer c
WHERE 20 = (SELECT COUNT(*) FROM rental r
WHERE r.customer_id = c.customer_id
);

SELECT first_name, last_name FROM customer c
WHERE (SELECT SUM(amount) FROM payment p
WHERE p.customer_id = c.customer_id
) BETWEEN 180 AND 240;

SELECT customer_id, first_name, last_name FROM customer c
WHERE EXISTS (SELECT 1 FROM rental r
			WHERE c.customer_id = r.customer_id AND date(r.rental_date) < '2005-05-25'
            );

SELECT customer_id FROM rental r
WHERE date(r.rental_date) < '2005-05-25';

SELECT customer_id, first_name, last_name FROM customer c
WHERE NOT EXISTS (SELECT 1 FROM rental r
			WHERE c.customer_id = r.customer_id AND date(r.rental_date) < '2005-05-25'
            );

SELECT a.first_name, a.last_name FROM actor a
WHERE NOT EXISTS (SELECT 1 FROM film_actor fa
				INNER JOIN film f ON f.film_id = fa.film_id
				WHERE fa.actor_id = a.actor_id AND f.rating = 'R'
                );


UPDATE customer c
SET c.last_update =
(SELECT max(r.rental_date) FROM rental r
WHERE r.customer_id = c.customer_id);

UPDATE customer c
SET c.last_update = (SELECT max(r.rental_date) FROM rental r
					WHERE r.customer_id = c.customer_id
                    )
WHERE EXISTS (SELECT 1 FROM rental r
			WHERE r.customer_id = c.customer_id
            );

SELECT first_name, last_name, pymt.num_rentals, pymt.sum_rentals
FROM customer c
INNER JOIN (SELECT p.customer_id, COUNT(*) num_rentals, SUM(p.amount) sum_rentals
			FROM payment p
            GROUP BY p.customer_id
			) pymt
ON c.customer_id = pymt.customer_id;

SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
UNION ALL
SELECT 'Average Joes', 75, 149.99 
UNION ALL
SELECT 'Heavy Hitters', 150, 9999999.99 ;

SELECT pymnt_grps.name, count(*) num_customers
FROM (SELECT customer_id,
count(*) num_rentals, sum(amount) tot_payments
FROM payment
GROUP BY customer_id
) pymnt
INNER JOIN (SELECT 'Small Fry' name, 0 low_limit, 74.99 high_limit
UNION ALL
SELECT 'Average Joes' name, 75 low_limit, 149.99 high_limit
UNION ALL
SELECT 'Heavy Hitters' name, 150 low_limit, 9999999.99 high_limit
) pymnt_grps
ON pymnt.tot_payments
BETWEEN pymnt_grps.low_limit AND pymnt_grps.high_limit
GROUP BY pymnt_grps.name;


/*
customer’s name, along with
their city, the total number of rentals, and the total payment amount.
payment, customer, address, and city tables,
*/

select * from payment;
select * from customer;
select * from address;
select * from city;

SELECT c.first_name, c.last_name, city.city, COUNT(*) num_rentals, SUM(p.amount) tot_payment 
FROM customer c
INNER JOIN payment p
ON p.customer_id = c.customer_id
INNER JOIN address a
ON a.address_id = c.address_id
INNER JOIN city
ON city.city_id = a.city_id
GROUP BY c.customer_id;

SELECT c.first_name, c.last_name, ct.city, pymnt.tot_payments, pymnt.tot_rentals
FROM (SELECT customer_id, count(*) tot_rentals, sum(amount) tot_payments
FROM payment
GROUP BY customer_id
) pymnt
INNER JOIN customer c
ON pymnt.customer_id = c.customer_id
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id;

WITH actors_s AS
(SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name LIKE 'S%'
),
actors_s_pg AS
(SELECT s.actor_id, s.first_name, s.last_name, f.film_id, f.title
FROM actors_s s
INNER JOIN film_actor fa
ON s.actor_id = fa.actor_id
INNER JOIN film f
ON f.film_id = fa.film_id
WHERE f.rating = 'PG'
),
actors_s_pg_revenue AS
(SELECT spg.first_name, spg.last_name, p.amount
FROM actors_s_pg spg
INNER JOIN inventory i
ON i.film_id = spg.film_id
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN payment p
ON r.rental_id = p.rental_id
) /* end of With clause */
SELECT spg_rev.first_name, spg_rev.last_name,
sum(spg_rev.amount) tot_revenue
FROM actors_s_pg_revenue spg_rev
GROUP BY spg_rev.first_name, spg_rev.last_name
ORDER BY 3 desc;

SELECT (SELECT c.first_name FROM customer c
WHERE c.customer_id = p.customer_id
) first_name,
(SELECT c.last_name FROM customer c
WHERE c.customer_id = p.customer_id
) last_name,
(SELECT ct.city
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
WHERE c.customer_id = p.customer_id
) city,
sum(p.amount) tot_payments, count(*) tot_rentals
FROM payment p
GROUP BY p.customer_id;

SELECT a.actor_id, a.first_name, a.last_name
FROM actor a
ORDER BY (SELECT count(*) FROM film_actor fa
WHERE fa.actor_id = a.actor_id) DESC;

INSERT INTO film_actor (actor_id, film_id, last_update)
VALUES (
(SELECT actor_id FROM actor
WHERE first_name = 'JENNIFER' AND last_name = 'DAVIS'),
(SELECT film_id FROM film
WHERE title = 'ACE GOLDFINGER'),
now()
);

SELECT title FROM film
WHERE film_id IN ( SELECT film_id FROM film_category fc
				INNER JOIN category c
                ON c.category_id = fc.category_id
                WHERE c.name = 'Action'
				);
                
SELECT title FROM film f
WHERE EXISTS ( SELECT 1 FROM film_category fc
				INNER JOIN category c
                ON c.category_id = fc.category_id
                WHERE c.name = 'Action' AND f.film_id = fc.film_id
				);

SELECT actor_group_tbl.level, COUNT(*) FROM 
(SELECT actor_id, count(*) num_movie FROM film_actor
GROUP BY actor_id) num_films_tbl
INNER JOIN
(SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles) actor_group_tbl
ON num_films_tbl.num_movie BETWEEN actor_group_tbl.min_roles AND actor_group_tbl.max_roles
GROUP BY actor_group_tbl.level;

SELECT num_films_tbl.actor_id, actor_group_tbl.level FROM 
(SELECT actor_id, count(*) num_movie FROM film_actor
GROUP BY actor_id) num_films_tbl
INNER JOIN
(SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
UNION ALL
SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
UNION ALL
SELECT 'Newcomer' level, 1 min_roles, 19 max_roles) actor_group_tbl
ON num_films_tbl.num_movie BETWEEN actor_group_tbl.min_roles AND actor_group_tbl.max_roles;
