use project;

DELIMITER //

CREATE PROCEDURE HighestCustomerRatedProduct()
BEGIN
    SELECT r.inventory_id,
    r.part_number,
    r.part_name,
    r.part_description,
    r.part_category
    FROM RatingSums AS r
    WHERE r.sum_rating = (
        SELECT MIN(r.sum_rating)
        FROM RatingSums
    )
    GROUP BY r.inventory_id;
END //
DELIMITER ;