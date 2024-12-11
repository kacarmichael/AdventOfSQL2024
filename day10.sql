with totals as (
	select 
		date,
		drink_name,
		sum(quantity) as total
	from drinks
	group by 1, 2
	order by date asc
)

select
	date,
	sum(case when drink_name like 'Hot Cocoa' then total else 0 end) as cocoa_total,
	sum(case when drink_name like 'Peppermint Schnapps' then total else 0 end) as ps_total,
	sum(case when drink_name like 'Eggnog' then total else 0 end) as eggnog_total
from totals
group by 1
having 
	sum(case when drink_name like 'Hot Cocoa' then total else 0 end) = 38 and
	sum(case when drink_name like 'Peppermint Schnapps' then total else 0 end) = 298 and
	sum(case when drink_name like 'Eggnog' then total else 0 end) = 198
