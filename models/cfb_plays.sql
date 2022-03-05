{{
  config(
    materialized = 'table',
    schema= 'data'
  )
}}

SELECT 
	 CASE WHEN CAST(CAST(json_raw AS json) ::json->'id' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'id' AS varchar) END  as id
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'drive_id' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'drive_id' AS varchar) END  as drive_id 
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'game_id' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'game_id' AS varchar) END  as game_id 
	,CAST(CAST(CAST(json_raw AS json) ::json->'drive_number' AS varchar)AS int) as drive_number 
	,CAST(CAST(CAST(json_raw AS json) ::json->'play_number' AS varchar)AS int) as play_number 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'offense' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'offense' AS varchar),'(")', '', 'g') END as offense 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'offense_conference' AS varchar),'(")', '', 'g')='null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'offense_conference' AS varchar),'(")', '', 'g') END as offense_conference 
	,CAST(CAST(CAST(json_raw AS json) ::json->'offense_score' AS varchar)AS int) as offense_score 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'defense' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'defense' AS varchar),'(")', '', 'g') END  as defense 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'home' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'home' AS varchar),'(")', '', 'g') END as home 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'away' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'away' AS varchar),'(")', '', 'g') END as away  
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'defense_conference' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'defense_conference' AS varchar),'(")', '', 'g') END as defense_conference 
	,CAST(CAST(CAST(json_raw AS json) ::json->'defense_score' AS varchar)AS int) as defense_score
	,CAST(CAST(CAST(json_raw AS json) ::json->'period' AS varchar)AS int) as period
	,CASE WHEN CAST(json_raw AS json) ::json->'clock'->> 'minutes' = 'null' THEN NULL ELSE CAST(json_raw AS json) ::json->'clock'->> 'minutes' END as minutes 
	,CASE WHEN CAST(json_raw AS json) ::json->'clock'->> 'seconds' = 'null' THEN NULL ELSE CAST(json_raw AS json) ::json->'clock'->> 'seconds' END as seconds 
	,CAST('00:' || (CONCAT(CAST(json_raw AS json) ::json->'clock'->> 'minutes',':', CAST(json_raw AS json) ::json->'clock'->> 'seconds')) AS time) AS clock 
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'offense_timeouts' AS varchar)='null'THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'offense_timeouts' AS varchar) AS float) END AS offense_timeouts  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'defense_timeouts' AS varchar)='null' THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'defense_timeouts' AS varchar) AS float) END AS defense_timeouts 
	,CAST(CAST(CAST(json_raw AS json) ::json->'yard_line' AS varchar)AS int) as yard_line 
	,CAST(CAST(CAST(json_raw AS json) ::json->'yards_to_goal' AS varchar)AS int) as yards_to_goal
	,CAST(CAST(CAST(json_raw AS json) ::json->'down' AS varchar)AS int) as down 
	,CAST(CAST(CAST(json_raw AS json) ::json->'distance' AS varchar)AS int) as distance 
	,CAST(CAST(CAST(json_raw AS json) ::json->'yards_gained' AS varchar)AS int) as yards_gained 
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'scoring' AS varchar) = 'true' THEN TRUE ELSE FALSE END as scoring 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'play_type' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'play_type' AS varchar),'(")', '', 'g') END as play_type 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'play_text' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'play_text' AS varchar),'(")', '', 'g') END as play_text 
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'ppa' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'ppa' AS varchar) END as ppa 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'wallclock' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'wallclock' AS varchar),'(")', '', 'g') END as wallclock
	,CAST(json_raw AS json) AS json_raw 

FROM dev_raw.json_plays 



	
	