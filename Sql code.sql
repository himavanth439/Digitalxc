-- Database: project

-- DROP DATABASE IF EXISTS project;

CREATE DATABASE project
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;


CREATE TABLE sample (
    ticket_id VARCHAR(30) PRIMARY KEY,
    category VARCHAR(30),
    sub_category VARCHAR(40),
    priority VARCHAR(20),
    created_date TIMESTAMP,
    resolved_date TIMESTAMP,
    status VARCHAR(20),
    assigned_group VARCHAR(40),
    technician VARCHAR(30),
    resolution_time_hrs INTERVAL,
    customer_impact VARCHAR(255)
);

CREATE TABLE sample_clean (
    ticket_id VARCHAR(30),
    category VARCHAR(30),
    sub_category VARCHAR(100),
    priority VARCHAR(20),
    created_date TIMESTAMP,
    resolved_date TIMESTAMP,
    status VARCHAR(20),
    assigned_group VARCHAR(100),
    technician VARCHAR(30),
    resolution_time_hrs double precision,
    customer_impact VARCHAR(255)
);

select * from sample;
select * from sample_clean;

insert into sample_clean
SELECT DISTINCT *
FROM public.sample
WHERE "created date" IS NOT NULL;

SELECT Category, priority, AVG(resolution_time_hrs) AS avg_resolution_time
FROM sample_clean
GROUP BY Category, priority;

SELECT *,
       EXTRACT(YEAR FROM created_date) AS year,
       EXTRACT(MONTH FROM created_date) AS month,
       EXTRACT(DAY FROM created_date) AS day
FROM sample_clean;

SELECT 
    EXTRACT(YEAR FROM created_date) AS year,
    EXTRACT(MONTH FROM created_date) AS month,
    COUNT(*) AS ticket_count,
    AVG(resolution_time_hrs) AS avg_resolution_time,
    COUNT(*) FILTER (WHERE status = 'Closed')::FLOAT / COUNT(*) AS closure_rate
FROM sample_clean
GROUP BY year, month;











	