with source as (
    select * from {{ source('raw_gaming', 'raw_devices') }}
),
renamed as (
    select
        {{ dbt_utils.generate_surrogate_key(['device_id']) }} as device_key,
        device_id,
        device_name,
        brand,
        device_type,
        operating_system,
        cast(created_at as timestamp) as created_at
    from source
)
select * from renamed
