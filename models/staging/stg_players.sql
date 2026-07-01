with source as (
    select * from {{ source('raw_gaming', 'raw_players') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['player_id']) }} as player_key,
        player_id,
        region_id,
        username,
        email,
        account_tier,
        age_group,
        gender,
        total_playtime_hours,
        lifetime_spend_usd,
        is_active,
        cast(account_created_at as timestamp) as account_created_at,
        cast(last_login_at as timestamp)      as last_login_at
    from source
)
select * from renamed
