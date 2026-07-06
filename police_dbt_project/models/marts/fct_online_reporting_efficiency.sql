with stag_data as
(
    select * from  {{ ref('stg_police_incident') }}
),

online_reportion_efficiency_logic as (
    select
        COALESCE(Police_District, 'Unkown_district') as Police_District,
        Incident_Year,
        Incident_Category,

        SUM(case when Filed_Online = TRUE then 1 ELSE 0 end) as Filed_Online_incident,
        COUNT(Incident_ID) as total_incidents
    from stag_data
    group by 1, 2, 3
)

select * from online_reportion_efficiency_logic order by total_incidents desc