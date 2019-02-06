USE sakila;
SELECT * FROM actor;
SELECT * FROM actor;
ALTER TABLE actor
ADD COLUMN actor_name VARCHAR(50);
UPDATE actor SET actor_name = CONCAT(first_name," ",last_name);
SELECT * FROM actor;
SELECT * FROM actor;
SELECT actor_id, actor_name FROM actor WHERE actor.first_name = "Joe";

#2b. Find all actors whose last name contain the letters GEN:
SELECT actor_name FROM actor WHERE actor.last_name LIKE '%GEN%';
#2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
SELECT last_name, first_name FROM actor WHERE actor.last_name LIKE '%LI%';
#2d. Using IN, display the country_id and country columns of the following countries: 
#Afghanistan, Bangladesh, and China:
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh','China');

#3a. You want to keep a description of each actor. You don't think you will be performing queries on a description,
# so create a column in the table actor named description and use the data type BLOB (Make sure to research 
#the type BLOB, as the difference between it and VARCHAR are significant).
SELECT * FROM actor;
ALTER TABLE actor ADD COLUMN (description BLOB);
#Since BLOB is anything, whereas TEXT is TEXT, I guess I'm planning to insert a poster image or something?
SELECT * FROM actor;
#3b. Very quickly you realize that entering descriptions for each actor is too much effort. Delete the description
# column.
ALTER TABLE actor DROP COLUMN description;
SELECT * FROM actor;

UPDATE actor
SET first_name = 'HARPO', actor_name = 'HARPO WILLIAMS' WHERE actor_name = 'GROUCHO WILLIAMS';

SELECT * FROM actor WHERE first_name = 'HARPO';

#4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name 
#after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO
UPDATE actor
SET first_name = 'GROUCHO', actor_name = 'GROUCHO WILLIAMS' WHERE actor_name = 'HARPO WILLIAMS';
SELECT * FROM actor WHERE first_name = 'GROUCHO';
#5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
DESCRIBE address;
#6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables
# staff and address:
SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON
staff.address_id = address.address_id;

#6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and
# payment.
SELECT staff.first_name, staff.last_name, SUM(payment.amount)
FROM staff
INNER JOIN payment ON
staff.staff_id = payment.staff_id GROUP BY payment.staff_id;
#Holy cow, that worked.


#6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film.
#Use inner join.
SELECT film.title AS 'Film Title', COUNT(film_actor.actor_id) AS 'Number of Actors'
FROM film_actor
INNER JOIN film 
ON film_actor.film_id= film.film_id
GROUP BY film.title;


#6d. How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT film.title AS 'Title', COUNT(inventory.inventory_id) AS 'Number of Copies'
FROM film
INNER JOIN inventory
ON film.film_id = inventory.film_id WHERE film.title='Hunchback Impossible';

#6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name:
SELECT customer.first_name, customer.last_name, sum(payment.amount) AS 'Total Paid'
FROM customer
JOIN payment
ON customer.customer_id= payment.customer_id
GROUP BY customer.last_name
ORDER BY last_name;
#7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, 
#films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles 
# of movies starting with the letters K and Q whose language is English.
SELECT * FROM film WHERE title LIKE 'K%' OR title LIKE 'Q%'
AND title IN
	(SELECT title FROM film WHERE language_id = 1);
#SELECT * FROM language
#7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
SELECT actor_id
FROM film_actor
WHERE film_id IN 
(
SELECT film_id
FROM film
WHERE title = 'Alone Trip'
));


#7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses
# of all Canadian customers. Use joins to retrieve this information.
SELECT customer.first_name AS 'First Name', customer.last_name AS 'Last Name', customer.email AS 'Email' 
FROM customer
JOIN address
ON (customer.address_id = address.address_id)
JOIN city
ON (city.city_id = address.city_id)
JOIN country
ON (country.country_id = city.country_id)
WHERE country.country= 'Canada';

#7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion.
# Identify all movies categorized as family films.
SELECT title, description FROM film 
WHERE film_id IN
(
(SELECT film_id FROM film_category
WHERE category_id IN
(SELECT category_id 
FROM category 
WHERE name = 'Family'
)));
#7e. Display the most frequently rented movies in descending order.
SELECT film.title, COUNT(rental_id) AS 'Times Rented'
FROM rental
JOIN inventory
ON (rental.inventory_id = inventory.inventory_id)
JOIN film
ON (inventory.film_id = film.film_id)
GROUP BY film.title
ORDER BY 'Times Rented' DESC;


#7f. Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, SUM(amount) AS 'Revenue in $'
FROM payment
JOIN rental
ON (payment.rental_id = rental.rental_id)
JOIN inventory
ON (inventory.inventory_id = rental.inventory_id)
JOIN store
ON (store.store_id = inventory.store_id)
GROUP BY store.store_id; 

#7g. Write a query to display for each store its store ID, city, and country.
SELECT store.store_id, city.city, country.country 
FROM store 
JOIN address  
ON (store.address_id = address.address_id)
JOIN city
ON (city.city_id = address.city_id)
JOIN country
ON (country.country_id = city.country_id);


#7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the 
#following tables: category, film_category, inventory, payment, and rental.)

SELECT category.name AS 'Genre', SUM(payment.amount) AS 'Gross' 
FROM category
JOIN film_category 
ON (category.category_id=film_category.category_id)
JOIN inventory 
ON (film_category.film_id=inventory.film_id)
JOIN rental 
ON (inventory.inventory_id=rental.inventory_id)
JOIN payment
ON (rental.rental_id=payment.rental_id)
GROUP BY category.name ORDER BY Gross  LIMIT 5;
#8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres 
#by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can 
#substitute another query to create a view.
CREATE VIEW genre_gross_revenue AS
SELECT category.name AS 'Genre', SUM(payment.amount) AS 'Gross' 
FROM category
JOIN film_category 
ON (category.category_id=film_category.category_id)
JOIN inventory 
ON (film_category.film_id=inventory.film_id)
JOIN rental 
ON (inventory.inventory_id=rental.inventory_id)
JOIN payment
ON (rental.rental_id=payment.rental_id)
GROUP BY category.name ORDER BY Gross  LIMIT 5;

#8b. How would you display the view that you created in 8a?
SELECT * FROM  genre_gross_revenue;

#8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
DROP VIEW genre_gross_revenue;