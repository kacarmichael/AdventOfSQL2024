with let_a as (
	select *,
		chr(value) as decoded
	from letters_a
	where chr(value) not in ('=', '_', '^', '$', '%', '|', '#', '<', '>', '&', ']', '[', '{', '}', '/', '*', '+', '\', '~', '@', '`')
),

let_b as (
	select *,
		chr(value) as decoded
	from letters_b
	where chr(value) not in ('=', '_', '^', '$', '%', '|', '#', '<', '>', '&', ']', '[', '{', '}', '/', '*', '+', '\', '~', '@', '`')
)

select *
from let_a
union all
select *
from let_b
