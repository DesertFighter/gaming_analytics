with source as (
    select * from {{ source('raw_gaming', 'raw_game_events') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['event_id']) }} as event_key,
        event_id,
        session_id,
        player_id,
        game_id,
        event_type,
        event_value,
        xp_delta,
        coordinates_x,
        coordinates_y,
        cast(occurred_at as timestamp) as occurred_at,
        cast(created_at as timestamp)  as created_at
    from source
)
select * from renamed
