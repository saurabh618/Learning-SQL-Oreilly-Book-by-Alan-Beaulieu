SELECT * FROM customer
UNION
SELECT * FROM city; /* ERROR */ 

SELECT 1 AS num, 'abc' AS name
UNION
SELECT 2 AS id, 'xyz' AS item;

SELECT 'ACTOR' type, first_name, last_name FROM actor
UNION ALL
SELECT 'CUST' type, first_name, last_name FROM customer;

SELECT 'ACTOR' type, first_name, last_name FROM actor
UNION ALL
SELECT 'ACTOR' type, first_name, last_name FROM actor;

SELECT 'ACTOR' type, actor_id, first_name, last_name FROM actor
UNION
SELECT 'ACTOR' type, actor_id, first_name, last_name FROM actor;

SELECT first_name, last_name FROM customer
INTERSECT
SELECT first_name, last_name FROM actor;

SELECT first_name, last_name FROM customer
INTERSECT ALL
SELECT first_name, last_name FROM actor;

SELECT a.first_name, a.last_name FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
UNION
SELECT c.first_name, c.last_name FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
ORDER BY first_name;

SELECT a.first_name, a.last_name FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
INTERSECT
SELECT c.first_name, c.last_name FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

SELECT a.first_name, a.last_name FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
EXCEPT
SELECT c.first_name, c.last_name FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

SELECT a.first_name, a.last_name FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
EXCEPT ALL
SELECT c.first_name, c.last_name FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

SELECT a.first_name, a.last_name FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
UNION
SELECT a.first_name, a.last_name FROM actor a
WHERE a.first_name LIKE 'M%' AND a.last_name LIKE 'T%'
UNION ALL
SELECT c.first_name, c.last_name FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%';

SELECT a.first_name, a.last_name FROM actor a
WHERE a.first_name LIKE 'J%' AND a.last_name LIKE 'D%'
UNION
(SELECT a.first_name, a.last_name FROM actor a
WHERE a.first_name LIKE 'M%' AND a.last_name LIKE 'T%'
UNION ALL
SELECT c.first_name, c.last_name FROM customer c
WHERE c.first_name LIKE 'J%' AND c.last_name LIKE 'D%'
);

SELECT first_name, last_name FROM actor
WHERE last_name LIKE 'L%'
UNION
SELECT first_name, last_name FROM customer
WHERE last_name LIKE 'L%'
ORDER BY last_name;
