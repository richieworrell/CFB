{{
  config(
    materialized = 'view',
    schema= 'data'
  )
}}


SELECT 

*
,CASE 
    WHEN x.points > x.opponent_points
    THEN 'Win'
    WHEN x.points = x.opponent_points
    THEN 'Tie'
    ELSE 'Loss'
END AS Win_Loss
,CASE 
    WHEN x.conference in ('SEC', 'ACC','Big Ten', 'Big 12', 'Pac-12')
    THEN 'P5'
    WHEN x.conference in ('Mid-American', 'Conference USA','Mountain West', 'American Athletic', 'Sun Belt')
    THEN 'G5'
    ELSE 'FBS Independents or Non-Conference'
END AS Conference_Group


FROM 

	(SELECT 
	
	t.school
    ,t.conference
    ,t.color
	,g.id
	,g.season 
	,g.start_date
	,g.attendance
	,g.venue
	,g.home_points AS points
	,g.away_points AS opponent_points
	,g.away_team AS opponent
	,'home' AS home_or_away
	
	FROM rw_cfb_data.cfb_games g
	JOIN rw_cfb_data.cfb_teams t ON t.id=g.home_id-- AND t.id=g.away_id
	
	--WHERE t.school = 'Virginia Tech'
	
	UNION 
	
	SELECT 
	
	t.school
    ,t.conference
    ,t.color
	,g.id
	,g.season 
	,g.start_date
	,g.attendance
	,g.venue
	,g.away_points AS points
	,g.home_points AS opponent_points
	,g.home_team AS opponent 
	,'away' AS home_or_away
	
	FROM rw_cfb_data.cfb_games g
	JOIN rw_cfb_data.cfb_teams t ON t.id=g.away_id-- AND t.id=g.away_id
	
	--WHERE t.school = 'Virginia Tech'
)x

ORDER BY 
x.school 
,x.start_date

