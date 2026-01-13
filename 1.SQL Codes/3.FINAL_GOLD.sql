HOTEL_DB.PUBLIC.SILVER_HOTEL_BOOKING

-- Gold Layer Transformation


USE DATABASE HOTEL_DB;

SELECT * FROM SILVER_HOTEL_BOOKING LIMIT 30;

-- Monthly Revenue and Monthly Bookings

CREATE TABLE GOLD_AGG_DAILY_BOOKING AS 
SELECT 
check_in_date AS date,
COUNT (*) AS total_booking,
SUM (total_amount) AS total_revenue,
FROM SILVER_HOTEL_BOOKING
GROUP BY check_in_date
ORDER BY date;

SELECT * FROM GOLD_AGG_DAILY_BOOKING LIMIT 30;


-- Top Revenue Generating Cities

CREATE TABLE GOLD_AGG_HOTEL_CITY_SALES AS 
SELECT 
hotel_city,
SUM(total_amount) AS total_revenue
FROM SILVER_HOTEL_BOOKING
GROUP BY hotel_city
ORDER BY total_revenue DESC;

SELECT * FROM GOLD_AGG_HOTEL_CITY_SALES LIMIT 30;


CREATE TABLE GOLD_BOOKING_CLEAN AS
SELECT
    booking_id,
    hotel_id,
    hotel_city,
    customer_id,
    customer_name,
    customer_email,
    check_in_date,
    check_out_date,
    room_type,
    num_guests,
    total_amount,
    currency,
    booking_status
FROM SILVER_HOTEL_BOOKING;