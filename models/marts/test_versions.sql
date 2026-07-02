{{
    config(materialized='table')
}}

{% set _ = ref('dim_players') %}

select
    pu.purchase_id,
    pu.player_id,
    pu.game_id,
    pu.currency_id,
    pu.purchase_type,
    pu.amount,
    pu.is_real_money,
    pu.is_refunded,
    pu.platform_fee_pct,
    pu.purchased_at,
    pu.created_at,
    s.spend_tier,
    s.description as spend_tier_description
from {{ source('raw_gaming', 'raw_purchases') }} pu
left join {{ ref('spend_tier_config') }} s
    on pu.amount >= s.min_amount
    and pu.amount < s.max_amount