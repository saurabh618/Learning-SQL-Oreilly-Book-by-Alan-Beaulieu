SELECT * FROM customer;

SELECT first_name, last_name,
CASE
	WHEN active = 1 THEN 'Active'
	ELSE 'Inactive'
END activity_type
FROM customer;

SELECT c.first_name, c.last_name,
CASE 
	WHEN active = 0 THEN 0
    ELSE (SELECT COUNT(*)
		FROM rental r
        WHERE r.customer_id = c.customer_id
    )
END num_rentals
FROM customer c;

SELECT * FROM rental;

SELECT MONTHNAME(rental_date) rental_month, COUNT(*) num_rentals
FROM rental
WHERE rental_date BETWEEN '2005-05-01' AND '2005-07-31'
GROUP BY MONTHNAME(rental_date);

SELECT 
SUM(CASE WHEN MONTHNAME(rental_date) = 'May' THEN 1 ELSE 0 END) may,
SUM(CASE WHEN MONTHNAME(rental_date) = 'June' THEN 1 ELSE 0 END) june,
SUM(CASE WHEN MONTHNAME(rental_date) = 'July' THEN 1 ELSE 0 END) july
FROM rental
WHERE rental_date BETWEEN '2005-05-01' AND '2005-07-31';

SELECT a.first_name, a.last_name,
CASE
	WHEN EXISTS (SELECT 1 FROM film_actor fa
	INNER JOIN film f ON fa.film_id = f.film_id
	WHERE fa.actor_id = a.actor_id
	AND f.rating = 'G') THEN 'Y'
	ELSE 'N'
END g_actor,
CASE
	WHEN EXISTS (SELECT 1 FROM film_actor fa
	INNER JOIN film f ON fa.film_id = f.film_id
	WHERE fa.actor_id = a.actor_id
	AND f.rating = 'PG') THEN 'Y'
	ELSE 'N'
END pg_actor,
CASE
	WHEN EXISTS (SELECT 1 FROM film_actor fa
	INNER JOIN film f ON fa.film_id = f.film_id
	WHERE fa.actor_id = a.actor_id
	AND f.rating = 'NC-17') THEN 'Y'
	ELSE 'N'
END nc17_actor
FROM actor a
WHERE a.last_name LIKE 'S%' OR a.first_name LIKE 'S%';

SELECT f.title,
CASE (SELECT count(*) FROM inventory i
	WHERE i.film_id = f.film_id)
	WHEN 0 THEN 'Out Of Stock'
	WHEN 1 THEN 'Scarce'
	WHEN 2 THEN 'Scarce'
	WHEN 3 THEN 'Available'
	WHEN 4 THEN 'Available'
	ELSE 'Common'
END film_availability
FROM film f;

SELECT 100/0;

SELECT c.first_name, c.last_name,
sum(p.amount) tot_payment_amt,
count(p.amount) num_payments,
sum(p.amount) /
CASE WHEN count(p.amount) = 0 THEN 1
ELSE count(p.amount)
END avg_payment
FROM customer c
LEFT OUTER JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.first_name, c.last_name;

UPDATE customer
SET active =
CASE
	WHEN 90 <= (SELECT datediff(now(), max(rental_date))
	FROM rental r
	WHERE r.customer_id = customer.customer_id)
	THEN 0
	ELSE 1
END
WHERE active = 1;

SELECT c.first_name, c.last_name,
CASE
	WHEN a.address IS NULL THEN 'Unknown'
	ELSE a.address
END address,
CASE
	WHEN ct.city IS NULL THEN 'Unknown'
	ELSE ct.city
END city,
CASE
	WHEN cn.country IS NULL THEN 'Unknown'
	ELSE cn.country
END country
FROM customer c
LEFT OUTER JOIN address a
ON c.address_id = a.address_id
LEFT OUTER JOIN city ct
ON a.city_id = ct.city_id
LEFT OUTER JOIN country cn
ON ct.country_id = cn.country_id;

SELECT (7 * 5) / ((3 + 14) * null);

SELECT name,
CASE name
WHEN 'English' THEN 'latin1'
WHEN 'Italian' THEN 'latin1'
WHEN 'French' THEN 'latin1'
WHEN 'German' THEN 'latin1'
WHEN 'Japanese' THEN 'utf8'
WHEN 'Mandarin' THEN 'utf8'
ELSE 'Unknown'
END character_set
FROM language;

SELECT name,
CASE 
WHEN name IN ('English','Italian','French','German') THEN 'latin1'
WHEN name IN ('Japanese','Mandarin') THEN 'utf8'
ELSE 'Unknown'
END character_set
FROM language;

SELECT rating, count(*) FROM film
GROUP BY rating;

SELECT 
(SELECT COUNT(*) FROM (SELECT 1 FROM film WHERE rating = 'PG') tbl) PG,
(SELECT COUNT(*) FROM (SELECT 1 FROM film WHERE rating = 'G') tbl) G,
(SELECT COUNT(*) FROM (SELECT 1 FROM film WHERE rating = 'NC-17') tbl) NC_17,
(SELECT COUNT(*) FROM (SELECT 1 FROM film WHERE rating = 'PG-13') tbl) PG_13,
(SELECT COUNT(*) FROM (SELECT 1 FROM film WHERE rating = 'R') tbl) R;

SELECT
SUM(CASE WHEN rating = 'G' THEN 1 ELSE 0 END) g,
SUM(CASE WHEN rating = 'PG' THEN 1 ELSE 0 END) pg,
SUM(CASE WHEN rating = 'PG-13' THEN 1 ELSE 0 END) pg_13,
SUM(CASE WHEN rating = 'R' THEN 1 ELSE 0 END) r,
SUM(CASE WHEN rating = 'NC-17' THEN 1 ELSE 0 END) nc_17
FROM film;
