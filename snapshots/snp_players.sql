{% snapshot snp_players %}

{{
    config(
        target_schema='snapshots',
        unique_key='player_id',
        strategy='timestamp',
        updated_at='updated_at',
    )
}}

select
    player_id,
    username,
    email,
    region_id,
    account_tier,
    age_group,
    gender,
    total_playtime_hours,
    updated_at
from {{ source('raw_gaming', 'raw_players') }}

{% endsnapshot %}