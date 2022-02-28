-- Manager's Details

select 
	staff.first_name,
    staff.last_name,
    store.store_id,    
    address.address,
    address.district,
    city.city,
    country.country

from store

Left join staff on store.manager_staff_id = staff.staff_id
left join address on store.address_id = address.address_id
left join city on address.city_id = city.city_id
left join country on city.country_id = country.country_id;



-- list of each inventory, store_id number, inventory id, name of the film, film rating , rental rate
-- and replacement cost 

select
	
    inventory.store_id,
    inventory.inventory_id,
    film.rating,
    film.title,
    film.rental_rate,
    film.replacement_cost
    
From film
	inner join inventory on film.film_id = inventory.film_id; 

-- Summary overview of the inventory
select
	inventory.store_id,
    count(film.rating) as inventory_items,
    film.rating
    
From film
	inner join inventory on film.film_id = inventory.film_id

group by film.rating,
		inventory.store_id;
        
	
 -- number of films, avg replacemnt cost, total replacement cost by store and film category


select
	inventory.store_id,
    category.name,
	count(film.film_id),
	avg(film.replacement_cost),
    sum(film.replacement_cost)
    
    
from film
inner join inventory on film.film_id = inventory.film_id
inner join film_category on film.film_id = film_category.film_id
inner join category on category.category_id = film_category.category_id

group by inventory.store_id, category.name;

-- All customer names, store they go to, wherther are active or not, address, street, city and country 

select
 
 customer.first_name,
 customer.last_name,
 customer.store_id,
 case when store_id = 1 and active = 1 then 'Store 1 active' 
	when store_id = 2 and active = 1 then 'Store 2 active' 
    when store_id = 1 and active = 0 then 'Store 1 inactive'  
    when store_id = 2 and active = 0 then 'Store 2 inactive'  
    end as 'Active',
    address.address,
    address.district,
    city.city,
    country.country

 
 from customer
	left join address on customer.address_id = address.address_id
    left join city on address.city_id = city.city_id
    left join country on country.country_id = city.country_id;

-- list of all customer names, their total lifetime rentals and sum of payments, order by highest payments 

select
	customer.first_name,
    customer.last_name,
    count(payment.rental_id) as 'Total Rentals',
    sum(payment.amount) as Total_Payment
    
From customer
	left join payment on customer.customer_id = payment.customer_id

group by customer.customer_id

order by Total_Payment desc;

-- List of all the advisors and investors
select 
    'Investor' as type,
    investor.first_name,
    investor.last_name,
    investor.company_name as company_name
from investor

union 

select 
'Advisor' as type,

advisor.first_name,
advisor.last_name,
null
from advisor;

-- Percentage of actors with each of the three awards
select 
case when actor_award.awards = 'Emmy, Oscar, Tony ' then '3 awards' 
	 when actor_award.awards = 'Emmy, Oscar' then '2 awards'
     when actor_award.awards = 'Emmy, Tony' then '2 awards'
     when actor_award.awards = 'Tony, Oscar' then '2 awards'
     else '1 award' end as Number_of_awards,
     avg(case when actor_award.actor_id is null then 0 else 1 end) as percentae_with_one_film 
from actor_award   

group by 
Number_of_awards