with source as (
    select * from {{ source('raw_gaming', 'raw_achievement_unlocks') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['unlock_id']) }} as unlock_key,
        unlock_id,
        player_id,
        achievement_id,
        cast(unlocked_at as timestamp) as unlocked_at,
        time_to_unlock_hours,
        is_first_global_unlock,
        cast(created_at as timestamp)  as created_at
    from source
)
select * from renamed
