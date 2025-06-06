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

-- 3.1: Anomaly detection negative decoy_noise
SELECT *
FROM e_commerce_transactions
WHERE decoy_noise < 0;

-- 3.2: Anomaly detection based on decoy_noise
SELECT *
FROM e_commerce_transactions
WHERE ABS(payment_value - decoy_noise) > 100;

-- 3.3: Frequency of decoy_flag based on decoy_noise
SELECT
	decoy_flag,
	COUNT(*) AS anomaly_count
FROM e_commerce_transactions
WHERE ABS (payment_value - decoy_noise) > 100
GROUP BY decoy_flag
ORDER BY anomaly_count DESC;