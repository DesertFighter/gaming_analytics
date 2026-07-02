select
    p.player_id,
    p.username,
    p.is_active
from {{ ref('int_players_enriched') }} p
left join {{ ref('int_sessions_enriched') }} s
    on p.player_id = s.player_id
where p.is_active = true
  and s.player_id is null