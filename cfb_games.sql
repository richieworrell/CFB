ALTER TABLE cfb.cfb_games (
id	varchar 		
,season	varchar 		
,week	int		
,season_type	varchar 		
,start_date	date 		
,start_time_tbd	varchar  		
,neutral_site	bool		
,conference_game	bool		
,attendance	int		
,venue_id	varchar 
,venue	varchar 		
,home_id	varchar 		
,home_team	varchar 		
,home_conference	varchar 		
,home_points	int		
,home_line_scores	varchar 		
,home_post_win_prob	float		
,home_pregame_elo	int		
,home_postgame_elo	int		
,away_id	varchar 		
,away_team	varchar 		
,away_conference	varchar 		
,away_points	int		
,away_line_scores	varchar 		
,away_post_win_prob	float		
,away_pregame_elo	int		
,away_postgame_elo	int		
,excitement_index	float		
,highlights	varchar 		
,notes	varchar 		
,json_raw json
);

INSERT INTO cfb.cfb_games(
id	 		
,season	 		
,week			
,season_type	 		
,start_date	 		
,start_time_tbd			
,neutral_site			
,conference_game			
,attendance			
,venue_id	 
,venue	 		
,home_id	 		
,home_team	 		
,home_conference	 		
,home_points			
,home_line_scores	 		
,home_post_win_prob			
,home_pregame_elo			
,home_postgame_elo			
,away_id	 		
,away_team	 		
,away_conference	 		
,away_points			
,away_line_scores	 		
,away_post_win_prob			
,away_pregame_elo			
,away_postgame_elo			
,excitement_index			
,highlights	 		
,notes	 		
,json_raw 
)


SELECT 
	CAST(CAST(json_raw AS json) ::json->'id' AS varchar) as id
	,CAST(CAST(json_raw AS json) ::json->'season' AS varchar) as season 
	,CAST(CAST(CAST(json_raw AS json) ::json->'week' AS varchar)AS int) as week 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'season_type' AS varchar),'(")', '', 'g') AS season_type 
	,CAST(left(regexp_replace(CAST(CAST(json_raw AS json) ::json->'start_date' AS varchar),'(")', '', 'g'), 10) AS date) AS start_date  
	,CAST(CAST(json_raw AS json) ::json->'start_time_tbd' AS varchar) as start_time_tbd  
	,CAST(CAST(json_raw AS json) ::json->'neutral_site' AS varchar) as neutral_site  
	,CAST(CAST(json_raw AS json) ::json->'conference_game' AS varchar) as conference_game 
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'attendance' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'attendance' AS varchar) AS float)
		END AS attendance 
	,CAST(CAST(json_raw AS json) ::json->'venue_id' AS varchar) as venue_id 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'venue' AS varchar),'(")', '', 'g') as venue 
	,CAST(CAST(json_raw AS json) ::json->'home_id' AS varchar) as home_id 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'home_team' AS varchar),'(")', '', 'g') as home_team 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'home_conference' AS varchar),'(")', '', 'g') as home_conference 
	,CAST(CAST(CAST(json_raw AS json) ::json->'home_points' AS varchar) AS int) as home_points  
	,CAST(CAST(json_raw AS json) ::json->'home_line_scores' AS varchar) as home_line_scores  
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'home_post_win_prob' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'home_post_win_prob' AS varchar) AS float)
		END AS home_post_win_prob  
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'home_pregame_elo' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'home_pregame_elo' AS varchar) AS float)
		END AS home_pregame_elo  
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'home_postgame_elo' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'home_postgame_elo' AS varchar) AS float)
		END AS home_postgame_elo  
	,CAST(CAST(json_raw AS json) ::json->'away_id' AS varchar) as away_id 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'away_team' AS varchar),'(")', '', 'g') as away_team 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'away_conference' AS varchar),'(")', '', 'g') as away_conference 
	,CAST(CAST(CAST(json_raw AS json) ::json->'away_points' AS varchar) AS int) as away_points  
	,CAST(CAST(json_raw AS json) ::json->'away_line_scores' AS varchar) as away_line_scores  
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'away_post_win_prob' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'away_post_win_prob' AS varchar) AS float)
		END AS away_post_win_prob  
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'away_pregame_elo' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'away_pregame_elo' AS varchar) AS float)
		END AS away_pregame_elo  
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'away_postgame_elo' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'away_postgame_elo' AS varchar) AS float)
		END AS away_postgame_elo  
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'excitement_index' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'excitement_index' AS varchar) AS float)
		END AS excitement_index 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'highlights' AS varchar),'(")', '', 'g') AS highlights  
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'notes' AS varchar),'(")', '', 'g') AS notes 
	,CAST(json_raw AS json) AS json_raw 

FROM cfb.json_games 
	

ORDER BY start_date DESC  







	


	
	
