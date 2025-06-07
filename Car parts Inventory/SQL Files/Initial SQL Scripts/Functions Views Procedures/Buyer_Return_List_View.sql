use project;

create view ReturnBuyerInfo as
select b.buyer_name,
r.buyer_return_id,
p.order_id

from Buyer_Return as r
join Buyer_Return_Line_Items as e on r.buyer_return_id = e.buyer_return_id
join Buyer_PO_Line_Items as l on e.line_item_id = l.line_item_id
join Buyer_PO as p on l.order_id = p.order_id
join Buyer_Info as b on p.buyer_id = b.buyer_id
group by r.buyer_return_id;