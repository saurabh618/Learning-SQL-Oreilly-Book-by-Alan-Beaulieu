DESC customer; 

ALTER TABLE customer
ADD INDEX idx_email (email);

SHOW INDEXES FROM customer;

ALTER TABLE customer
DROP INDEX idx_email;

ALTER TABLE customer
ADD UNIQUE idx_email (email); -- Adding UNIQUE INDEX

SELECT * FROM customer;

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active)
VALUES (1,'ALAN','KAHN', 'ALAN.KAHN@sakilacustomer.org', 394, 1);

ALTER TABLE customer
ADD INDEX idx_full_name (last_name, first_name);

EXPLAIN
SELECT customer_id, first_name, last_name
FROM customer
WHERE first_name LIKE 'S%' AND last_name LIKE 'P%';

CREATE TABLE customer (
customer_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
store_id TINYINT UNSIGNED NOT NULL,
first_name VARCHAR(45) NOT NULL,
last_name VARCHAR(45) NOT NULL,
email VARCHAR(50) DEFAULT NULL,
address_id SMALLINT UNSIGNED NOT NULL,
active BOOLEAN NOT NULL DEFAULT TRUE,
create_date DATETIME NOT NULL,
last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP,
PRIMARY KEY (customer_id),
KEY idx_fk_store_id (store_id),
KEY idx_fk_address_id (address_id),
KEY idx_last_name (last_name),
CONSTRAINT fk_customer_address FOREIGN KEY (address_id)
REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_customer_store FOREIGN KEY (store_id)
REFERENCES store (store_id) ON DELETE RESTRICT ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE customer
ADD CONSTRAINT fk_customer_address FOREIGN KEY (address_id)
REFERENCES address (address_id) ON DELETE RESTRICT ON UPDATE CASCADE;

SELECT * FROM customer c
INNER JOIN address a
ON c.customer_id = a.address_id
WHERE c.customer_id = 123;

DELETE FROM address
WHERE address_id = 123;

UPDATE address
SET address_id = 123
WHERE address_id = 9999;

/*
Generate an alter table statement for the rental table so that an error will be
raised if a row having a value found in the rental.customer_id column is deleted
from the customer table.
*/
DESC rental;
DESC customer;

ALTER TABLE rental 
ADD CONSTRAINT fk__rental_customer FOREIGN KEY (customer_id)
REFERENCES customer (customer_id) ON DELETE RESTRICT;

ALTER TABLE payment
ADD INDEX indx_date (payment_date); 

ALTER TABLE payment
ADD INDEX indx_amt (amount); 

CREATE INDEX idx_payment01
ON payment (payment_date, amount);
