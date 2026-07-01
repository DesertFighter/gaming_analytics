with source as (
    select * from {{ source('raw_gaming', 'raw_achievements') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['achievement_id']) }} as achievement_key,
        achievement_id,
        game_id,
        achievement_name,
        achievement_type,
        xp_reward,
        rarity,
        unlock_rate_pct,
        cast(created_at as timestamp) as created_at
    from source
)
select * from renamed
