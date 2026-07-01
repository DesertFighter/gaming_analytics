with purchases as (
    select * from {{ ref('stg_purchases') }}
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
        -- purchase base fields
        purchases.*,

        -- player enrichment
        players.username,
        players.account_tier,
        players.region,
        players.country_name,

        -- game enrichment
        games.publisher_name,
        games.genre_name

    from purchases
    left join players
        on purchases.player_id = players.player_id
    left join games
        on purchases.game_id = games.game_id
)

select * from final
