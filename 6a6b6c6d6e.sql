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


