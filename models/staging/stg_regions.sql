with source as (
    select * from {{ source('raw_gaming', 'raw_regions') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['region_id']) }} as region_key,
        region_id,
        country_code,
        country_name,
        region,
        timezone,
        cast(created_at as timestamp) as created_at
    from source
)
select * from renamed
