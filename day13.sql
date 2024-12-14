with flattened as (
	select 
		id,
		name,
		unnest(email_addresses) email,
		split_part(unnest(email_addresses), '@', 2) as domain
	from contact_list
)

select 
	domain,
	count(*) as total
from flattened
group by domain
order by total desc

