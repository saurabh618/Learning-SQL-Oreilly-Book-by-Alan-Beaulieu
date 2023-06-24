SELECT first_name, last_name, address
FROM customer c JOIN address a; /* Gives all permutations and combinations. */

SELECT first_name, last_name, address
FROM customer c JOIN address a
ON c.address_id = a.address_id;

/* JOIN gets treated as INNER JOIN by the server */

SELECT first_name, last_name, address
FROM customer c INNER JOIN address a
USING (address_id); /* If the column name is identical, we can use USING. */

/* Older version, don't use this as it has no advantage over the current version */
SELECT first_name, last_name, address
FROM customer c, address a
WHERE c.address_id = a.address_id;

SELECT first_name, last_name, city
FROM customer c INNER JOIN address a INNER JOIN city 
ON c.address_id = a.address_id AND a.city_id = city.city_id
ORDER BY city;

SELECT first_name, last_name, city
FROM customer c INNER JOIN address a
ON c.address_id = a.address_id 
INNER JOIN city 
ON a.city_id = city.city_id
ORDER BY city;

SELECT STRAIGHT_JOIN first_name, last_name, city
FROM customer c INNER JOIN address a
ON c.address_id = a.address_id 
INNER JOIN city 
ON a.city_id = city.city_id
ORDER BY city;

SELECT c.first_name, c.last_name, sub_table.city
FROM customer AS c INNER JOIN (SELECT a.address_id, city.city
							FROM address AS a INNER JOIN city
                            ON a.city_id = city.city_id
                            WHERE a.district = 'California'
                            ) AS sub_table
ON c.address_id = sub_table.address_id;

SELECT f.title
FROM actor a INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
INNER JOIN film f
ON f.film_id = fa.film_id
WHERE (a.first_name = 'CATE' AND a.last_name = 'MCQUEEN') OR (a.first_name = 'CUBA' AND a.last_name = 'BIRCH');

SELECT f.title
FROM actor a INNER JOIN film_actor fa
ON a.actor_id = fa.actor_id
INNER JOIN film f
ON f.film_id = fa.film_id
WHERE (a.first_name = 'CATE' AND a.last_name = 'MCQUEEN') OR (a.first_name = 'CUBA' AND a.last_name = 'BIRCH')
GROUP BY fa.film_id
HAVING COUNT(*) > 1;

SELECT f.title
FROM film f
INNER JOIN film_actor fa1
ON f.film_id = fa1.film_id
INNER JOIN actor a1
ON fa1.actor_id = a1.actor_id
INNER JOIN film_actor fa2
ON f.film_id = fa2.film_id
INNER JOIN actor a2
ON fa2.actor_id = a2.actor_id
WHERE (a1.first_name = 'CATE' AND a1.last_name = 'MCQUEEN')
AND (a2.first_name = 'CUBA' AND a2.last_name = 'BIRCH');

SELECT c.first_name, c.last_name, a.address, ct.city
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
INNER JOIN city ct
ON a.city_id = ct.city_id
WHERE a.district = 'California';

SELECT f.title 
FROM film f INNER JOIN film_actor fa
ON f.film_id = fa.film_id
INNER JOIN actor a
ON a.actor_id = fa.actor_id
WHERE a.first_name LIKE 'JOHN';

SELECT a1.address addr1, a2.address addr2, a1.city_id
FROM address a1 INNER JOIN address a2
ON a1.city_id = a2.city_id
WHERE a1.address <> a2.address;
