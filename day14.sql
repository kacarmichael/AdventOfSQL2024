with flattened as (
	select 
		record_id,
		record_date,
		receipt.receipt_id,
		receipt.garment,
		receipt.color,
		receipt.cost,
		receipt.drop_off,
		receipt.pickup
	from santarecords,
		jsonb_to_recordset(cleaning_receipts) as receipt(
			receipt_id text,
			garment text,
			color text,
			cost numeric,
			drop_off date,
			pickup date
		)
)

select *
from flattened
where garment = 'suit'
and color = 'green'

