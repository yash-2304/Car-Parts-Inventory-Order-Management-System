USE project;

DELIMITER //

CREATE FUNCTION orderTotal(buyer_order_id INT) RETURNS DECIMAL(10, 2)
READS SQL DATA
BEGIN
    DECLARE total DECIMAL(10, 2);

    SELECT sum(extended_revenue_price) INTO total
    FROM buyer_po_line_items
    WHERE order_id = buyer_order_id;

    RETURN total;
END//

DELIMITER ;