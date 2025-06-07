use project;
DELIMITER //

CREATE PROCEDURE AvgCustomerRating(
	IN  id int
)
BEGIN
	select i.inventory_id,
	p.part_number,
	p.part_name,
	p.part_description,
	c.part_category,
	avg_rating(i.inventory_id)

	from buyer_po_line_items as o
	join inventory as i on o.inventory_id = i.inventory_id
	join parts as p on i.part_id = p.part_id
	join part_category as c on p.category_id = c.category_id
    where i.inventory_id = id
	group by i.inventory_id;
END //
DELIMITER ;