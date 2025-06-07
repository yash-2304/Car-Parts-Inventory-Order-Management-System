create view BuyerReturnsToInventory as

select i.inventory_id,
p.part_number,
p.part_description,
v.vendor_name,
r.quantity_returned 
FROM Buyer_Return_Line_Items as r
join Buyer_PO_Line_Items as b on r.line_item_id = b.line_item_id
join Inventory as i on b.inventory_id = i.inventory_id
join Parts as p on i.part_id = p.part_id
join Vendor_Info as v on i.vendor_id = v.vendor_id;




