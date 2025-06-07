use project;
DELIMITER //

CREATE PROCEDURE changeShippingStatus(IN desired_shipping_status INT, IN buyer_order_id INT)
BEGIN
    UPDATE buyer_order_shipping 
    SET shipping_status_id = desired_shipping_status
    WHERE shipping_id = (select shipping_id from buyer_po where order_id = buyer_order_id);
END //
DELIMITER ;
