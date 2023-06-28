SELECT table_name, table_type
FROM information_schema.tables
WHERE table_schema = 'sakila'
ORDER BY 1;

SELECT table_name, is_updatable
FROM information_schema.views
WHERE table_schema = 'sakila'
ORDER BY 1;

SELECT column_name, data_type,
character_maximum_length char_max_len,
numeric_precision num_prcsn, numeric_scale num_scale
FROM information_schema.columns
WHERE table_schema = 'sakila' AND table_name = 'film'
ORDER BY ordinal_position;

SELECT index_name, non_unique, seq_in_index, column_name
FROM information_schema.statistics
WHERE table_schema = 'sakila' AND table_name = 'rental'
ORDER BY 1, 3;

SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE table_schema = 'sakila'
ORDER BY 3,1;

CREATE VIEW my_view
AS
SELECT title, film_id, rating FROM film;

SELECT * from my_view;

SELECT view_definition
FROM information_schema.views
WHERE table_schema = 'sakila'
AND table_name = 'my_view';

DROP VIEW my_view;

SET @qry = 'SELECT customer_id, first_name, last_name FROM customer';
PREPARE dynsql1 FROM @qry;
EXECUTE dynsql1;
DEALLOCATE PREPARE dynsql1;

SET @qry = 'SELECT customer_id, first_name, last_name FROM customer WHERE customer_id = ?';
PREPARE dynsql2 FROM @qry;
SET @custid = 34;
EXECUTE dynsql2 USING @custid;
SET @custid = 4;
EXECUTE dynsql2 USING @custid;
DEALLOCATE PREPARE dynsql1;

SELECT DISTINCT table_name, index_name
FROM information_schema.statistics
WHERE table_schema = 'sakila';
