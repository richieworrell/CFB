{{
  config(
    materialized = 'view',
    schema= 'cfb'
  )
}}


SELECT 

*

FROM 

	(SELECT 
	
	t.school
	,g.id
	,g.season 
	,g.start_date
	,g.attendance
	,g.venue
	,g.home_points AS points
	,g.away_points AS opponent_points
	,g.away_team AS opponent
	,'home' AS home_or_away
	
	FROM dbt_rworrell_cfb.cfb_games g
	JOIN dbt_rworrell_cfb.cfb_teams t ON t.id=g.home_id-- AND t.id=g.away_id
	
	WHERE t.school = 'Virginia Tech'
	
	UNION 
	
	SELECT 
	
	t.school
	,g.id
	,g.season 
	,g.start_date
	,g.attendance
	,g.venue
	,g.away_points AS points
	,g.home_points AS opponent_points
	,g.home_team AS opponent 
	,'away' AS home_or_away
	
	FROM dbt_rworrell_cfb.cfb_games g
	JOIN dbt_rworrell_cfb.cfb_teams t ON t.id=g.away_id-- AND t.id=g.away_id
	
	WHERE t.school = 'Virginia Tech'
)x

ORDER BY x.points DESC 



