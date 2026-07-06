with police_incident as (
    select * from {{ source('Police_incident', 'police_incident_reports') }}
),
clean_police_incident as(
    select
        Row_ID as row_id,
        to_timestamp(Incident_Datetime,'YYYY/MM/DD HH12:MI:SS AM') AS Incident_Datetime,
        to_date(Incident_Date, 'YYYY/MM/DD') AS Incident_Date,
        to_time(Incident_Time, 'HH:MI') AS Incident_Time,
        Incident_Year,
        Incident_Day_of_Week,
        to_timestamp(Report_Datetime,'YYYY/MM/DD HH12:MI:SS AM') AS Report_Datetime,
        Incident_ID,
        Incident_Number,
        COALESCE(CAD_Number,'Unknown') AS CAD_Number,
        Report_Type_Code,
        Report_Type_Description,
        CASE
            WHEN UPPER(Filed_Online)  = 'TRUE' then TRUE
            ELSE FALSE
        END AS Filed_Online,
        Incident_Code,
        Incident_Category,
        Incident_Subcategory,
        Incident_Description,
        Resolution,
        Intersection,
        CNN,
        Police_District,
        Analysis_Neighborhood,
        Supervisor_District,
        Supervisor_District_2012,
        Latitude,
        Longitude,
        Point,
        data_as_of,
        data_loaded_at
        from police_incident
)

select * from clean_police_incident