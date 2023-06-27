SET AUTOCOMMIT=0;

SHOW TABLE STATUS LIKE 'actor';

ALTER TABLE customer ENGINE = INNODB;

SAVEPOINT my_savepoint;

ROLLBACK TO SAVEPOINT my_savepoint;

CREATE TABLE person (
id SMALLINT(5) UNSIGNED  AUTO_INCREMENT,
name VARCHAR(20),
CONSTRAINT pk_person PRIMARY KEY (id)
);

DESC person;

INSERT INTO person (name)
VALUES ('saurabh'), ('rohan'), ('rahul');

SELECT * FROM person;

START TRANSACTION;

UPDATE person
SET name = 'amit'
WHERE id = 4;

SAVEPOINT first_update;

DELETE FROM person
WHERE id < 10;

ROLLBACK TO SAVEPOINT first_update;

ROLLBACK;

COMMIT;

START TRANSACTION;

UPDATE account
SET avail_balance = avail_balance - 50,
last_activity_date = now()
WHERE account_id = 123;

INSERT INTO transaction (txn_date, account_id, txn_type_cd, amount)
VALUES (CURRENT_DATE(), 123, 'D', 50);

UPDATE account
SET avail_balance = avail_balance + 50,
last_activity_date = now()
WHERE account_id = 789;

INSERT INTO transaction (txn_date, account_id, txn_type_cd, amount)
VALUES (CURRENT_DATE(), 789, 'C', 50);

COMMIT;
