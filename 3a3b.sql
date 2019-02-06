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