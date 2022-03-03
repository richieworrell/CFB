{{
  config(
    materialized = 'table',
    schema= 'cfb'
  )
}}


SELECT 
	CASE WHEN CAST(CAST(json_raw AS json) ::json->'id' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'id' AS varchar) END as id
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'school' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'school' AS varchar),'(")', '', 'g') END as school
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'abbreviation' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'abbreviation' AS varchar),'(")', '', 'g') END as abbreviation
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'mascot' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'mascot' AS varchar),'(")', '', 'g') END  as mascot
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'conference' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'conference' AS varchar),'(")', '', 'g') END as conference
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'division' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'division' AS varchar),'(")', '', 'g') END  as division
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'location'->> 'city' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'location'->> 'city' AS varchar),'(")', '', 'g') end  as city
	,CASE WHEN CAST(json_raw AS json) ::json->'location'->> 'capacity' = 'None' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'location'->> 'capacity' AS int) END as capacity
	,CASE WHEN CAST(json_raw AS json) ::json->'location'->> 'dome'='true' THEN TRUE ELSE FALSE END  as dome 
	,CASE WHEN CAST(json_raw AS json) ::json->'location'->> 'elevation' = 'None' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'location'->> 'elevation' AS float)  END as elevation
	,CASE WHEN CAST(json_raw AS json) ::json->'location'->> 'grass' = 'true' THEN TRUE ELSE FALSE END as grass
	,CAST(json_raw AS json) ::json->'location'->> 'latitude' as latitude 
	,CAST(json_raw AS json) ::json->'location'->> 'longitude' as longitude 
	,CASE WHEN CAST(json_raw AS json) ::json->'location'->> 'name' ='null' THEN NULL ELSE CAST(json_raw AS json) ::json->'location'->> 'name' END as location_name
	,CASE WHEN CAST(json_raw AS json) ::json->'location'->> 'state' = 'null' THEN NULL ELSE CAST(json_raw AS json) ::json->'location'->> 'state' END as state
	,CASE WHEN CAST(json_raw AS json) ::json->'location'->> 'timezone' = 'null' THEN NULL ELSE CAST(json_raw AS json) ::json->'location'->> 'timezone' END as timezone 
	,CASE WHEN CAST(json_raw AS json) ::json->'location'->> 'venue_id' = 'null' THEN NULL ELSE CAST(json_raw AS json) ::json->'location'->> 'venue_id' END as venue_id 
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'location'->> 'year_constructed' AS varchar)='None' THEN NULL ELSE to_date(CAST(CAST(json_raw AS json) ::json->'location'->> 'year_constructed' AS varchar), 'YYYY') END AS year_constructed 
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'logos' AS varchar) = 'null' THEN NULL ELSE CAST(json_raw AS json) ::json->'logos' END  as logos
	,CAST(json_raw AS json) AS raw_json

FROM cfb.json_teams jt  


