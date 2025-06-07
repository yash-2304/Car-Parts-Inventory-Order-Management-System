USE project;

DELIMITER //

CREATE FUNCTION returnRate(inventoryID INT) RETURNS INT
READS SQL DATA
BEGIN
    DECLARE rate INT;

    SELECT sum(r.quantity_returned)
    FROM Buyer_Return_Line_Items as r
    join Buyer_PO_Line_Items as b on r.line_item_id = b.line_item_id
    join Inventory as i on b.inventory_id = i.inventory_id
    WHERE i.inventory_id = inventoryID;

    RETURN rate;
END//

DELIMITER ;