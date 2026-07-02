-- analyses/player_revenue_cohort.sql
--
-- PURPOSE: Ad-hoc analysis of player revenue by spend tier and month.
-- This file is COMPILED by dbt (ref() resolved) but NEVER EXECUTED.
-- No table or view is created in BigQuery.
-- After running `dbt compile`, find the compiled SQL at:
--   target/compiled/gaming_analytics/analyses/player_revenue_cohort.sql
--
-- Uses ref() to reference mart models in an environment-agnostic way.

with purchases as (

    select *
    from {{ ref('fct_purchases') }}

),

players as (

    select *
    from {{ ref('dim_players') }}

),

monthly_revenue as (

    select
        p.player_id,
        pl.account_tier,
        date_trunc(p.purchased_at, month)   as purchase_month,
        count(p.purchase_id)                as purchase_count,
        sum(p.amount)                       as total_revenue,
        avg(p.amount)                       as avg_purchase_value

    from purchases p
    join players pl using (player_id)

    group by
        p.player_id,
        pl.account_tier,
        purchase_month

)

select
    purchase_month,
    account_tier,
    count(distinct player_id)   as active_players,
    sum(purchase_count)         as total_purchases,
    sum(total_revenue)          as total_revenue,
    avg(avg_purchase_value)     as avg_purchase_value,
    sum(total_revenue)
        / nullif(count(distinct player_id), 0) as revenue_per_player

from monthly_revenue

group by
    purchase_month,
    account_tier

order by
    purchase_month desc,
    account_tier
