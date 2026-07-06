with stag_data as (
    select * from {{ ref('stg_police_incident') }}
),

final_marts as (
    select
        COALESCE(Police_District, 'Unkown District') as Police_District,
        COALESCE(Incident_Category, 'Unkown Category') as Incident_Category,
        incident_year,
        incident_day_of_week,
        HOUR(Incident_Time) as incident_hour,
        COUNT(Incident_ID) as total_incident,

        SUM(case when Filed_Online = TRUE then 1 ELSE 0 end) as incident_filed_online

        from stag_data
        group by 1, 2, 3, 4, 5
)

select * from final_marts order by total_incident desc