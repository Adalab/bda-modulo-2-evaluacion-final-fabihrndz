USE sakila;

/*1. Selecciona todos los nombres de las películas sin que aparezcan duplicados. */

SELECT *
	FROM film;

SELECT film_id, title, COUNT(film_id) AS quantity    
	FROM film
    GROUP BY film_id, title
    ORDER BY quantity DESC;
    
-- query final 

SELECT title
	FROM film;
    
/* 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13". */

-- query final

SELECT title
	FROM film
    WHERE rating = "PG-13";
    
/* 3. Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su
descripción. */
 
-- query final

SELECT title, description   
	FROM film
    WHERE description REGEXP "\\bamazing\\b";            -- "\\" para escapar la letra "b", "b" para decir que no hay mas letras ni antes ni despues
    
/* 4. Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos. */

SELECT title, length
	FROM film
    WHERE length > 120
    ORDER BY length ASC;

-- query final

SELECT title
	FROM film
    WHERE length > 120;
    
/* 5. Recupera los nombres de todos los actores. */

SELECT actor_id, first_name, last_name, COUNT(actor_id) AS quantity
	FROM actor
    GROUP BY actor_id, first_name, last_name;
    
-- query final

SELECT CONCAT(first_name, " ", last_name) AS actors               -- uno las columnas nombre y apellido para tener el nombre completo del actor en una columna
	FROM actor;
    
/* 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido. */

SELECT first_name, last_name
	FROM actor
    WHERE last_name = "Gibson";
    
/* 7. Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20. */

SELECT actor_id, first_name, last_name 
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;     
    
-- query final

SELECT first_name, last_name 
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;         
    
/* 8. Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
clasificación. */

SELECT title, rating
	FROM film
    WHERE rating NOT IN ("R", "PG-13");
    
-- query final

SELECT title
	FROM film
    WHERE rating NOT IN ("R", "PG-13");
    
/* 9. Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la
clasificación junto con el recuento. */

SELECT rating, COUNT(rating) AS QuantityForRating
	FROM film
    GROUP BY rating
    ORDER BY rating;
    
/* 10. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas. */

SELECT *
	FROM customer AS c
    LEFT JOIN rental AS r
		ON c.customer_id = r.customer_id;
        
-- query final
    
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.customer_id) AS RentalQuantity   -- cuento por el costumer_id en rental 
		FROM customer AS c
		LEFT JOIN rental AS r                                            -- uno la tabla customer con rental
			ON c.customer_id = r.customer_id
		GROUP BY c.customer_id, c.first_name, c.last_name          
        ORDER BY RentalQuantity DESC;
        
/* 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
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
        
SELECT c.name AS category, COUNT(r.rental_id) AS TotalRental      -- sumo el rental_id por cada categoria
	FROM category AS c
    INNER JOIN film_category AS fc                             -- conecto todas las tablas necesarias para ir de categoria a rental siguendo el esquema
		ON c.category_id = fc.category_id              
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
	INNER JOIN inventory AS i
		ON f.film_id = i.film_id
	INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id
	GROUP BY c.name                                           -- lo agrupo por el nombre de la categoria                        
    ORDER BY TotalRental DESC;
    
/* 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración. */

SELECT rating, AVG(length) AS AverageDuration    -- promedio de duracion
	FROM film
    GROUP BY rating;
    
/* 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love". */

SELECT *
	FROM film
    WHERE title = "Indian Love";
    
SELECT *
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
	INNER JOIN film AS f
		ON fa.film_id = f.film_id;
	
-- query final

SELECT a.first_name, a.last_name
	FROM actor AS a
    INNER JOIN film_actor AS fa                               -- uno las tablas para conectar actores con peliculas
		ON a.actor_id = fa.actor_id
	INNER JOIN film AS f
		ON fa.film_id = f.film_id
	WHERE f.title = "Indian Love";                       -- condicion
    
/* 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción. */

SELECT title, description
	FROM film
    WHERE description LIKE "% dog %" OR description LIKE "% cat %";
    
-- query final

SELECT title
	FROM film
    WHERE description LIKE "% dog %" OR description LIKE "% cat %";
    
/* 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor. */

SELECT actor.first_name, actor.last_name
	FROM actor
    LEFT JOIN film_actor
	ON actor.actor_id = film_actor.actor_id
    WHERE film_actor.film_id IS NULL;                     -- no hay ningun actor o actriz sin pelicula
    
/* 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010 */

SELECT title	
	FROM film                                          -- todas las peliculas son del 2006
    WHERE release_year BETWEEN 2005 AND 2010;
    
/* 17. Encuentra el título de todas las películas que son de la misma categoría que "Family". */

SELECT * 
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id;
        
-- query final

SELECT f.title
	FROM category AS c
    INNER JOIN film_category AS fc                   -- uno las tablas para conectar category con film
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
	WHERE c.name = "Family";                 -- condicion
    
/* 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas. */

SELECT CONCAT(a.first_name, " ", a.last_name) AS Actor, COUNT(f.film_id) AS FilmQuantity     -- cuento por el film_id
	FROM actor AS a
    INNER JOIN film_actor AS fa 
		ON a.actor_id = fa.actor_id                                       -- uno las tablas necesarias
	INNER JOIN film AS f
		ON fa.film_id = f.film_id
	GROUP BY a.first_name, a.last_name
    HAVING filmQuantity > 10
    ORDER BY filmQuantity ASC;                                    -- agrupo por nombre y apellido
    
-- query final

SELECT CONCAT(a.first_name, " ", a.last_name) AS Actor, COUNT(fa.film_id) AS FilmQuantity     -- cuento por el film_id
	FROM actor AS a
    INNER JOIN film_actor AS fa                                             -- uno las tablas necesarias
		ON a.actor_id = fa.actor_id                                     
	GROUP BY a.first_name, a.last_name                           -- agrupo 
    HAVING filmQuantity > 10
    ORDER BY filmQuantity ASC;   
    
/* 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
tabla film. */

SELECT title	
	FROM film
    WHERE rating = "R" AND length > 120;               -- AND porque se deben cumplir las dos condiciones
    
/* 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
muestra el nombre de la categoría junto con el promedio de duración. */

SELECT *	
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id;
        
-- query final
        
SELECT c.name AS Category, AVG(f.length) AS AverageLength                   -- promedio de duracion
	FROM category AS c
    INNER JOIN film_category AS fc
		ON c.category_id = fc.category_id
	INNER JOIN film AS f
		ON fc.film_id = f.film_id
	GROUP BY c.name                                  -- agrupo por categoria
    HAVING AverageLength > 120;
    
/* 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
con la cantidad de películas en las que han actuado. */

SELECT *	
	FROM actor
    INNER JOIN film_actor
		ON actor.actor_id = film_actor.actor_id;
        
-- query final

SELECT actor.first_name, actor.last_name, COUNT(film_actor.film_id) AS FilmQuantity
	FROM actor
    INNER JOIN film_actor
		ON actor.actor_id = film_actor.actor_id
	GROUP BY actor.first_name, actor.last_name
    HAVING FilmQuantity >= 5
    ORDER BY FilmQuantity DESC;
    
/* 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes. */

SELECT * 
	FROM rental   
    WHERE DATEDIFF (return_date, rental_date) > 5;              -- encuentra los alquileres con una diferencia entre ellos mayor a 5
    
SELECT *
	FROM film AS f
	INNER JOIN inventory AS i                                -- unir las tablas para conectar film con rental
		ON f.film_id = i.film_id;
	
-- query final 

SELECT DISTINCT f.title                    -- DISTINT para que no se repitan los nombres de las peliculas
	FROM film AS f
	INNER JOIN inventory AS i                                -- unir las tablas para conectar film con rental
		ON f.film_id = i.film_id
	WHERE i.inventory_id IN (                                 -- condicion de mas de 5 dias, con la subconsulta anterior
		SELECT inventory_id
			FROM rental
			WHERE DATEDIFF (return_date, rental_date) > 5
        );
        
/* 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
"Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
categoría "Horror" y luego exclúyelos de la lista de actores. */

-- esta seria las subconsulta donde buscamos los que si hayan actuado en peliculas de "Horror"
SELECT DISTINCT a.first_name, a.last_name
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id                              -- uno las tablas necesarias
	INNER JOIN film_category AS fc
		ON fa.film_id = fc.film_id
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
	WHERE c.name = "Horror";                          -- condicion
    
-- query final

SELECT first_name, last_name                    -- lo que quiero
	FROM actor
    WHERE actor_id NOT IN (                         -- que no esten en la consulta anterior
			SELECT a.actor_id
				FROM actor AS a
                INNER JOIN film_actor AS fa
					ON a.actor_id = fa.actor_id
				INNER JOIN film_category AS fc
					ON fa.film_id = fc.film_id
				INNER JOIN category AS c
					ON fc.category_id = c.category_id
				WHERE c.name = "Horror"
	);
    
/* 24. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
la tabla film. */ 

SELECT *                          -- peliculas con duracion mayor a 180
	FROM film
    WHERE length > 180;
    
-- query final

SELECT f.title 
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id
	INNER JOIN category AS c
		ON fc.category_id = c.category_id
    WHERE c.name = "Comedy" AND f.length > 180;