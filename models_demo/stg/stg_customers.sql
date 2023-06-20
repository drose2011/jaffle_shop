WITH renamed AS (
    SELECT 
        id as customer_id,
        first_name,
        last_name
    FROM {{ source("jaffle_shop", "raw_customers") }}

)
SELECT * FROM renamed;