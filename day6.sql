with gifts as (
	select *
	from gifts
),

children as (
	select *
	from children
)

select *
from gifts
inner join children
	on gifts.child_id = children.child_id
where price > (
	select avg(price)
	from gifts
)
order by price asc
