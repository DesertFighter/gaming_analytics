with source as (
    select * from {{ source('raw_gaming', 'raw_matches') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['match_id']) }} as match_key,
        match_id,
        player_id,
        game_id,
        platform_id,
        match_mode,
        result,
        kills,
        deaths,
        assists,
        score,
        duration_minutes,
        xp_earned,
        cast(match_start_at as timestamp) as match_start_at,
        cast(match_end_at as timestamp)   as match_end_at,
        cast(created_at as timestamp)     as created_at
    from source
)
select * from renamed
