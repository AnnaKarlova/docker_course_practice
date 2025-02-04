{{
    config(
        materialized = 'table',
    )
}}
select
    passenger_id
from
    {{ ref('passenger_id') }}