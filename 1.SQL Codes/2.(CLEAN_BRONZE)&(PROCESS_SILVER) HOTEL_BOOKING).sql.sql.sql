USE DATABASE HOTEL_DB;

SELECT * FROM BRONZE_HOTEL_BOOKING LIMIT 50;


-- Checking The DATA that needs to be correct


SELECT customer_email
FROM BRONZE_HOTEL_BOOKING
WHERE NOT (customer_email LIKE '%@%.%')
    OR customer_email IS NULL



SELECT total_amount
FROM BRONZE_HOTEL_BOOKING
WHERE TRY_TO_NUMBER(total_amount) < 0;


SELECT check_in_date, check_out_date
FROM BRONZE_HOTEL_BOOKING
WHERE TRY_TO_DATE(check_out_date) <TRY_TO_DATE(check_in_date);

SELECT DISTINCT booking_status
FROM BRONZE_HOTEL_BOOKING;

-- Inserting cleaned data to silver layer

INSERT INTO SILVER_HOTEL_BOOKING
SELECT
    booking_id,
    hotel_id,
    INITCAP(TRIM(hotel_city)) AS hotel_city,
    customer_id,
    INITCAP(TRIM(customer_name)) AS customer_name,
    CASE 
        WHEN customer_email LIKE '%@%.%' THEN LOWER(TRIM(customer_email)) 
        ELSE NULL
        
    END AS customer_email,
    
    TRY_TO_DATE(NULLIF(check_in_date, '')) AS check_in_date,
    TRY_TO_DATE(NULLIF(check_out_date, '')) AS check_out_date,
    room_type,
    num_guests,
    ABS(TRY_TO_NUMBER(total_amount)) AS total_amount,
    currency,
    CASE 
        WHEN LOWER(booking_status) in ('confirmeeed', 'confirmd') THEN 'Confirmed'
        ELSE booking_status
    END AS booking_status
    FROM BRONZE_HOTEL_BOOKING
    WHERE 
        TRY_TO_DATE(check_in_date) IS NOT NULL
        AND TRY_TO_DATE(check_out_date) IS NOT NULL
        AND TRY_TO_DATE(check_out_date) >= TRY_TO_DATE(check_in_date);


SELECT * FROM SILVER_HOTEL_BOOKING LIMIT 30;
    
    
    
    