with source as (
    select * from {{ source('raw_gaming', 'raw_games') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['game_id']) }} as game_key,
        game_id,
        publisher_id,
        genre_id,
        game_name,
        cast(release_date as date)     as release_date,
        base_price_usd,
        is_free_to_play,
        rating_esrb,
        avg_review_score,
        total_reviews,
        cast(created_at as timestamp)  as created_at
    from source
)
select * from renamed
