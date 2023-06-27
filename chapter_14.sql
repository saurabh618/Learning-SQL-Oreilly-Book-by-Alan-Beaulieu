CREATE VIEW customer_vw
(customer_id, first_name, last_name, email)
AS 
SELECT customer_id, first_name, last_name, CONCAT(SUBSTR(email,1,2),'****',SUBSTR(email,-4)) FROM customer;

SELECT * FROM customer_vw;

DROP VIEW customer_vw;

DESC customer_vw;

CREATE VIEW sales_by_film_category
AS
SELECT
c.name AS category,
SUM(p.amount) AS total_sales
FROM payment AS p
INNER JOIN rental AS r ON p.rental_id = r.rental_id
INNER JOIN inventory AS i ON r.inventory_id = i.inventory_id
INNER JOIN film AS f ON i.film_id = f.film_id
INNER JOIN film_category AS fc ON f.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY total_sales DESC;

SELECT * FROM sales_by_film_category;

CREATE VIEW film_stats
AS
SELECT f.film_id, f.title, f.description, f.rating,
(SELECT c.name
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
WHERE fc.film_id = f.film_id) category_name,
(SELECT count(*)
FROM film_actor fa
WHERE fa.film_id = f.film_id
) num_actors,
(SELECT count(*)
FROM inventory i
WHERE i.film_id = f.film_id
) inventory_cnt,
(SELECT count(*)
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE i.film_id = f.film_id
) num_rentals
FROM film f;

SELECT MAX(num_actors) FROM film_stats;

CREATE VIEW film_ctgry_actor
AS 
SELECT f.title, c.name category_name, a.first_name, a.last_name
FROM actor a
INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN film f ON f.film_id = fa.film_id
INNER JOIN film_category fc ON fc.film_id = f.film_id
INNER JOIN category c ON c.category_id = fc.category_id;

SELECT title, category_name, first_name, last_name
FROM film_ctgry_actor
WHERE last_name = 'FAWCETT';

SELECT * FROM country ; -- country, c_id
SELECT * FROM payment p ; -- id - payment, customer, staff, rental
SELECT * FROM customer c ; -- id - customer, store, address
SELECT * FROM address; -- city id, address id
SELECT * FROM city; -- ccity id , country id

SELECT country.country, (SELECT SUM(amount) FROM payment p
INNER JOIN customer c ON c.customer_id = p.customer_id
INNER JOIN address a ON a.address_id = c.address_id
INNER JOIN city ON city.city_id = a.city_id
WHERE city.country_id = country.country_id
) tot_payment
FROM country;
