with stag_data as (
    select * from {{ ref('stg_police_incident') }}
),

yearly_counts as (
    select 
        incident_year,
        COUNT(Incident_ID) as total_incident
    from stag_data
    group by 1
),

growth_colculation as (
    select
        incident_year,
        total_incident,
        LAG(total_incident) over (order by incident_year) as previous_year_incidents
    from yearly_counts
)

select
    incident_year,
    total_incident,
    COALESCE(previous_year_incidents, 0) as previous_year_incidents,
    (total_incident - COALESCE(previous_year_incidents, total_incident)) as crime_difference
from growth_colculation
order by incident_year