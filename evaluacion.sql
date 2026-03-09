USE sakila;

/* Selecciona todos los nombres de las películas sin que aparezcan duplicados. */

SELECT *
	FROM film;

SELECT film_id, title, COUNT(film_id) AS quantity
	FROM film
    GROUP BY film_id, title
    ORDER BY quantity DESC;
    
-- query final 

SELECT title
	FROM film;
    
/* Muestra los nombres de todas las películas que tengan una clasificación de "PG-13". */

SELECT *
	FROM film;
    
SELECT *
	FROM film
    WHERE rating = "PG-13";
    
-- query final

SELECT title
	FROM film
    WHERE rating = "PG-13";
    
/* Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su
descripción. */

SELECT title, description
	FROM film;
    
-- query final

SELECT title, description   
	FROM film
    WHERE description REGEXP "\\bamazing\\b";
    
/* Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. */

SELECT title, length
	FROM film;
    
-- query final

SELECT title, length
	FROM film
    WHERE length > 120
    ORDER BY length ASC;
    
/* Recupera los nombres de todos los actores. */

SELECT actor_id, first_name, last_name, COUNT(actor_id) AS quantity
	FROM actor
    GROUP BY actor_id, first_name, last_name;
    
-- query final

SELECT CONCAT(first_name, " ", last_name) AS actors
	FROM actor;
    
/* Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido. */

SELECT first_name, last_name
	FROM actor
    WHERE last_name = "Gibson";
    
/* Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. */

SELECT actor_id, first_name, last_name 
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
    
/* Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
clasificación. */

SELECT title, rating
	FROM film
    WHERE rating NOT IN ("R", "PG-13");
    
-- query final

SELECT title
	FROM film
    WHERE rating NOT IN ("R", "PG-13");
    
/* Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la
clasificación junto con el recuento. */

SELECT rating, COUNT(rating) AS QuantityForRating
	FROM film
    GROUP BY rating
    ORDER BY rating;
    
/* Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas. */

SELECT *
	FROM customer AS c
    LEFT JOIN rental AS r
		ON c.customer_id = r.customer_id;
        
-- query final
    
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.customer_id) AS RentalQuantity
		FROM customer AS c
		LEFT JOIN rental AS r
			ON c.customer_id = r.customer_id
		GROUP BY c.customer_id, c.first_name, c.last_name
        ORDER BY RentalQuantity DESC;
        
/* Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
junto con el recuento de alquileres. */

SELECT *
	FROM category;
    
SELECT rental_id, inventory_id, COUNT(inventory_id)
	FROM rental
    GROUP BY rental_id, inventory_id;
    
SELECT *
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
	INNER JOIN inventory AS i
		ON f.film_id = i.film_id
	INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id;
        
-- query final
        
SELECT c.name AS category, COUNT(r.rental_id) AS TotalRental
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
	INNER JOIN inventory AS i
		ON f.film_id = i.film_id
	INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id
	GROUP BY c.name
    ORDER BY TotalRental DESC;
    
/* Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración. */

SELECT rating, AVG(length) AS AverageDuration
	FROM film
    GROUP BY rating;
    
/* 
	