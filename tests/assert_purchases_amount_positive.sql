select
    purchase_id,
    player_id,
    amount
from {{ ref('int_purchases_enriched') }}
where amount <= 0