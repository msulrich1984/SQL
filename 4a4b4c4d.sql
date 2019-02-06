#4a. List the last names of actors, as well as how many actors have that last name.
#So what I need to do here is SELECT the last names, as well as a count of frequency.
SELECT last_name, COUNT(*) AS num 
FROM actor GROUP BY last_name;


#4b. List last names of actors and the number of actors who have that last name, but only for names that 
#are shared by at least two actors
#This is a repetition of the code above with a limitation.
SELECT last_name, COUNT(*) AS num 
FROM actor GROUP BY last_name 
HAVING num >= 2;

#4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. 
#Write a query to fix the record.
UPDATE actor
SET first_name = 'HARPO', actor_name = 'HARPO WILLIAMS' WHERE actor_name = 'GROUCHO WILLIAMS';

SELECT * FROM actor WHERE first_name = 'HARPO';

#4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name 
#after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO
UPDATE actor
SET first_name = 'GROUCHO', actor_name = 'GROUCHO WILLIAMS' WHERE actor_name = 'HARPO WILLIAMS';
SELECT * FROM actor WHERE first_name = 'GROUCHO';
