DELIMITER //
CREATE TRIGGER `InventoryAutomaticOrder` AFTER UPDATE ON `inventory` FOR EACH ROW
BEGIN
	DECLARE threshold INT;
    DECLARE currentQuantity INT;
    DECLARE productID INT;
    DECLARE defaultVendor_id INT;
    -- Set the threshold value
    SET threshold = 5;
    -- Get the current quantity, inventory_id from the updated row
    SET currentQuantity = NEW.quantity;
    SET productID = NEW.inventory_id;
    SET defaultVendor_id = 1;

    -- Check if the updated quantity falls below the threshold
    IF currentQuantity < threshold THEN
        -- Insert a record into vendor_parts_restock table to order more parts from the vendor
        INSERT INTO vendor_parts_restock (part_id, vendor_id, restock_quantity, purchase_status, received, tracking_number)
        VALUES (productID, defaultVendor_id, (threshold - currentQuantity), 1, 1, max(tracking_number)+1);
    END IF;
END

//

DELIMITER ;
