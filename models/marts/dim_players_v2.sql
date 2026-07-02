{{
    config(materialized='table')
}}

select
    p.player_id,
    p.username,
    p.email,
    p.region_id,
    p.account_tier,
    p.age_group,
    p.gender,
    p.total_playtime_hours,
    b.monthly_price_usd,
    b.ads_free,
    b.priority_support,
    b.exclusive_content,
    b.max_devices,
    p.updated_at,
    -- NEW in v2: high-value player flag
    case
        when p.account_tier = 'Platinum' then true
        else false
    end as is_high_value

from {{ source('raw_gaming', 'raw_players') }} p
left join {{ ref('account_tier_benefits') }} b
    on p.account_tier = b.account_tier