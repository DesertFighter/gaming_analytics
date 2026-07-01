with source as (
    select * from {{ source('raw_gaming', 'raw_genres') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['genre_id']) }} as genre_key,
        genre_id,
        genre_name,
        is_multiplayer_focused,
        cast(created_at as timestamp) as created_at
    from source
)
select * from renamed
