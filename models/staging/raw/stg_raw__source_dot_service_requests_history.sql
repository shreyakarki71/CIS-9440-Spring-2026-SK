with 

source as (

    select * from {{ source('raw', 'source_dot_service_requests_history') }}

),

renamed as (

    select

    from source

)

select * from renamed