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

    