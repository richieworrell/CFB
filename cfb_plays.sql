ALTER  TABLE cfb.cfb_plays (
id varchar 
,drive_id varchar 
,game_id varchar 
,drive_number int
,play_number int
,offense varchar 
,offense_conference varchar 
,offense_score int
,defense varchar 
,home varchar 
,away varchar 
,defense_conference varchar 
,defense_score int 
,period int 
,minutes varchar 
,seconds varchar 
,clock time
,offense_timeouts int
,defense_timeouts int
,yard_line int
,yards_to_goal int
,down int
,distance int
,yards_gained int
,scoring varchar 
,play_type varchar 
,play_text varchar 
,ppa varchar 
,wallclock varchar 
,json_raw json 
);

INSERT INTO cfb.cfb_plays(
id 
,drive_id 
,game_id 
,drive_number 
,play_number 
,offense 
,offense_conference 
,offense_score 
,defense 
,home
,away
,defense_conference 
,defense_score 
,period 
,minutes 
,seconds 
,clock 
,offense_timeouts 
,defense_timeouts 
,yard_line 
,yards_to_goal 
,down
,distance 
,yards_gained 
,scoring 
,play_type 
,play_text 
,ppa 
,wallclock 
,json_raw 
)


SELECT 
	CAST(CAST(json_raw AS json) ::json->'id' AS varchar) as id
	,CAST(CAST(json_raw AS json) ::json->'drive_id' AS varchar) as drive_id 
	,CAST(CAST(json_raw AS json) ::json->'game_id' AS varchar) as game_id 
	,CAST(CAST(CAST(json_raw AS json) ::json->'drive_number' AS varchar)AS int) as drive_number 
	,CAST(CAST(CAST(json_raw AS json) ::json->'play_number' AS varchar)AS int) as play_number 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'offense' AS varchar),'(")', '', 'g') as offense 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'offense_conference' AS varchar),'(")', '', 'g') as offense_conference 
	,CAST(CAST(CAST(json_raw AS json) ::json->'offense_score' AS varchar)AS int) as offense_score 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'defense' AS varchar),'(")', '', 'g') as defense 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'home' AS varchar),'(")', '', 'g') as home 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'away' AS varchar),'(")', '', 'g') as away  
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'defense_conference' AS varchar),'(")', '', 'g') as defense_conference 
	,CAST(CAST(CAST(json_raw AS json) ::json->'defense_score' AS varchar)AS int) as defense_score
	,CAST(CAST(CAST(json_raw AS json) ::json->'period' AS varchar)AS int) as period
	,CAST(json_raw AS json) ::json->'clock'->> 'minutes' as minutes 
	,CAST(json_raw AS json) ::json->'clock'->> 'seconds' as seconds 
	,CAST('00:' || (CONCAT(CAST(json_raw AS json) ::json->'clock'->> 'minutes',':', CAST(json_raw AS json) ::json->'clock'->> 'seconds')) AS time) AS clock 
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'offense_timeouts' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'offense_timeouts' AS varchar) AS float)
		END AS offense_timeouts  
	,CASE WHEN 
		CAST(CAST(json_raw AS json) ::json-> 'defense_timeouts' AS varchar)='null'
		THEN NULL 
		ELSE CAST(CAST(CAST(json_raw AS json) ::json-> 'defense_timeouts' AS varchar) AS float)
		END AS defense_timeouts 
	,CAST(CAST(CAST(json_raw AS json) ::json->'yard_line' AS varchar)AS int) as yard_line 
	,CAST(CAST(CAST(json_raw AS json) ::json->'yards_to_goal' AS varchar)AS int) as yards_to_goal
	,CAST(CAST(CAST(json_raw AS json) ::json->'down' AS varchar)AS int) as down 
	,CAST(CAST(CAST(json_raw AS json) ::json->'distance' AS varchar)AS int) as distance 
	,CAST(CAST(CAST(json_raw AS json) ::json->'yards_gained' AS varchar)AS int) as yards_gained 
	,CAST(CAST(json_raw AS json) ::json->'scoring' AS varchar) as scoring 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'play_type' AS varchar),'(")', '', 'g') as play_type 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'play_text' AS varchar),'(")', '', 'g') as play_text 
	,CAST(CAST(json_raw AS json) ::json->'ppa' AS varchar) as ppa 
	,regexp_replace(CAST(CAST(json_raw AS json) ::json->'wallclock' AS varchar),'(")', '', 'g') as wallclock
	,CAST(json_raw AS json) AS json_raw 

FROM cfb.json_plays 
	







	


	
	
