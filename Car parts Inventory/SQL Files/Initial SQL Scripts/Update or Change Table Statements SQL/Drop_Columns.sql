
ALTER TABLE Inventory
DROP COLUMN part_number;

ALTER TABLE Inventory
DROP COLUMN vendor_name;

ALTER TABLE Parts
DROP COLUMN part_category;

ALTER TABLE Vendor_Part_Restock
DROP COLUMN part_number;

ALTER TABLE Vendor_Part_Restock
DROP COLUMN vendor_name;