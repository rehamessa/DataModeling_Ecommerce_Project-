-- 1.When is the peak season of our e-commerce?
SELECT Month(order_date) AS season, COUNT(order_id) AS order_count
FROM Fact_Order
GROUP BY season
ORDER BY order_count DESC
Limit 3;

-- 2.What time users are most likely make an order or using the ecommerce app
select Hour(order_date) As Time,
		Count(order_id) as Order_Count
From fact_order
Group by Time
order by Order_Count desc;

-- 3.What is the preferred way to pay in the e-commerce?

SELECT 
    payment_type, 
    COUNT(fact_order.order_id) as order_count 
FROM 
    fact_order join fact_payment using(order_id)
GROUP BY 
    payment_type 
ORDER BY 
    order_count DESC
    limit 1;
    
-- 4-How many installments are usually done when paying in the e-commerce?

SELECT 
    payment_installments, 
    COUNT(payment_sequential) AS frequency 
FROM 
     fact_payment 
GROUP BY 
   payment_installments
ORDER BY 
    frequency DESC;

-- 5-What is the average spending time for users on our e-commerce?

-- difference between order_date and order_approved_date
select * from fact_order

SELECT AVG(TIMESTAMPDIFF(SECOND, order_date, order_approved_date) / 60*60) AS avg_hours
FROM Fact_Order;

-- 6-What is the frequency of purchase in each state?
select * from dim_customer
select customer_state, 
      count(order_id) as order_count
from dim_customer join Fact_order using(user_name)
group by customer_state
order by order_count desc;

-- 7.Which logistic routes have heavy traffic?
-- routes with a high number of deliveries.
select * from fact_orderitem

select customer_state,
	seller_state,
    count(Fact_order.order_id) as count_route
from fact_orderitem
join fact_order using(order_id)
join dim_customer using (user_name)
join dim_seller using(seller_id)
group by customer_state,seller_state
order by count_route desc

-- 8-How many late deliveries occur? Are they affecting customer satisfaction?
select * from fact_order
select count(*) as latness,
	avg(Feedback_score) as avg_feedback
from Dim_feedback join fact_order using(order_id)
where delivered_date >estimated_time_delivery;

-- 9-How long the delay for delivery/shipping in each state?
select customer_state,
	avg(timestampdiff(second,pickup_date,delivered_date)/3600) as delays_hours
    from fact_order join dim_customer using(user_name)
    group by customer_state;
    
-- 10-How long is the difference between estimated and actual delivery in each state?
select customer_state,
	avg(timestampdiff(second,delivered_date,estimated_time_delivery)/3600) as diff_hours
    from fact_order join dim_customer using(user_name)
    group by customer_state;


    