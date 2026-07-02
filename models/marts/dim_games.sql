{{
    config(materialized='table')
}}

select
    game_id,
    game_name,
    publisher_id,
    genre_id,
    release_date,
    base_price_usd,
    is_free_to_play,
    rating_esrb,
    avg_review_score,
    total_reviews,
    created_at,
    updated_at
from {{ source('raw_gaming', 'raw_games') }}