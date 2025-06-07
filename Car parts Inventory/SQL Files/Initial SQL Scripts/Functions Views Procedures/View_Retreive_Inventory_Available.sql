use project;

CREATE VIEW RetreiveAvailableInventory as
SELECT i.inventory_id, 
p.part_number, 
p.part_name, 
p.part_description, 
v.vendor_name, 
i.revenue, 
i.quantity, 
c.part_category 
from Parts as p 
join Inventory as i on p.part_id = i.part_id 
join Vendor_Info as v on i.vendor_id = v.vendor_id 
join Part_Category as c on p.category_id = c.category_id 
order by p.part_number;