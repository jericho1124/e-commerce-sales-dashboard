SET search_path TO public;

SELECT *
FROM supermarket;

SELECT *,
	SPLIT_PART(product_name, ',', 1)
FROM supermarket;

UPDATE supermarket
SET product_name = TRIM(SPLIT_PART(product_name, ',', 1));


-- dimension: date
CREATE TABLE dim_date AS
SELECT DISTINCT
    order_date                                         AS date_key,
    EXTRACT(YEAR  FROM order_date)::INT                AS year,
    EXTRACT(QUARTER FROM order_date)::INT              AS quarter,
    EXTRACT(MONTH FROM order_date)::INT                AS month,
    TO_CHAR(order_date, 'Month')                       AS month_name,
    EXTRACT(WEEK FROM order_date)::INT                 AS week_of_year,
    TO_CHAR(order_date, 'Day')                         AS day_name,
    CASE WHEN EXTRACT(DOW FROM order_date) IN (0,6)
         THEN TRUE ELSE FALSE END                      AS is_weekend
FROM supermarket
ORDER BY date_key;

ALTER TABLE dim_date ADD PRIMARY KEY (date_key);

-- dimension: customer
CREATE TABLE dim_customer AS
SELECT DISTINCT
	customer_id,
	customer_name,
	segment
FROM supermarket;

ALTER TABLE dim_customer ADD PRIMARY KEY(customer_id);

-- dimension: product
CREATE TABLE dim_product AS
SELECT
    product_id,
    MAX(product_name) AS product_name,
    MAX(category) AS category,
    MAX(sub_category) AS sub_category
FROM supermarket
GROUP BY product_id;

ALTER TABLE dim_product ADD PRIMARY KEY(product_id);


-- Dimension: Geography
CREATE TABLE dim_geography AS
SELECT DISTINCT
    ROW_NUMBER() OVER (ORDER BY city, state) AS geo_id,
    city,
    state,
    postal_code,
    region,
    country
FROM supermarket;
ALTER TABLE dim_geography ADD PRIMARY KEY (geo_id);



-- Fact Table
CREATE TABLE fact_sales AS
SELECT
    ROW_NUMBER() OVER () AS fact_id,
    s.order_id,
    s.order_date AS date_key,
    s.ship_date,
    s.ship_mode,
    s.customer_id,
    s.product_id,
    g.geo_id,
    s.sales,
    (s.ship_date - s.order_date) AS shipping_days
FROM supermarket s
JOIN dim_geography g
  ON s.city = g.city
 AND COALESCE(s.postal_code,'') = COALESCE(g.postal_code,'');
ALTER TABLE fact_sales ADD PRIMARY KEY (fact_id);
CREATE INDEX idx_fact_date_key     ON fact_sales (date_key);
CREATE INDEX idx_fact_customer_id  ON fact_sales (customer_id);
CREATE INDEX idx_fact_product_id   ON fact_sales (product_id);
CREATE INDEX idx_fact_geo_id       ON fact_sales (geo_id);




	
