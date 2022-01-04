-- Drop column picture from staff.
ALTER TABLE sakila.staff
DROP COLUMN picture;

-- A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
INSERT INTO sakila.staff(first_name, last_name, address_id, email, store_id, active, username, password, last_update)
VALUES
('Tammy', 'Sanders', 79, 'TAMMY.SANDERS@sakilacustomer.org', 2, 1, 'Tammy', NULL, CURRENT_TIMESTAMP);

-- Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for the rental_date column in the rental table. 
-- Hint: Check the columns in the table rental and see what information you would need to add there. You can query those pieces of information. 
-- For eg., you would notice that you need customer_id information as well.
-- Use similar method to get inventory_id, film_id, and staff_id
INSERT INTO sakila.rental(rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
VALUES (CURRENT_TIMESTAMP, 1, 130, NULL, 1, CURRENT_TIMESTAMP);

-- Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
-- Check if there are any non-active users
SELECT * FROM sakila.customer
WHERE active IN ('0');

-- Create a table backup table as suggested
CREATE TABLE sakila.deleted_users (customer_id SMALLINT UNIQUE NOT NULL, email VARCHAR(150) , delete_date DATETIME);

-- Insert the non active users in the table backup table
INSERT INTO sakila.deleted_users (customer_id, email)
SELECT customer_id, email FROM sakila.customer WHERE active IN ('0');
UPDATE sakila.deleted_users
SET delete_date = CURRENT_TIMESTAMP;
SELECT * FROM sakila.deleted_users;

-- Delete the non active users from the table customer
SET FOREIGN_KEY_CHECKS=0;
DELETE FROM sakila.customer
WHERE active IN ('0');
SELECT DISTINCT (active) FROM sakila.customer;

