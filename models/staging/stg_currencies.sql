with source as (
    select * from {{ source('raw_gaming', 'raw_currencies') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['currency_id']) }} as currency_key,
        currency_id,
        currency_code,
        currency_name,
        symbol,
        is_real_money,
        cast(created_at as timestamp) as created_at
    from source
)
select * from renamed
