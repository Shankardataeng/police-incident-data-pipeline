use role accountadmin;

create database if not exists police_incident;
create schema if not exists police_raw;


create or replace role dbt_role;

create user if not exists dbt_police
	password = 'dbtpolicedb'
	default_role = dbt_role
    must_change_password = false;

grant role dbt_role to user dbt_police;
grant usage on warehouse compute_wh to role dbt_role;
grant usage on database police_incident to role dbt_role;
grant usage on schema police_incident.police_raw to role dbt_role;
grant select on all tables in schema police_incident.police_raw to role dbt_role;
grant create table, create view on schema police_incident.police_raw to role dbt_role;
	

--S3 to load Data Snowflake Database
--1st create file format

create or replace file format s3_csv_format
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','Null')
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;


CREATE OR REPLACE STAGE s3_stage
    URL = 's3://electric-vehicle-population-data-s3/raw/'
    credentials =(
    AWS_KEY_ID = 'AWS_KEY_ID(here)'
    AWS_SECRET_KEY = 'AWS_SECRET_KEY(here)'
    );

CREATE or replace TABLE police_incident_reports (
    Row_ID INT,
    Incident_Datetime VARCHAR(40),
    Incident_Date VARCHAR(40),
    Incident_Time VARCHAR(40),
    Incident_Year INT,
    Incident_Day_of_Week VARCHAR(20),
    Report_Datetime VARCHAR(40),
    Incident_ID BIGINT,
    Incident_Number VARCHAR(50),
    CAD_Number VARCHAR(50),
    Report_Type_Code VARCHAR(20),
    Report_Type_Description VARCHAR(100),
    Filed_Online VARCHAR(10),
    Incident_Code VARCHAR(20),
    Incident_Category VARCHAR(100),
    Incident_Subcategory VARCHAR(100),
    Incident_Description VARCHAR(255),
    Resolution VARCHAR(255),
    Intersection VARCHAR(255),
    CNN BIGINT,
    Police_District VARCHAR(100),
    Analysis_Neighborhood VARCHAR(100),
    Supervisor_District INT,
    Supervisor_District_2012 INT,
    Latitude DECIMAL(10, 7),
    Longitude DECIMAL(10, 7),
    Point VARCHAR(100),
    data_as_of VARCHAR(40),
    data_loaded_at VARCHAR(40)
);


copy into police_incident_reports
from @s3_stage
file_format = (format_name = s3_csv_format)
on_error = continue;

select * from police_incident_reports limit 10;
