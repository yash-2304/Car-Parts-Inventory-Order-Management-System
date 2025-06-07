DELIMITER //

CREATE TRIGGER ShippedStatus
BEFORE UPDATE ON Buyer_Order_Shipping
FOR EACH ROW
BEGIN
    IF NEW.tracking_number IS NOT NULL AND shipping_status_id = 1 THEN
        SET NEW.shipping_status_id = 2; 
    END IF;
END;
//

DELIMITER ;
