SELECT * FROM film;
SELECT * FROM inventory;
SELECT * FROM rental;

SELECT f.film_id, f.title, COUNT(*) num_copies FROM film f 
LEFT OUTER JOIN inventory i
ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY 1 ;

SELECT f.film_id, f.title, COUNT(i.inventory_id) num_copies FROM film f /* COUNT(*) won't work here, as min. it was counting was 1, instead of 0. */
LEFT OUTER JOIN inventory i
ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY 3 ;


SELECT f.film_id , i.inventory_id FROM film f
LEFT OUTER JOIN inventory i
ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY  2;

SELECT f.film_id, f.title, i.inventory_id, r.rental_date
FROM film f
LEFT OUTER JOIN inventory i
ON f.film_id = i.film_id
LEFT OUTER JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE f.film_id BETWEEN 13 AND 15;

SELECT * FROM category 
CROSS JOIN language;

SELECT days.dt, COUNT(r.rental_id) num_rentals
FROM rental r
RIGHT OUTER JOIN
(SELECT DATE_ADD('2005-01-01',
INTERVAL (ones.num + tens.num + hundreds.num) DAY) dt
FROM
(SELECT 0 num UNION ALL
SELECT 1 num UNION ALL
SELECT 2 num UNION ALL
SELECT 3 num UNION ALL
SELECT 4 num UNION ALL
SELECT 5 num UNION ALL
SELECT 6 num UNION ALL
SELECT 7 num UNION ALL
SELECT 8 num UNION ALL
SELECT 9 num) ones
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 10 num UNION ALL
SELECT 20 num UNION ALL
SELECT 30 num UNION ALL
SELECT 40 num UNION ALL
SELECT 50 num UNION ALL
SELECT 60 num UNION ALL
SELECT 70 num UNION ALL
SELECT 80 num UNION ALL
SELECT 90 num) tens
CROSS JOIN
(SELECT 0 num UNION ALL
SELECT 100 num UNION ALL
SELECT 200 num UNION ALL
SELECT 300 num) hundreds
WHERE DATE_ADD('2005-01-01',
INTERVAL (ones.num + tens.num + hundreds.num) DAY)
< '2006-01-01'
) days
ON days.dt = date(r.rental_date)
GROUP BY days.dt
ORDER BY 1;

SELECT cust.first_name, cust.last_name, date(r.rental_date)
FROM (SELECT customer_id, first_name, last_name
	FROM customer
	) cust
NATURAL JOIN rental r;

SELECT ones.x + tens.x + 1 FROM 
(SELECT 0 AS x UNION ALL
SELECT 1 UNION ALL
SELECT 2 UNION ALL
SELECT 3 UNION ALL
SELECT 4 UNION ALL
SELECT 5 UNION ALL
SELECT 6 UNION ALL
SELECT 7 UNION ALL
SELECT 8 UNION ALL
SELECT 9 
) ones
CROSS JOIN 
(SELECT 0 AS x UNION ALL
SELECT 10 UNION ALL
SELECT 20 UNION ALL
SELECT 30 UNION ALL
SELECT 40 UNION ALL
SELECT 50 UNION ALL
SELECT 60 UNION ALL
SELECT 70 UNION ALL
SELECT 80 UNION ALL
SELECT 90 
) tens
ORDER BY 1;
