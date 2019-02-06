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