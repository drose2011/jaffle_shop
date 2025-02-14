WITH customers AS (
    SELECT * FROM {{ ref("stg_customers") }}
),

customer_orders AS (
    SELECT * FROM {{ ref("fct_orders") }}
),

final AS (

    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date, 
        customer_orders.lifetime_value,
        customer_orders.number_of_orders

    FROM customers

    LEFT JOIN customer_orders USING (customer_id)

)

SELECT * FROM final;