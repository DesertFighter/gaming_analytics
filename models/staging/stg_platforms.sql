with source as (
    select * from {{ source('raw_gaming', 'raw_platforms') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['platform_id']) }} as platform_key,
        platform_id,
        platform_name,
        platform_type,
        manufacturer,
        release_year,
        cast(created_at as timestamp) as created_at
    from source
)
select * from renamed
