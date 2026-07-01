with players as (
    select * from {{ ref('stg_players') }}
),

regions as (
    select
        region_id,
        region,
        country_name,
        country_code,
        timezone
    from {{ ref('stg_regions') }}
),

final as (
    select
        -- player identity
        players.player_key,
        players.player_id,
        players.username,
        players.email,
        players.account_tier,
        players.age_group,
        players.gender,
        players.is_active,

        -- player metrics
        players.total_playtime_hours,
        players.lifetime_spend_usd,

        -- region enrichment
        regions.region,
        regions.country_name,
        regions.country_code,
        regions.timezone,

        -- timestamps
        players.account_created_at,
        players.last_login_at

    from players
    left join regions
        on players.region_id = regions.region_id
)

select * from final
