with source as (
    select * from {{ source('raw_gaming', 'raw_seasons') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['season_id']) }} as season_key,
        season_id,
        season_name,
        season_number,
        cast(start_date as date)       as start_date,
        cast(end_date as date)         as end_date,
        battle_pass_price_usd,
        cast(created_at as timestamp)  as created_at
    from source
)
select * from renamed
