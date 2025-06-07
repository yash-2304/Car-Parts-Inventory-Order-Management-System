use project;
DELIMITER //

CREATE PROCEDURE createBuyer(
	IN  input_buyer_name VARCHAR(200), 
	IN input_street VARCHAR(100), 
	IN input_city VARCHAR(50),
    IN input_contact VARCHAR(50)
)
BEGIN
    INSERT INTO Buyer_Info (buyer_name, street, city, contact) 
	VALUES (input_buyer_name, input_street, input_city, input_contact);
END //
DELIMITER ;