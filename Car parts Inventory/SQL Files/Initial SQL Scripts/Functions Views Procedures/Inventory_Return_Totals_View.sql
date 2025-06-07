create view InventoryReturnTotals as

SELECT r.inventory_id,
r.part_number,
r.vendor_name,
returnRate(r.inventory_id) as total_returned
from buyerreturnstoinventory as r;