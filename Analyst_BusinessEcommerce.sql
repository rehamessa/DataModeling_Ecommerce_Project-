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
    