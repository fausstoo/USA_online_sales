use online_sales_usa;

SELECT * FROM sales;

-- Total sales by Year
SELECT year, round(sum(total),2) AS total
FROM sales
WHERE status = "complete"
GROUP BY year
ORDER BY total DESC;

-- Top categories by Sales
SELECT category, round(sum(total),2) AS total
FROM sales
WHERE status = "complete"
GROUP BY category
ORDER BY total DESC;

-- Top 10 Customers by sales
SELECT distinct(cust_id) AS customer, round(sum(total),2) AS total_expended
FROM sales
GROUP BY customer
ORDER BY total_expended DESC
LIMIT 10;

-- Top Sales by State-Gender
SELECT distinct(state) as state,
	   round(sum(CASE WHEN gender = 'm' THEN total else 0 END),2) male_sales,
	   round(sum(CASE WHEN gender = 'f' THEN total else 0 END),2) female_sales,
       round(sum(total),2) AS total_sales
FROM sales
GROUP BY state
ORDER BY total_sales DESC;

-- Top 25 SKU by Sale
SELECT distinct(sku) as sku, round(sum(total),2) total_sales
FROM sales
WHERE status = 'complete'
GROUP BY sku
ORDER BY total_sales DESC
LIMIT 25;

-- Top 25 SKU by qty sold
SELECT distinct(sku) AS sku, sum(qty_ordered) qty_ordered
FROM sales
WHERE status = "complete"
GROUP BY sku
ORDER BY qty_ordered desc
LIMIT 25;

-- Gender percentage
SELECT Gender, round(count(*) * 100.0 / (SELECT count(*) FROM sales),2) AS percentage
FROM sales
GROUP BY Gender
ORDER BY percentage DESC;

-- Status percentage
SELECT status, round(count(*) * 100.0 / (SELECT count(*) FROM sales),2) AS 'percentage'
FROM sales
GROUP BY status
ORDER BY percentage DESC;

-- Top 10 SKU Sales by State
SELECT state, sku, round(sum(total),2) total_sales
FROM sales
WHERE status = 'complete'
GROUP BY sku, state
ORDER BY total_sales DESC
LIMIT 10;

-- Worst 50 SKU Sales by States
SELECT state, sku, round(sum(total),2) total_sales
FROM sales
WHERE status = 'complete'
AND total > 0
GROUP BY sku, state
ORDER BY total_sales ASC
LIMIT 50;