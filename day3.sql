with roots as (
	select
		unnest(xpath('name(.//*)', menu_data))::text as root,
		*
	from christmas_menus
),

headcount as (
	select distinct
		root,
		unnest(case 
			when root = 'polar_celebration'
				then xpath('.//total_present/text()', menu_data)
			when root = 'christmas_feast'
				then xpath('.//total_guests/text()', menu_data)
			when root = 'northpole_database'
				then xpath('.//total_count/text()', menu_data)
		end)::text::int as headcount
	from roots
),

menu as (
	select 
		root,
		unnest(xpath('//food_item_id/text()', menu_data))::text::int as food_id
	from roots
)

select 
	food_id,
	count(*) as count
from headcount
left join menu
	on headcount.root = menu.root
where headcount > 78
group by 1
order by count desc
