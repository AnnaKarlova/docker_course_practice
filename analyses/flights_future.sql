{% set current_date = run_started_at %}

select 
    {% for scheduled_departure in fct_flights %}
      sum(case when scheduled_departure >= '{{current_date}}' then 1 else 0) as flights_count
    {%- endfor %}
from
    {{ ref('fct_flights') }}