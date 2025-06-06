-- 1: RFM Calculation
SELECT
	customer_id,
	DATE '2025-05-31' - MAX(order_date) AS recency,
	COUNT(*) AS frequency,
	SUM(payment_value) AS monetary
FROM e_commerce_transactions
GROUP BY customer_id;