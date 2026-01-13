create database HOTEL_DB;

CREATE OR REPLACE FILE FORMAT FF_CSV
    TYPE = 'CSV'
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    SKIP_HEADER = 1
    NULL_IF = ('NULL', 'null', '')

CREATE OR REPLACE STAGE STG_HOTEL_BOOKINGS
    FILE_FORMAT = FF_CSV

CREATE TABLE BRONZE_HOTEL_BOOKING (
    booking_id STRING,
    hotel_id STRING,
    hotel_city STRING,
    customer_id STRING,
    customer_name STRING,
    customer_email STRING,
    check_in_date STRING,
    check_out_date STRING,
    room_type STRING,
    num_guests STRING,
    total_amount STRING,
    currency STRING,
    booking_status STRING
);


    COPY INTO BRONZE_HOTEL_BOOKING
    FROM @STG_HOTEL_BOOKINGS
    FILE_FORMAT = (FORMAT_NAME = FF_CSV)
    ON_ERROR = 'CONTINUE';

    SELECT * FROM BRONZE_HOTEL_BOOKING LIMIT 50;

CREATE TABLE SILVER_HOTEL_BOOKING (
    booking_id VARCHAR,
    hotel_id VARCHAR,
    hotel_city VARCHAR,
    customer_id VARCHAR,
    customer_name VARCHAR,
    customer_email VARCHAR,
    check_in_date DATE,
    check_out_date DATE,
    room_type VARCHAR,
    num_guests INTEGER,
    total_amount FLOAT,
    currency VARCHAR,
    booking_status VARCHAR
);
