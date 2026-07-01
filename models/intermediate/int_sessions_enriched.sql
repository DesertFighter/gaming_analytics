with sessions as (
    select * from {{ ref('stg_sessions') }}
),

players as (
    select
        player_id,
        username,
        account_tier,
        region,
        country_name
    from {{ ref('int_players_enriched') }}
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
        -- session base fields
        sessions.*,

        -- player enrichment
        players.username,
        players.account_tier,
        players.region,
        players.country_name,

        -- game enrichment
        games.publisher_name,
        games.genre_name

    from sessions
    left join players
        on sessions.player_id = players.player_id
    left join games
        on sessions.game_id = games.game_id
)

select * from final
