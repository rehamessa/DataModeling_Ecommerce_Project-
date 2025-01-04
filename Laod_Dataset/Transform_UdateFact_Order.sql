DESCRIBE fact_order;
SHOW CREATE TABLE fact_order;
Select * from Fact_order
SET SQL_SAFE_UPDATES = 0;



UPDATE fact_order
SET 
    order_date = CASE
        WHEN order_date LIKE '%/%/%/% %:%' THEN STR_TO_DATE(order_date, '%m/%d/%Y %H:%i')
        ELSE order_date
    END,
    order_approved_date = CASE
        WHEN order_approved_date LIKE '%/%/%/% %:%' THEN STR_TO_DATE(order_approved_date, '%m/%d/%Y %H:%i')
        ELSE order_approved_date
    END,
    pickup_date = CASE
        WHEN pickup_date LIKE '%/%/%/% %:%' THEN STR_TO_DATE(pickup_date, '%m/%d/%Y %H:%i')
        ELSE pickup_date
    END,
    delivered_date = CASE
        WHEN delivered_date LIKE '%/%/%/% %:%' THEN STR_TO_DATE(delivered_date, '%m/%d/%Y %H:%i')
        ELSE delivered_date
    END,
    estimated_time_delivery = CASE
        WHEN estimated_time_delivery LIKE '%/%/%/% %:%' THEN STR_TO_DATE(estimated_time_delivery, '%m/%d/%Y %H:%i')
        ELSE estimated_time_delivery
    END;

UPDATE fact_order
SET 
    order_date = NULL
WHERE order_date = '';

UPDATE fact_order
SET 
    order_approved_date = NULL
WHERE order_approved_date = '';

UPDATE fact_order
SET 
    pickup_date = NULL
WHERE pickup_date = '';

UPDATE fact_order
SET 
    delivered_date = NULL
WHERE delivered_date = '';

UPDATE fact_order
SET 
    estimated_time_delivery = NULL
WHERE estimated_time_delivery = '';

    

ALTER TABLE fact_order
MODIFY COLUMN order_date DATETIME,
MODIFY COLUMN order_approved_date DATETIME,
MODIFY COLUMN pickup_date DATETIME,
MODIFY COLUMN delivered_date DATETIME,
MODIFY COLUMN estimated_time_delivery DATETIME;




-- Set missing user_name values to NULL:

UPDATE fact_order
SET user_name = NULL
WHERE user_name NOT IN (SELECT user_name FROM dim_customer);

-- Add foreign key constrain

ALTER TABLE fact_order
ADD CONSTRAINT fk_user_name FOREIGN KEY (user_name) REFERENCES dim_customer(user_name);
