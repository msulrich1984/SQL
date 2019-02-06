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