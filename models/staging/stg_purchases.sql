-- CI test 2: proving state:modified+ selection while PR is still open
with source as (
    select * from {{ source('raw_gaming', 'raw_purchases') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['purchase_id']) }} as purchase_key,
        purchase_id,
        player_id,
        game_id,
        currency_id,
        purchase_type,
        amount,
        is_real_money,
        is_refunded,
        platform_fee_pct,
        cast(purchased_at as timestamp) as purchased_at,
        cast(created_at as timestamp)   as created_at
    from source
)
select * from renamed
