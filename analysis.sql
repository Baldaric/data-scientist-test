-- 1: RFM Calculation
WITH rfm AS (
	SELECT
		customer_id,
		DATE '2025-05-31' - MAX(order_date) AS recency,
		COUNT(*) AS frequency,
		SUM(payment_value) AS monetary
	FROM e_commerce_transactions
	GROUP BY customer_id
	)

-- 2: Segmentation
SELECT 
	*,
	CASE
		WHEN recency <= 30 AND frequency >= 5 AND monetary >= 500 THEN 'Noble'
		WHEN recency <= 60 AND frequency >= 3 THEN 'Loyalist'
		WHEN recency <= 30 AND frequency = 1 THEN 'NEW Customer'
		WHEN recency BETWEEN 60 AND 180 AND frequency >= 2 THEN 'At Risk'
		WHEN recency > 180 THEN 'Lost'
		ELSE 'Other'
	END AS segmentation
FROM rfm;