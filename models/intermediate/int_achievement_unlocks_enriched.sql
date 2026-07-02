
with unlocks as (
    select * from {{ ref('stg_achievement_unlocks') }}
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

achievements as (
    select * from {{ ref('stg_achievements') }}
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
        -- unlock base fields
        unlocks.*,

        -- player enrichment
        players.username,
        players.account_tier,
        players.region,
        players.country_name,

        -- achievement enrichment (achievement_id already in unlocks.* — do not repeat)
        achievements.game_id,

        -- game enrichment
        games.publisher_name,
        games.genre_name

    from unlocks
    left join players
        on unlocks.player_id = players.player_id
    left join achievements
        on unlocks.achievement_id = achievements.achievement_id
    left join games
        on achievements.game_id = games.game_id
)

select * from final
