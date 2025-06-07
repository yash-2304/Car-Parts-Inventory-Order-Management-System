use project;

/*Update Parts table with category_id:*/
UPDATE Parts
SET Parts.category_id = (
	SELECT Part_Category.category_id
	FROM Part_Category
	WHERE Part_Category.part_category = Parts.part_category
	);

/*Make category_id have a NOT NULL constraint and a foreign key in the Parts table*/
ALTER TABLE Parts
	ADD CONSTRAINT category_id
	FOREIGN KEY (category_id)
	REFERENCES Part_Category(category_id);
	
/*Update Inventory table with vendor_id and part_id*/
UPDATE Inventory
SET Inventory.vendor_id = (
	SELECT Vendor_Info.vendor_id
	FROM Vendor_Info
	WHERE Vendor_Info.vendor_name = Inventory.vendor_name
	);

UPDATE Inventory
SET Inventory.part_id = (
	SELECT Parts.part_id
	FROM Parts
	WHERE Parts.part_number = Inventory.part_number limit 1
	);

ALTER TABLE Inventory
	ADD CONSTRAINT vendor_id
	FOREIGN KEY (vendor_id)
	REFERENCES Vendor_Info(vendor_id);

ALTER TABLE Inventory
	ADD CONSTRAINT part_id
	FOREIGN KEY (part_id)
	REFERENCES Parts(part_id);

/*Update Vendor_Part_Restock table with vendor_id and part_id*/
UPDATE Vendor_Part_Restock
SET Vendor_Part_Restock.vendor_id = (
	SELECT Vendor_Info.vendor_id
	FROM Vendor_Info
	WHERE Vendor_Info.vendor_name = Vendor_Part_Restock.vendor_name limit 1
	);

UPDATE Vendor_Part_Restock
SET Vendor_Part_Restock.part_id = (
	SELECT Parts.part_id
	FROM Parts
	WHERE Parts.part_number = Vendor_Part_Restock.part_number limit 1
	);

ALTER TABLE Vendor_Part_Restock
	ADD CONSTRAINT vendor_id2
	FOREIGN KEY (vendor_id)
	REFERENCES Vendor_Info(vendor_id);

ALTER TABLE Vendor_Part_Restock
	ADD CONSTRAINT part_id2
	FOREIGN KEY (part_id)
	REFERENCES Parts(part_id);
	