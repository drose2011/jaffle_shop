WITH payments AS (
    SELECT * FROM {{ ref("stg_payments") }}
)
SELECT 
    order_id,
    sum(amount) AS total_amount
FROM payments
GROUP BY order_id
HAVING total_amount < 0