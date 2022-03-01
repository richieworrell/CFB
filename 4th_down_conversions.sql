SELECT 

* 

FROM cfb.cfb_plays cp 

WHERE cp.down = 4
AND cp.play_type NOT LIKE '%Punt%'
AND cp.play_type NOT LIKE '%Field Goal%'
AND cp.play_type NOT LIKE '%Kickoff%'
AND cp.play_type NOT LIKE '%End Period%'
AND cp.play_type NOT LIKE '%Penalty%'
AND cp.play_type NOT LIKE '%Timeout%'
AND cp.yards_gained >=cp.distance