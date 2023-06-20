WITH renamed AS (
    SELECT 
        id as customer_id,
        first_name,
        last_name
    FROM {{ ref("raw_customers") }}

)
SELECT * FROM renamed;