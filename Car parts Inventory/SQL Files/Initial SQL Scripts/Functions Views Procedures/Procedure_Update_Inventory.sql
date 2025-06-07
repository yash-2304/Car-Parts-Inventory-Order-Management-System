use project;

DELIMITER //

CREATE PROCEDURE updateInventory(IN inventoryID INT, IN quantity_sold INT)
BEGIN
    UPDATE inventory 
    SET quantity = quantity - quantity_sold 
    WHERE inventory_id = inventoryID;
END //

DELIMITER ;