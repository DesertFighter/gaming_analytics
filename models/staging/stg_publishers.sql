with source as (
    select * from {{ source('raw_gaming', 'raw_publishers') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['publisher_id']) }} as publisher_key,
        publisher_id,
        publisher_name,
        country,
        founded_year,
        is_indie,
        cast(created_at as timestamp) as created_at
    from source
)
select * from renamed
