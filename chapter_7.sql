CREATE TABLE string_tbl
(char_fld CHAR(30),
vchar_fld VARCHAR(30),
text_fld TEXT
);

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This is char data', 'This is varchar data', 'This is text data');

UPDATE string_tbl 
SET vchar_fld = 'This is a piece of extremely long varchar data';

SHOW WARNINGS;

SELECT * FROM string_tbl;

SELECT @@session.sql_mode;

SET sql_mode='ansi';

SET sql_mode='';
SET SQL_SAFE_UPDATES = 0;

/*
UPDATE string_tbl
SET text_fld = 'This string doesn't work';
*/

UPDATE string_tbl
SET text_fld = 'This string '' should \' work';

SELECT quote(text_fld)
FROM string_tbl;

SELECT 'abcdefg', CHAR(97,98,99,100,101,102,103);
SELECT CHAR(128,129,130,131,132,133,134,135,136,137);

SELECT ASCII('ö');

DELETE FROM string_tbl;

DESC string_tbl;

INSERT INTO string_tbl (char_fld, vchar_fld, text_fld)
VALUES ('This string is 28 characters  ', 'This string is 28 characters  ', 'This string is 28 characters  ');

SELECT * FROM string_tbl;

SELECT LENGTH(char_fld), LENGTH(vchar_fld), LENGTH(text_fld) FROM string_tbl;

SELECT POSITION('is' IN vchar_fld) FROM string_tbl;

SELECT POSITION('isyu' IN vchar_fld) FROM string_tbl;

SELECT LOCATE('is', vchar_fld, 5) FROM string_tbl; /* It starts the seach from the 5th position. */

SELECT name, name LIKE '%N' 
FROM category;

SELECT name, name REGEXP 'y$' ends_in_y
FROM category;

UPDATE string_tbl 
SET text_fld = CONCAT(text_fld, ', but now it is longer');

SELECT concat(first_name, ' ', last_name, ' has been a customer since ', date(create_date)) cust_narrative
FROM customer;

SELECT INSERT ('Goodbye World!', 9, 0, 'Cruel ') AS string;

SELECT INSERT('goodbye world', 1, 7, 'hello') AS string;

SELECT SUBSTRING('goodbye cruel world', 9, 5);

SELECT (37 * 59) / (78 - (8 * 6));

SELECT MOD(12.5, 4);

SELECT POW(2,8);

SELECT CEIL(72.445), FLOOR(72.645);

SELECT ROUND(72.49999), ROUND(72.5), ROUND(72.50001);

SELECT ROUND(72.0909, 1), ROUND(72.0909, 2), ROUND(72.0909, 3);

SELECT TRUNCATE(72.0909, 1), TRUNCATE(72.0909, 2), TRUNCATE(72.0909, 3);

SELECT ROUND(167, -1), TRUNCATE(167, -1);

SELECT account_id, SIGN(balance), ABS(balance) FROM account;

SELECT UTC_TIMESTAMP(), NOW();

SELECT @@global.time_zone, @@session.time_zone;

SET time_zone = 'Europe/Zurich';

SELECT CAST('2019-09-17 15:30:00' AS DATETIME);
SELECT CAST('2019/09/17 15,30,00' AS DATETIME);

SELECT CAST('2019-09-17' AS DATE) date_field, CAST('108:17:57' AS TIME) time_field;

UPDATE rental
SET return_date = STR_TO_DATE('September 17, 2019', '%M %d, %Y')
WHERE rental_id = 99999;

SELECT STR_TO_DATE('September 17, 2019', '%M %d, %Y');

SELECT STR_TO_DATE('sept, 17, 20', '%M, %d, %y');

SELECT CURRENT_DATE(), CURRENT_TIME(), CURRENT_TIMESTAMP();

SELECT DATE_ADD(NOW(), INTERVAL 10 DAY);

UPDATE rental
SET return_date = DATE_ADD(return_date, INTERVAL '3:27:11' HOUR_SECOND)
WHERE rental_id = 99999;

UPDATE employee
SET birth_date = DATE_ADD(birth_date, INTERVAL '9-11' YEAR_MONTH)
WHERE emp_id = 4789;

SELECT LAST_DAY('2023-06-25');

SELECT DAYNAME('2019-09-18');

SELECT EXTRACT(MONTH FROM '2019-09-18 22:19:05');

SELECT DATEDIFF('1993-08-06', '2023-06-25');

SELECT CAST('999ABC111' AS UNSIGNED INTEGER); /* Output came, but with a warning. */

SHOW WARNINGS;

SELECT SUBSTRING('Please find the substring in this string', 17, 9);

SELECT ROUND(-25.76823,2), ABS(-25.76823), SIGN(-25.76823);

SELECT EXTRACT(MONTH FROM CURRENT_DATE());
