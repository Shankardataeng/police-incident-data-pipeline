with stag_data as(
    select * from {{ ref('stg_police_incident') }}
),

Weekend_weekday_logic as (
    select
        COALESCE(Police_District, 'Unkown District') as Police_District,
        Incident_Category,
        incident_year,
        case
            when UPPER(Incident_Day_of_Week) in ('SATURDAY', 'SUNDAY') then 'Weekend'
            ELSE 'weekday'
            end as day_type,
        Incident_ID
    from stag_data
),

final_marts as (
    select 
        Police_District,
        Incident_Category,
        Incident_Year,
        day_type,

        COUNT(Incident_ID) as total_incidents
    from Weekend_weekday_logic
    group by 1, 2, 3, 4
)
select * from final_marts order by total_incidents desc