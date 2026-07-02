{% macro classify_spend(column_name) %}
    case
        when {{ column_name }} < 10   then 'Low'
        when {{ column_name }} < 50   then 'Medium'
        when {{ column_name }} < 200  then 'High'
        else 'Whale'
    end
{% endmacro %}