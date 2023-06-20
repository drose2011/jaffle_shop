WITH customers AS (
    SELECT * FROM {{ ref("stg_customers") }}
),

orders AS (
    SELECT * FROM {{ ref("stg_orders") }}
),

order_payments AS (
    SELECT * FROM {{ ref("fct_orders") }}
),

customer_orders AS (

    SELECT
        orders.customer_id,

        min(orders.order_date) AS first_order_date,
        max(orders.order_date) AS most_recent_order_date,
        count(orders.order_id) AS number_of_orders,
        sum(order_payments.amount) AS lifetime_value

    FROM orders 
    
    LEFT JOIN order_payments USING (order_id)

    GROUP BY orders.customer_id

),

final AS (

    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date, 
        customer_orders.lifetime_value,
        coalesce(customer_orders.number_of_orders, 0) AS number_of_orders

    FROM customers

    LEFT JOIN customer_orders USING (customer_id)

)

SELECT * FROM final;