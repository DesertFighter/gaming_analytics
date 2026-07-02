{% test is_positive(model, column_name) %}

    -- Custom generic test: fails if any value in column_name is <= 0
    select *
    from {{ model }}
    where {{ column_name }} <= 0

{% endtest %}