with games as (
    select * from {{ ref('stg_games') }}
),

publishers as (
    select
        publisher_id,
        publisher_name
    from {{ ref('stg_publishers') }}
),

genres as (
    select
        genre_id,
        genre_name
    from {{ ref('stg_genres') }}
),

final as (
    select
        -- game base fields
        games.*,

        -- publisher enrichment
        publishers.publisher_name,

        -- genre enrichment
        genres.genre_name

    from games
    left join publishers
        on games.publisher_id = publishers.publisher_id
    left join genres
        on games.genre_id = genres.genre_id
)

select * from final
