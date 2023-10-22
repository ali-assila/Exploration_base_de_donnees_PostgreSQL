SELECT DISTINCT rating FROM film ;    -- Afficher les différentes notes dans la table film

SELECT DISTINCT rental_rate FROM film ; -- Afficher les différents taux de locations

SELECT rating, COUNT(rating) FROM film GROUP BY rating ORDER BY rating DESC;  -- Compter le nombre des différents rating

SELECT rental_rate, COUNT(rental_rate) FROM film GROUP BY rental_rate ORDER BY rental_rate DESC; -- Compter le nombre des différents rental_rate

SELECT * FROM rental; -- Afficher toutes les colonnes de la table rental 

SELECT*  rental_date , COUNT (rental_id) AS Total_rentals FROM rental GROUP BY rental_date ORDER BY Total_rentals DESC; -- Afficher les dates de locations par mois 

SELECT EXTRACT (YEAR FROM rental_date), EXTRACT(MONTH FROM rental_date), COUNT(rental_id) AS Total_rentals FROM rental GROUP BY 1,2; -- Afficher et grouper les dates de locations par mois et année  

SELECT EXTRACT (YEAR FROM rental_date), EXTRACT(MONTH FROM rental_date), COUNT(rental_id) AS Total_rentals, COUNT(DISTINCT customer_id) AS unique_rental, 1.0* COUNT(rental_id)/ COUNT(DISTINCT customer_id) AS average FROM rental GROUP BY 1,2; -- Calculer le nombre de location unique et la moyenne de location par mois


SELECT * FROM customer ; -- Afficher toutes les colonnes de la table client 

SELECT * FROM address;  -- Afficher toutes les colonnes de la table adresse  

SELECT email FROM customer WHERE first_name = 'Gloria' AND last_name = 'Cook'; -- Récupérer un email d'une personne qui s'ppelle "Gloria Cook" 

SELECT description FROM film WHERE title = 'Texas Watch'; -- Récupérer la description du film 'Texas Watch'

SELECT phone FROM address WHERE address='270 Toulon Boulevard'; -- Récupérer un numéro de téléphone à partir d'une adresse postale

SELECT customer_id, rental_date, return_date FROM rental WHERE customer_id IN (1,2) ORDER BY return_date DESC; -- Récupérer la date de retour en filtrant par id de client 

SELECT first_name FROM customer WHERE first_name LIKE 'Jen%'; -- Récupérer le nom qui commence par 'JEN' et le % veut dire n'importe quel caractère après Jen (ensemble de chaine de caractère)

SELECT first_name FROM customer WHERE first_name LIKE 'Jenn_'; -- Récupérer le nom qui commence par 'JEN' et le _ veut dire n'importe quel caractère après Jen mais un seul 

SELECT first_name FROM customer WHERE first_name LIKE '%er_'; -- Récupérer le nom qui commence par n'importe quel chaine de caractère et après le 'er' un seul caractère

SELECT COUNT(last_name) FROM actor WHERE last_name LIKE 'P%'; -- Compter le nombre d'acteurs dont le nom de famille commence par P 

SELECT COUNT(title) FROM film WHERE title LIKE '%Truman%'; -- Compter le nombre de film qui contiennent Truman dans leur titre

SELECT first_name, last_name, customer_id, address_id FROM customer WHERE first_name LIKE 'E%' AND address_id < 500 ORDER BY customer_id DESC LIMIT 5; -- Client ayant le plus grand customer_id et dont le prénom commence par 'E' et a un address_id < 500

SELECT staff_id, COUNT(amount), SUM(amount) FROM payment GROUP BY staff_id ; -- Afficher staff_id 1 et staff_id 2 en groupant par staff_id et compter le montant de chaque staff et le montant total généré 

SELECT rating , ROUND(AVG(replacement_cost),2) FROM film GROUP BY rating; -- Afficher la moyenne de rempalcement par lettre de notation (ex: R, PG, etc ... )

SELECT customer_id, SUM(amount) FROM payment GROUP BY customer_id ORDER BY SUM(amount) DESC LIMIT 5;  -- Afficher les IDs de 5 personnes qui ont dépnsé le plus d'argent dans le magasin 

SELECT rating , AVG(rental_rate) FROM film WHERE rating IN ('R','G','PG') GROUP BY rating HAVING AVG (rental_rate) > 3; -- Filtrer les résultats d'une requête GROUP BY , HAVING : condition sur une colonne qu'on a créée virtuellement

SELECT customer_id, COUNT(amount) FROM payment GROUP BY customer_id HAVING COUNT(amount)>30; -- Afficher les IDs de clients qui totalisent au moins 30 transations de paiment(table payment)

SELECT rating, AVG(rental_duration) FROM film GROUP BY rating HAVING AVG(rental_duration)>5; -- Obtenir les notations(ex: R, PG, etc ... ) dont la durée de location moyenne >5 

SELECT customer_id, SUM(amount) FROM payment WHERE staff_id = 2 GROUP BY customer_id HAVING SUM(amount)>110; -- Obtenir les IDs des clients qui ont payés plus de 110$ à l équipe staff 2 

SELECT customer.customer_id, first_name, last_name, email, amount, payment_date FROM customer INNER JOIN payment ON payment.customer_id = customer.customer_id ORDER BY first_name; -- Afficher les résultats du client sur ses infos persos mais aussi sur les montants dépensés et la date de paiments et ranger par ordre croissant de prénom

SELECT store_id, title, COUNT(title) AS number_at_store FROM inventory INNER JOIN film ON inventory.film_id = film.film_id GROUP BY store_id, title ORDER BY title; -- Afficher le nombre de chaque film par magasin et classer le titre par ordre croissant 

SELECT title, name AS movie_language FROM film INNER JOIN language ON language.language_id = film.language_id; -- Afficher le titre du film avec la langue

SELECT f.film_id, title, inventory_id, store_id FROM film AS f LEFT OUTER JOIN inventory AS i ON f.film_id = i.film_id; -- Afficher tous les films de la table films et s'il n'y a pas de correspendance il affiche la valeur NULL

SELECT title, c.name AS Category, l.name AS Movie_language FROM film AS f INNER JOIN film_category AS fc ON f.film_id= fc.film_id  INNER JOIN category AS c ON c.category_id= fc.category_id INNER JOIN language AS l On l.language_id= f.language_id; -- Afficher tous les titres de film + catégorie + langue 

SELECT title, COUNT(rental_id) AS Number_of_rentals, COUNT(rental_id)* rental_rate AS revenue FROM film AS f INNER JOIN inventory AS i ON f.film_id= i.film_id INNER JOIN rental AS r ON i.inventory_id= r.inventory_id GROUP BY title, rental_rate ORDER BY revenue DESC; -- Quel est le film qui a apporté le plus et combien a-t-il rapporté?

SELECT store_id, SUM(p.amount) AS revenue FROM inventory AS i INNER JOIN rental AS r ON r.inventory_id = i.inventory_id INNER JOIN payment AS p ON p.rental_id = r.rental_id GROUP BY store_id ORDER BY revenue DESC; -- Quel est le magasin qui a le plus vendu?

SELECT c.name AS category, COUNT(r.rental_id) AS number_of_rentals_per_category FROM category AS c INNER JOIN film_category AS fc ON c.category_id = fc.category_id INNER JOIN film AS f ON fc.film_id = f.film_id INNER JOIN inventory AS i ON i.film_id = f.film_id INNER JOIN rental AS r ON r.inventory_id = i.inventory_id WHERE c.name IN('Action','Comedy','Animation') GROUP BY c.name; -- Combien y a-t-il de locations pour les films d'action, comédie et d'animations

SELECT email AS Customer_email, COUNT(rental_id) AS Number_of_rentals FROM customer AS c INNER JOIN rental AS r ON c.customer_id= r.customer_id GROUP BY email HAVING COUNT(rental_id)>= 40; -- Afficher les emails des clients qui ont loué plus de 40 films