{{
  config(
    materialized = 'view',
    schema= 'data'
  )
}}







WITH FOURTH_DOWNS AS (

	SELECT 
		
	*
	
	FROM rw_cfb_data.cfb_plays cp 
	
	WHERE cp.down = 4
	AND cp.play_type NOT LIKE '%Punt%'
	AND cp.play_type NOT LIKE '%Field Goal%'
	AND cp.play_type NOT LIKE '%Kickoff%'
	AND cp.play_type NOT LIKE '%End Period%'
	AND cp.play_type NOT LIKE '%Penalty%'
	AND cp.play_type NOT LIKE '%Timeout%'
	--AND cp.yards_gained >=cp.distance
	

)



SELECT 

fd.id
,fd.game_id
,fd.down
,fd.offense
,CASE 
	WHEN fd.yards_gained >= fd.distance
	THEN 'SUCCESS'
	ELSE 'FAILURE'
	END AS CONVERSION
,fd.distance
,fd.yards_gained
,fd.play_type
,fd.play_text

FROM FOURTH_DOWNS fd

ORDER BY fd.distance DESC 



		
	

		
	