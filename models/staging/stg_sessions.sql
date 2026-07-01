with source as (
    select * from {{ source('raw_gaming', 'raw_sessions') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['session_id']) }} as session_key,
        session_id,
        player_id,
        game_id,
        platform_id,
        device_id,
        cast(session_start_at as timestamp) as session_start_at,
        cast(session_end_at as timestamp)   as session_end_at,
        duration_minutes,
        avg_fps,
        ping_ms,
        xp_earned,
        in_game_currency_earned,
        was_multiplayer,
        cast(created_at as timestamp)       as created_at
    from source
)
select * from renamed
