-- Assignment Questions
use mavenmovies;

-- Question 1:
-- Retrieve the total number of rentals made in the Sakila database.
-- Hint: Use the COUNT() function.
-- Answer:
select count(*) from rental;

-- Question 2:
-- Find the average rental duration (in days) of movies rented from the Sakila database.
-- Hint: Utilize the AVG() function.
-- Answer:
select avg(rental_duration) from film;

-- Question 3:
-- Display the first name and last name of customers in uppercase.
-- Hint: Use the UPPER () function.
-- Answer:
select upper(first_name), upper(last_name) from customer;

-- Question 4:
-- Extract the month from the rental date and display it alongside the rental ID.
-- Hint: Employ the MONTH() function.
-- Answer:
select rental_id, month(rental_date) as rental_month from rental;

-- Question 5:
-- Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
-- Hint: Use COUNT () in conjunction with GROUP BY.
-- Answer:
select customer_id, count(rental_id) from rental group by customer_id;

-- Question 6:
-- Find the total revenue generated by each store.
-- Hint: Combine SUM() and GROUP BY.
-- Answer:
-- select * from store; select * from payment;
select s.store_id, p.staff_id, sum(amount) from payment p inner join store s on p.staff_id = s.manager_staff_id group by p.staff_id;

-- Question 7:
-- Display the title of the movie, customers first name, and last name who rented it.
-- Hint: Use JOIN between the film, inventory, rental, and customer tables.
-- Answer:
-- select * from film; select * from customer; select * from inventory; select * from rental;
select f.title, c.first_name, c.last_name from film f inner join inventory i on f.film_id= i.film_id inner join rental r on r.inventory_id = i.inventory_id inner join customer c on r.customer_id = c.customer_id;

-- Question 8:
-- Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
-- Hint: Use JOIN between the film actor, film, and actor tables.
-- Answer:
-- select * from film; select * from film_actor; select * from actor;
select a.first_name, a.last_name, f.title from actor a inner join film_actor fa on a.actor_id = fa.actor_id inner join film f on f.film_id = fa.film_id where f.title = 'Gone with the Wind';

-- Question 1:
-- Determine the total number of rentals for each category of movies.
-- Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
-- Answer: 
-- select * from rental; select * from inventory; select * from film; select * from film_category;
select fc.category_id, count(r.rental_id) as total_rentals from rental r inner join inventory i on r.inventory_id = i.inventory_id inner join film_category fc on i.film_id = fc.film_id group by fc.category_id; 

-- Question 2:
-- Find the average rental rate of movies in each language.
-- Hint: JOIN film and language tables, then use AVG () and GROUP BY.
-- Answer:
select name, l.language_id, avg(f.rental_rate) from film f inner join language l on f.language_id = l.language_id group by f.language_id;

-- Question 3:
-- Retrieve the customer names along with the total amount they've spent on rentals.
-- Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
-- Answer:
-- select * from customer; select * from payment;
select first_name, last_name, sum(p.amount) as total_amt from customer c inner join payment p on c.customer_id = p.customer_id group by c.customer_id; 


-- Question 4:
-- List the titles of movies rented by each customer in a particular city (e.g., 'London').
-- Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
-- Answer: Inner join in order: city-address-customer-rental-inventory-film
-- select * from film; select * from customer; select * from address where city_id = 312 or city_id = 313; select * from city;
select title, first_name, last_name, ci.city, c.address_id from city ci inner join address a on ci.city_id=a.city_id inner join customer c on a.address_id=c.address_id inner join rental r on c.customer_id=r.customer_id inner join inventory i on r.inventory_id=i.inventory_id inner join film f on i.film_id=f.film_id where ci.city = 'London';


-- Question 5:
-- Display the top 5 rented movies along with the number of times they've been rented.
-- Hint: JOIN film, inventory, and rental tables, then use cOUNT() and GROUP BY, and limit the results.
-- Answer:
-- select * from rental; select * from inventory; select * from film;
select title, count(r.customer_id) as no_of_times_rented from film f inner join inventory i on f.film_id=i.film_id inner join rental r on i.inventory_id=r.inventory_id group by title order by no_of_times_rented desc limit 5;

-- Question 6:
-- Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
-- Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
-- Answer:
select c.customer_id, first_name, last_name from rental r inner join inventory i on r.inventory_id=i.inventory_id inner join customer c on i.store_id=c.store_id where i.store_id= 1 and i.store_id= 2 group by r.customer_id;