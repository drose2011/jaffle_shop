WITH payments AS (
    SELECT * FROM {{ ref("stg_payments") }}
),

orders AS (
    SELECT * FROM {{ ref("stg_orders") }}
),

order_payments AS (
    SELECT 
        orders.order_id,
        orders.customer_id, 
        orders.order_date,
        payments.amount

    FROM orders
    LEFT JOIN payments USING (order_id)

),

customer_orders AS (

    SELECT
        customer_id,
        min(order_date) AS first_order_date,
        max(order_date) AS most_recent_order_date,
        count(order_id) AS number_of_orders,
        sum(amount) AS lifetime_value

    FROM order_payments 

    GROUP BY customer_id
)

SELECT * FROM customer_orders