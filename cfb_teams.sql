ALTER TABLE cfb.cfb_teams(id varchar
,school varchar
,abbreviation varchar
,mascot varchar
,conference varchar
,division varchar
,city varchar
,capacity int
,dome varchar
,elevation float
,grass varchar
,latitude varchar
,longitude varchar
,location_name varchar
,state varchar
,timezone varchar
,venue_id varchar
,year_constructed date
,logos json 
,raw_json json 
)

INSERT INTO cfb.cfb_teams (
id 
,school 
,abbreviation 
,mascot 
,conference 
,division 
,city 
,capacity 
,dome 
,elevation 
,grass 
,latitude 
,longitude 
,location_name 
,state 
,timezone 
,venue_id 
,year_constructed 
,logos 
,raw_json 
)


SELECT 
	CAST(CAST(json_raw AS json) ::json->'id' AS varchar) as id
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'school' AS varchar),'(")', '', 'g')  as school
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'abbreviation' AS varchar),'(")', '', 'g')  as abbreviation
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'mascot' AS varchar),'(")', '', 'g')  as mascot
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'conference' AS varchar),'(")', '', 'g')  as conference
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'division' AS varchar),'(")', '', 'g')  as division
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'location'->> 'city' AS varchar),'(")', '', 'g')  as city
	,CASE 
		WHEN CAST(json_raw AS json) ::json->'location'->> 'capacity' = 'None'
		THEN NULL 
		ELSE CAST(CAST(json_raw AS json) ::json->'location'->> 'capacity' AS int) 
	 END as capacity
	,CAST(json_raw AS json) ::json->'location'->> 'dome' as dome 
	,CASE 
		WHEN CAST(json_raw AS json) ::json->'location'->> 'elevation' = 'None'
		THEN NULL 
		ELSE CAST(CAST(json_raw AS json) ::json->'location'->> 'elevation' AS float) 
	 END as elevation
	,CAST(json_raw AS json) ::json->'location'->> 'grass' as grass
	,CAST(json_raw AS json) ::json->'location'->> 'latitude' as latitude 
	,CAST(json_raw AS json) ::json->'location'->> 'longitude' as longitude 
	,CAST(json_raw AS json) ::json->'location'->> 'name' as location_name
	,CAST(json_raw AS json) ::json->'location'->> 'state' as state
	,CAST(json_raw AS json) ::json->'location'->> 'timezone' as timezone 
	,CAST(json_raw AS json) ::json->'location'->> 'venue_id' as venue_id 
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json->'location'->> 'year_constructed' AS varchar)='None'
		THEN NULL 
		ELSE to_date(CAST(CAST(json_raw AS json) ::json->'location'->> 'year_constructed' AS varchar), 'YYYY')
	 END AS year_constructed 
	,CAST(json_raw AS json) ::json->'logos' as logos
	,CAST(json_raw AS json) AS raw_json
	
	
	
	
	FROM cfb.json_teams  jt 
	
	
	
	
