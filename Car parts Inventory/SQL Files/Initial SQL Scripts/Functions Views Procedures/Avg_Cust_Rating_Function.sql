USE project;

DELIMITER //

CREATE FUNCTION avg_rating(inventoryID INT) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE rating INT;
    SELECT avg(o.customer_rating) into rating
    from buyer_po_line_items as o
    join inventory as i on o.inventory_id = i.inventory_id
    where o.inventory_id = inventoryID;
    
    RETURN rating;
END//

DELIMITER ;