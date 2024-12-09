with wl as (
	select *
	,wishes -> 'colors' ->> 0 as favorite_color
	,json_array_length(wishes -> 'colors') as color_count
	,replace((wishes -> 'first_choice')::varchar, '"', '') as primary_wish
	,replace((wishes -> 'second_choice')::varchar, '"', '') as backup_wish
	from wish_lists
),

tc as (
	select *,
		case
			when difficulty_to_make = 1 then 'Simple Gift'
			when difficulty_to_make = 2 then 'Moderate Gift'
			else 'Complex Gift'
		end as difficulty_category,
		case
			when category = 'outdoor' then 'Outside Workshop'
			when category = 'educational' then 'Learning Workshop'
			else 'General Workshop'
		end as workshop
	from toy_catalogue
),

child as (
	select *
	from children
),

joined as (
	select 
		name,
		primary_wish,
		backup_wish,
		favorite_color,
		color_count,
		primary_toy.difficulty_category as gift_complexity,
		primary_toy.workshop as workshop_assignment
	from wl
	left join tc as primary_toy
		on wl.primary_wish = primary_toy.toy_name
	left join tc as backup_toy
		on wl.backup_wish = backup_toy.toy_name
	left join child
		on wl.child_id = child.child_id
)

select *
from joined
order by name asc
limit 5


	

