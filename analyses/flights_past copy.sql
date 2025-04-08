{% set current_date = run_started_at | string | truncate(10, True, "")   %}
{% set current_year = run_started_at | string | truncate(4, True, "") | int  %}
{% set prev_year = current_year - 10 %}

SELECT 
    COUNT(*) as {{ adapter.quote('cnt') }}
FROM
    {{ ref('fct_flights') }}
WHERE 
    scheduled_departure BETWEEN '{{ current_date }}' AND '{{ current_date | replace(current_year, prev_year) }}'

{% set fligths_relation = load_relation(ref('stg_flights__facts__flights')) %}
{%- set columns = adapter.get_columns_in_relation(fligths_relation) -%}

{% for column in columns -%}
  {{ "Column: " ~ column }}
{% endfor %} 