DELIMITER //

CREATE DEFINER=`admin`@`%` PROCEDURE `cancel_order`(IN orderID INT)
BEGIN
	DECLARE preparingStatusID INT;
    DECLARE shippingStatusCount INT;

    -- Get the status ID for "preparing" from the shipping_status table
    SELECT shipping_status_id INTO preparingStatusID
    FROM shipping_status
    WHERE shipping_status = 'preparing';

    -- Check if the given order_id has a shipping status of "preparing"
    SELECT COUNT(*) INTO shippingStatusCount
    FROM buyer_order_shipping bos
    JOIN shipping_status ss ON bos.shipping_status_id = ss.shipping_status_id
    WHERE bos.shipping_id IN (
        SELECT shipping_id FROM buyer_po WHERE order_id = orderID
    ) AND ss.shipping_status_id = preparingStatusID;

    IF shippingStatusCount > 0 THEN
        -- Delete from buyer_po_line_items table
        DELETE FROM buyer_po_line_items
        WHERE order_id = orderID;

        -- Delete from buyer_order_shipping table based on shipping_id and shipping status is "preparing"
        DELETE FROM buyer_order_shipping
        WHERE shipping_status_id IN (
            SELECT shipping_id FROM buyer_po WHERE order_id = orderID
        ) AND shipping_status_id = preparingStatusID;

        -- Delete from buyer_po table based on order_id
        DELETE FROM buyer_po
        WHERE order_id = orderID;

    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Shipping status is not "preparing". Cannot delete order.';
    END IF;

END //
DELIMITER ;