use sakila ; 
-- Challenge 1: 
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.
select min(length) as "max_duration"  , 
max(length) as "min_duration"
from film ; 

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals
SELECT 
concat( 
    FLOOR(AVG(length) / 60), "h" , 
    ROUND(AVG(length)) % 60, "min"
) as "average movie duration"
FROM film;

-- 2 You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.

SELECT DATEDIFF(
    (SELECT MAX(rental_date) FROM rental),
    (SELECT MIN(rental_date) FROM rental)
) AS difference_in_days;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. 
-- Return 20 rows of results.
SELECT * , 
    DATE_FORMAT(rental_date, '%M') AS rental_month,
    DATE_FORMAT(rental_date, '%W') AS rental_weekday
FROM 
    rental
LIMIT 20; 

/* 3 You need to ensure that customers can easily access information about the movie collection. 
To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, 
replace it with the string 'Not Available'. Sort the results of the film title in ascending order. */
SELECT title, rental_duration,
       IFNULL(rental_duration, 'Non Available') AS rental_duration_display
FROM film
ORDER BY title ASC ;

-- CHALLENGE 2: Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1 The total number of films that have been released.
SELECT COUNT(*) AS "TOTAL_FILM"
FROM film ; 

-- 1.2 The number of films for each rating.
SELECT rating, COUNT(title) AS number_of_films
FROM film
GROUP BY rating;

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different  
-- film ratings and adjust purchasing decisions accordingly.
SELECT rating, COUNT(title) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC ; 

-- 2 Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. 
-- Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.
SELECT rating, round(avg(length),2) AS number_of_films
FROM film
GROUP BY rating
ORDER BY number_of_films DESC ; 

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
SELECT rating, round(avg(length),2) AS number_of_films
FROM film
GROUP BY rating
HAVING AVG(length) > 120
ORDER BY number_of_films DESC ; 




