with prod as (
	select *,
		lag(toys_produced, 1) over (order by production_date) as prev_prod
	from toy_production
),

final as (
	select *,
		toys_produced - prev_prod as prod_change,
		((toys_produced::numeric - prev_prod::numeric)/prev_prod::numeric)*100.0 as prod_perc_change
	from prod
)

select *
from final
where prod_perc_change = (
	select max(prod_perc_change)
	from final
)

