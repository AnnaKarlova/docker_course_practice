{% set current_date = run_started_at | string | truncate(10, True, "")   %}
{% set current_year = run_started_at | string | truncate(4, True, "") | int  %}
{% set prev_year = current_year - 10 %}

SELECT 
    COUNT(*) as {{ adapter.quote('cnt') }}
FROM
    {{ ref('fct_flights') }}
WHERE 
    scheduled_departure BETWEEN '{{ current_date }}' AND '{{ current_date | replace(current_year, prev_year) }}'

{% set fct_fligths = api.Relation.create(
      database = 'dbt_course',
      schema = 'bookings_dbt',
      identifier = 'fct_fligths',
      type = 'table'
    ) 
%}

{% set stg_flights__facts__flights = api.Relation.create(
      database = 'dbt_course',
      schema = 'bookings_dbt',
      identifier = 'stg_flights__facts__flights',
      type = 'table'
    ) 
%}

{% do adapter.expand_target_column_types (stg_flights__facts__flights, fct_fligths) %}

{% for column in adapter.get_columns_in_relation(
    stg_flights__facts__flights) -%}
  {{ 'Column: ' ~ column }}
{% endfor %}

{% for column in adapter.get_columns_in_relation(
    fct_fligths) -%}
  {{ 'Column: ' ~ column }}
{% endfor %} 