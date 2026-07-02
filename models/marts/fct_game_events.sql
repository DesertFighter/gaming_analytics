{{
    config(
        materialized='incremental',
        incremental_strategy='insert_overwrite',
        partition_by={
            "field": "occurred_at",
            "data_type": "timestamp",
            "granularity": "day"
        },
    )
}}

select
    event_id,
    session_id,
    player_id,
    game_id,
    event_type,
    event_value,
    xp_delta,
    coordinates_x,
    coordinates_y,
    occurred_at,
    created_at
from {{ source('raw_gaming', 'raw_game_events') }}

{% if is_incremental() %}
    where occurred_at > (select max(occurred_at) from {{ this }})
{% endif %}