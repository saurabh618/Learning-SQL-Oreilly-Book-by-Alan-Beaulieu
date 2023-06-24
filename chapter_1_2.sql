SHOW DATABASES;

USE sakila;

SHOW TABLES;

SELECT now() FROM dual;

SHOW CHARACTER SET;

/*
VARCHAR(MAX) - Not working
TIMESTAMP - It doesn't populate any timestamp by defalt if a new row is inserted without timestamp.
CHECK - This contraints working exactly as ENUM. 
*/

/* varchar(20) character set latin1 */

/* create database european_sales character set latin1; */

CREATE TABLE person (
	person_id SMALLINT UNSIGNED /*AUTO_INCREMENT*/,
    fname tinytext,
    lname longtext, 
    /* eye_color CHAR(2) CHECK (eye_color IN ('BR', 'BL', 'GR')), */
    eye_color ENUM ('BR', 'BL', 'GR'),
    birth_date timestamp,
    street text,
    city mediumtext,
    state VARCHAR(20),
    country VARCHAR(20),
    postal_code VARCHAR(20),
    CONSTRAINT pk_person PRIMARY KEY (person_id)
);

DESC person;

set foreign_key_checks = 0;
ALTER TABLE person MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;
set foreign_key_checks = 1;

CREATE TABLE favorite_food (
	person_id SMALLINT UNSIGNED,
    food VARCHAR(20),
    CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
    CONSTRAINT fk_person FOREIGN KEY (person_id) REFERENCES person (person_id)
);

DESC favorite_food;

INSERT INTO person (person_id, fname, lname, eye_color, birth_date)
VALUES (NULL, 'William','Turner', 'BR', '1972-05-27');

SELECT * FROM person;

INSERT INTO favorite_food (person_id, food) VALUES (1, 'pizza');
INSERT INTO favorite_food (person_id, food) VALUES (1, 'cookies');
INSERT INTO favorite_food (person_id, food) VALUES (1, 'nachos');

SELECT * FROM favorite_food;

UPDATE person
SET street = '1225 Tremont St.',
city = 'Boston',
state = 'MA',
country = 'USA',
postal_code = '02138'
WHERE person_id = 1;

INSERT INTO person (person_id, fname, lname, eye_color, birth_date, street, city, state, country, postal_code)
VALUES (null, 'Susan','Smith', 'BL', '1975-11-02', '23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

DELETE FROM person WHERE person_id = 2;

UPDATE person
SET birth_date = str_to_date('DEC-21-1980' , '%b-%d-%Y')
WHERE person_id = 1;

DROP TABLE person;
DROP TABLE favorite_food;
