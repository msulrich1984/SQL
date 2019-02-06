USE sakila;
SELECT * FROM actor;
SELECT * FROM actor;
ALTER TABLE actor
ADD COLUMN actor_name VARCHAR(50);
UPDATE actor SET actor_name = CONCAT(first_name," ",last_name);
SELECT * FROM actor;