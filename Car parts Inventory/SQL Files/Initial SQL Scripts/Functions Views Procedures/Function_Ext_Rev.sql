USE project;

DELIMITER //

CREATE FUNCTION extRev(inventoryID INT, quantity INT) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE extended_rev DECIMAL(10, 2);

    SELECT inventory.revenue * quantity INTO extended_rev
    FROM inventory
    WHERE inventory_id = inventoryID;

    RETURN extended_rev;
END//

DELIMITER ;