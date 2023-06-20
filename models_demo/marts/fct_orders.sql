WITH payments AS (
    SELECT * FROM {{ ref("stg_payments") }}
),

orders AS (
    SELECT * FROM {{ ref("stg_orders") }}
),

final AS (
    SELECT
        orders.order_id AS order_id,
        orders.customer_id AS customer_id,
        payments.amount AS amount
    FROM orders LEFT JOIN payments USING (order_id)
)
SELECT * FROM final;