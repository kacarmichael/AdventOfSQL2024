with recursive employee_hierarchy as (
	select 
		staff_id,
		staff_name,
		manager_id,
		1 as level
	from staff
	union all
	select 
		s.staff_id,
		s.staff_name,
		s.manager_id,
		eh.level + 1
	from staff s
	inner join employee_hierarchy eh 
		on s.manager_id = eh.staff_id
)

select 
	staff_id,
	max(level) as depth
from employee_hierarchy
group by 1
order by depth desc
