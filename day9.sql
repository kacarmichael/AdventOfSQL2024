select *
from (
	select
		reindeer_id,
		max(avg_speed) as top_speed
	from (
		select 
			reindeer_id,
			exercise_name,
			round(avg(speed_record), 2) as avg_speed
		from training_sessions
		group by 1, 2
	)
	group by 1
	order by top_speed desc
	limit 3
) speeds
inner join reindeers
	on speeds.reindeer_id = reindeers.reindeer_id

