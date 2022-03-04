{{
  config(
    materialized = 'table',
    schema= 'data'
  )
}}

SELECT 
	 CASE WHEN  CAST(CAST(json_raw AS json) ::json->'id' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'id' AS varchar) END  as id
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'season' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'season' AS varchar) END  as season 
	,CAST(CAST(CAST(json_raw AS json) ::json->'week' AS varchar)AS int) as week 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'season_type' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'season_type' AS varchar),'(")', '', 'g') END AS season_type 
	,CAST(left(regexp_replace(CAST(CAST(json_raw AS json) ::json->'start_date' AS varchar),'(")', '', 'g'), 10) AS date) AS start_date  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'start_time_tbd' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'start_time_tbd' AS varchar) END as start_time_tbd  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'neutral_site' AS varchar) = 'false' THEN FALSE ELSE TRUE END as neutral_site  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'conference_game' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'conference_game' AS varchar) END as conference_game 
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'attendance' AS varchar)='null' THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'attendance' AS varchar) AS float) END AS attendance 
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'venue_id' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'venue_id' AS varchar) END  as venue_id 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'venue' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'venue' AS varchar),'(")', '', 'g') END as venue 
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'home_id' AS varchar)='null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'home_id' AS varchar) END  as home_id 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'home_team' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'home_team' AS varchar),'(")', '', 'g') end as home_team 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'home_conference' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'home_conference' AS varchar),'(")', '', 'g') END as home_conference 
	,CAST(CAST(CAST(json_raw AS json) ::json->'home_points' AS varchar) AS int) as home_points  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'home_line_scores' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'home_line_scores' AS varchar) END as home_line_scores  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'home_post_win_prob' AS varchar)='null' THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'home_post_win_prob' AS varchar) AS float) END AS home_post_win_prob  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'home_pregame_elo' AS varchar)='null' THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'home_pregame_elo' AS varchar) AS float) END AS home_pregame_elo  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'home_postgame_elo' AS varchar)='null' THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'home_postgame_elo' AS varchar) AS float) END AS home_postgame_elo  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'away_id' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'away_id' AS varchar) END as away_id 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'away_team' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'away_team' AS varchar),'(")', '', 'g') END  as away_team 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'away_conference' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'away_conference' AS varchar),'(")', '', 'g') END as away_conference 
	,CAST(CAST(CAST(json_raw AS json) ::json->'away_points' AS varchar) AS int) as away_points  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json->'away_line_scores' AS varchar) = 'null' THEN NULL ELSE CAST(CAST(json_raw AS json) ::json->'away_line_scores' AS varchar) END  as away_line_scores  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'away_post_win_prob' AS varchar)='null'THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'away_post_win_prob' AS varchar) AS float) END AS away_post_win_prob  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'away_pregame_elo' AS varchar)='null' THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'away_pregame_elo' AS varchar) AS float) END AS away_pregame_elo  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'away_postgame_elo' AS varchar)='null' THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'away_postgame_elo' AS varchar) AS float) END AS away_postgame_elo  
	,CASE WHEN CAST(CAST(json_raw AS json) ::json-> 'excitement_index' AS varchar)='null'THEN NULL ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'excitement_index' AS varchar) AS float) END AS excitement_index 
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'highlights' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'highlights' AS varchar),'(")', '', 'g') END  AS highlights  
	,CASE WHEN regexp_replace(CAST(CAST(json_raw AS json) ::json->'notes' AS varchar),'(")', '', 'g') = 'null' THEN NULL ELSE regexp_replace(CAST(CAST(json_raw AS json) ::json->'notes' AS varchar),'(")', '', 'g')END  AS notes 
	,CAST(json_raw AS json) AS json_raw 

FROM cfb.json_games 