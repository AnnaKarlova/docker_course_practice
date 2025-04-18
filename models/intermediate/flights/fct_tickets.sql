{{
    config(
        materialized = 'table'
    )
}}
select
    ticket_no, 
    book_ref, 
    passenger_id, 
    passenger_name, 
    contact_data
from
    {{ ref('stg_flights__facts__tickets') }}
    WHERE
        passenger_id not in
        (
            select passenger_id
            from {{ ref('passenger_id') }}
        )