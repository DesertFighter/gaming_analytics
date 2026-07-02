{% macro round_usd(column_name, decimals=2) %}
    round(cast({{ column_name }} as numeric), {{ decimals }})
{% endmacro %}