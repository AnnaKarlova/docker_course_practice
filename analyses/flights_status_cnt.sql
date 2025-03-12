{% set status_query %}
select distinct
    status
from
    {{ ref('stg_flights__facts__flights') }}
{% endset %}

{% set status_query_result = run_query(status_query) %}
{% if execute %}
    {% set important_status = status_query_result.columns[0].values() %}
{% else %}
    {% set important_status = [] %}
{% endif %}
select
    {% for status in important_status %}
    sum(case when status = '{{ status }}' then 1 else 0 end) as "status_{{ status }}"
        {%- if not loop.last %},{% endif %}
    {%- endfor %}
from
    {{ ref('stg_flights__facts__flights') }}