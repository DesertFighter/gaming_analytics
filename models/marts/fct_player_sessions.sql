{{
    config(
        materialized='incremental',
        incremental_strategy='merge',
        unique_key='session_id',
        on_schema_change='append_new_columns',
    )
}}

select
    session_id,
    player_id,
    game_id,
    platform_id,
    device_id,
    session_start_at,
    session_end_at,
    duration_minutes,
    avg_fps,
    ping_ms,
    xp_earned,
    in_game_currency_earned,
    was_multiplayer,
    created_at,
    updated_at
from {{ source('raw_gaming', 'raw_sessions') }}

{% if is_incremental() %}
    where updated_at > (select max(updated_at) from {{ this }})
{% endif %}