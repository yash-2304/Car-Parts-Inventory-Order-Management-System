use project;

DELIMITER //

CREATE PROCEDURE HighestCustomerRatedProduct()
BEGIN
    SELECT *
    FROM RatingSums AS r
    WHERE r.sum_rating = (
        SELECT MAX(r.sum_rating)
        FROM RatingSums
    )
    GROUP BY r.inventory_id;
END //
DELIMITER ;