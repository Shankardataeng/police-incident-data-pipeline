with stag_data as (
    select * from {{ ref('stg_police_incident') }}
),

final_marts as(
    select
        COALESCE(Police_District, 'Unkown_district') as Police_District,
        COALESCE(Incident_Category, 'Unkown_category') as Incident_Category,
        incident_year,
        Resolution,
        COUNT(Incident_ID) as total_incident
    from stag_data
    where Resolution = 'Open or Active'
    group by 1, 2, 3, 4
)

select * from final_marts