-- NOTE: stg_matches has no season_id column in the raw data.
-- Seasons join removed. Only game enrichment applied.

with matches as (
    select * from {{ ref('stg_matches') }}
),

games as (
    select
        game_id,
        publisher_name,
        genre_name
    from {{ ref('int_games_enriched') }}
),

final as (
    select
        -- match base fields
        matches.*,

        -- game enrichment
        games.publisher_name,
        games.genre_name

    from matches
    left join games
        on matches.game_id = games.game_id
)

select * from final
