SET search_path TO public;


-- total revenue is $2,261,255.41
-- unique customers is 793
-- total orders is 4922
-- total line items is 9799
-- avg line item sales is $230.72
SELECT 
    ROUND(SUM(sales), 2) 		AS total_revenue,
    COUNT(DISTINCT customer_id) AS unique_customers,
    COUNT(DISTINCT order_id) 	AS total_orders,
    COUNT(*) 					AS total_line_items,
    ROUND(AVG(sales), 2) 		AS avg_line_item_sales
FROM supermarket;


-- sales and total orders started getting higher as time goes on
-- every after new years the total order drops drastically
-- this likely suggests that customers buys less during january and february
SELECT
	TO_CHAR(order_date, 'YYYY-MM') AS month,
	ROUND(SUM(sales),2) AS monthly_revenue,
	COUNT(DISTINCT order_id) AS total_orders
FROM supermarket
GROUP BY 1
ORDER BY 1;


-- phones has the highest total revenue in sub categories ($327,782)
-- second is chairs ($322,541)
SELECT
	category,
	sub_category,
	ROUND(SUM(sales), 2) AS total_revenue,
	ROUND(100.0 * SUM(sales) / SUM(SUM(sales)) OVER(PARTITION BY category), 2) AS pct_of_category
FROM supermarket
GROUP BY 1, 2
ORDER BY 1, 3 DESC;



-- in all regions, consumer is the most customers
-- this suggest that the products are more driven on the consumer side compared to other segments
SELECT
	region,
	segment,
	ROUND(SUM(sales), 2) AS total_revenue,
	COUNT(DISTINCT customer_id) AS unique_customers
FROM supermarket
GROUP BY 1, 2
ORDER BY 1, 3 DESC;




WITH cte AS (
SELECT
	DATE_TRUNC('Month', order_date) AS months,
	SUM(sales) AS curr_revenue
FROM supermarket
GROUP BY 1
),

cte2 AS (
SELECT
	TO_CHAR(months, 'YYYY-MM') AS months,
	curr_revenue,
	LAG(curr_revenue) OVER(ORDER BY months) AS prev_revenue
FROM cte
)

SELECT
	months,
	curr_revenue,
	ROUND(100.0 * (curr_revenue - prev_revenue) / NULLIF(prev_revenue, 0), 2) AS mom_growth
FROM cte2;



-- canon imageclass has the highest total revenue at $61,600 despite only 5 transactions
	-- this means canon is a high class-product
	
-- GBC DocuBlind has 11 transactions but lower revenue than canon imageclass, showing that
	-- frequency does not always mean higher value
	
-- cisco telepresence has a higher total revenue compared to others who has many transactions
	-- this suggests that its a very high value, low volume product
	
-- most top categories came from technology category, showing it drives higher sales
	-- compared to other categories
SELECT 
	product_name,
	category,
	sub_category,
	ROUND(SUM(sales), 2) AS total_revenue,
	COUNT(*) AS line_items
FROM supermarket
GROUP BY 1, 2, 3
ORDER BY 4 DESC
LIMIT 10;


-- standard class has the highest total revenue and highest number of orders,
	-- making it the most commonly used shipment mode
-- second class and first class generates lower revenue, but has faster delivery times
-- same day shipping has the lowest number of orders and revenue, suggesting it is used much less
SELECT 
	ship_mode,
	COUNT(DISTINCT order_id) AS orders,
	ROUND(SUM(sales), 2) AS total_revenue,
	ROUND(AVG(ship_date - order_date), 1) AS avg_ship_days
FROM supermarket
GROUP BY 1
ORDER BY 3 DESC;


WITH rfm AS (
SELECT
	customer_name,
	customer_id,
	MAX(order_date) AS last_purchase,
	COUNT(DISTINCT order_id) AS frequency,
	ROUND(SUM(sales), 2) AS monetary
FROM supermarket
GROUP BY 1, 2
),
rfm_calc AS (
SELECT
	customer_name,
	customer_id,
	DATE '2019-01-01' - last_purchase AS recency,
	frequency,
	monetary
FROM rfm
),
rfm_scored AS (
SELECT *,
	NTILE(5) OVER(ORDER BY recency DESC) AS r_score,
	NTILE(5) OVER(ORDER BY frequency) AS f_score,
	NTILE(5) OVER(ORDER BY monetary) AS m_score
FROM rfm_calc
),
rfm_segmented AS (
SELECT *,
	CASE 
		WHEN r_score >= 4 AND f_score >= 4 THEN 'Champion'
		WHEN r_score <= 2 AND f_score >= 3 THEN 'At-risk'
		WHEN r_score <= 2 AND f_score <= 2 THEN 'Lost'
		ELSE 'Others'
	END AS segment
FROM rfm_scored
)

SELECT 
	segment,
	COUNT(*) AS customers,
	SUM(monetary) AS total_revenue,
	ROUND(AVG(monetary), 2) AS avg_revenue
FROM rfm_segmented
GROUP BY 1
ORDER BY 3 DESC;









