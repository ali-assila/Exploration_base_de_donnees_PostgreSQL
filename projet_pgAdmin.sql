SELECT DISTINCT rating FROM film ;

SELECT DISTINCT rental_rate FROM film ;

SELECT rating, COUNT(rating) FROM film GROUP BY rating ORDER BY rating DESC; 

SELECT rental_rate, COUNT(rental_rate) FROM film GROUP BY rental_rate ORDER BY rental_rate DESC; 

SELECT * FROM rental;

SELECT  rental_date , COUNT (rental_id) AS Total_rentals FROM rental GROUP BY rental_date ORDER BY Total_rentals DESC;


SELECT EXTRACT (YEAR FROM rental_date), EXTRACT(MONTH FROM rental_date), COUNT(rental_id) AS Total_rentals FROM rental GROUP BY 1,2;

SELECT EXTRACT (YEAR FROM rental_date), EXTRACT(MONTH FROM rental_date), COUNT(rental_id) AS Total_rentals, COUNT(DISTINCT customer_id) AS unique_rental, 1.0*COUNT(rental_id)/ COUNT(DISTINCT customer_id) AS average FROM rental GROUP BY 1,2;

SELECT * FROM customer ;

SELECT * FROM address; 

SELECT email FROM customer WHERE first_name = 'Gloria' AND last_name = 'Cook';

SELECT description FROM film WHERE title = 'Texas Watch';

SELECT phone FROM address WHERE address='270 Toulon Boulevard';

SELECT customer_id, rental_date, return_date FROM rental WHERE customer_id IN (1,2) ORDER BY return_date DESC; 

SELECT first_name FROM customer WHERE first_name LIKE 'Jen%';

SELECT first_name FROM customer WHERE first_name LIKE 'Jenn_';

SELECT first_name FROM customer WHERE first_name LIKE '%er_';

SELECT COUNT(last_name) FROM actor WHERE last_name LIKE 'P%';

SELECT COUNT(title) FROM film WHERE title LIKE '%Truman%';

SELECT first_name, last_name, customer_id, address_id FROM customer WHERE first_name LIKE 'E%' AND address_id < 500 ORDER BY customer_id DESC LIMIT 5; 

SELECT staff_id, COUNT(amount), SUM(amount) FROM payment GROUP BY staff_id ;

SELECT rating , ROUND(AVG(replacement_cost),2) FROM film GROUP BY rating; 

SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 5; 

SELECT rating , AVG(rental_rate) FROM film WHERE rating IN ('R','G','PG') GROUP BY rating HAVING AVG (rental_rate) > 3; 

SELECT customer_id, COUNT(amount) FROM payment GROUP BY customer_id HAVING COUNT(amount)>30;

SELECT rating, AVG(rental_duration) FROM film GROUP BY rating HAVING AVG(rental_duration)>5;

SELECT customer_id, SUM(amount) FROM payment WHERE staff_id = 2 GROUP BY customer_id HAVING SUM(amount)>110;

SELECT customer.customer_id, first_name, last_name, email, amount, payment_date FROM customer INNER JOIN payment ON payment.customer_id = customer.customer_id ORDER BY first_name;

SELECT store_id, title, COUNT(title) AS number_at_store FROM inventory INNER JOIN film ON inventory.film_id = film.film_id GROUP BY store_id, title ORDER BY title;

SELECT title, name AS movie_language FROM film INNER JOIN language ON language.language_id = film.language_id;

SELECT f.film_id, title, inventory_id, store_id FROM film AS f LEFT OUTER JOIN inventory AS i ON f.film_id = i.film_id;

SELECT title, c.name AS Category, l.name AS Movie_language FROM film AS f INNER JOIN film_category AS fc ON f.film_id= fc.film_id  INNER JOIN category AS c ON c.category_id= fc.category_id INNER JOIN language AS l On l.language_id= f.language_id;
 
SELECT title, COUNT(rental_id) AS Number_of_rentals, COUNT(rental_id)* rental_rate AS revenue FROM film AS f INNER JOIN inventory AS i ON f.film_id= i.film_id INNER JOIN rental AS r ON i.inventory_id= r.inventory_id GROUP BY title, rental_rate ORDER BY revenue DESC;
  
SELECT store_id, SUM(p.amount) AS revenue FROM inventory AS i INNER JOIN rental AS r ON r.inventory_id = i.inventory_id INNER JOIN payment AS p ON p.rental_id = r.rental_id GROUP BY store_id ORDER BY revenue DESC;
  
SELECT c.name AS category, COUNT(r.rental_id) AS number_of_rentals_per_category FROM category AS c INNER JOIN film_category AS fc ON c.category_id = fc.category_id INNER JOIN film AS f ON fc.film_id = f.film_id INNER JOIN inventory AS i ON i.film_id = f.film_id INNER JOIN rental AS r ON r.inventory_id = i.inventory_id WHERE c.name IN('Action','Comedy','Animation') GROUP BY c.name;

SELECT email AS Customer_email, COUNT(rental_id) AS Number_of_rentals FROM customer AS c INNER JOIN rental AS r ON c.customer_id= r.customer_id GROUP BY email HAVING COUNT(rental_id)>= 40;