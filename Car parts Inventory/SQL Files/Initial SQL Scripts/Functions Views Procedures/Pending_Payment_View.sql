use project;

create view pendingPayments as
select p.buyer_id,
b.buyer_name,
p.order_id,
(select orderTotal(order_id)) as 'total',
p.payment_status

from Buyer_Info as b
join Buyer_PO as p on b.buyer_id = p.buyer_id;


    