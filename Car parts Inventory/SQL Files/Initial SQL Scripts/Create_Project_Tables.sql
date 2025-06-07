use project;

/*Create Part_Category table:*/
CREATE TABLE Part_Category(
	category_id int NOT NULL auto_increment,
	part_category varchar(30),
	
	PRIMARY Key (category_id)
	)engine=innodb;
	
/*Create Parts table. Will update table to assign/have not null foreign key on category_id AFTER initial data load
 from sheets has been imported, foreign key info has been inserted, and category name table has been removed.:*/

CREATE TABLE Parts(
	part_id int NOT NULL auto_increment,
	part_number int NOT NULL,
	part_name varchar(50),
	part_description varchar(300),
	category_id int,
	part_category varchar(30),
	
	PRIMARY KEY (part_id)
	)engine=innodb;
	
/* Create Vendor_Info table:*/
CREATE TABLE Vendor_Info(
	vendor_id int NOT NULL auto_increment,
	vendor_name varchar(200) NOT null,
	street varchar(100),
	city varchar(50),
	contact varchar(50),
	
	PRIMARY KEY (vendor_id)
	)engine=innodb;

/*Create Vendor_Return table: */
CREATE TABLE Vendor_Return(
	return_id int NOT NULL auto_increment,
	return_received boolean NOT NULL,
	store_credit boolean default false,
	refund_check boolean default false,
	
	PRIMARY KEY (return_id)
	)engine=innodb;
	
/*Create Shipping_Status table:*/
CREATE TABLE Shipping_Status(
	shipping_status_id int NOT NULL auto_increment,
	shipping_status char(9) NOT NULL,
	
	PRIMARY KEY (shipping_status_id)
	)engine=innodb;
	
/*Create Inventory table. Will update table to assign/have not null foreign keys AFTER initial data load from
sheets has been imported, foreign key info has been inserted, and part_number and vendor_name columns
have been removed:*/
CREATE TABLE Inventory(
	inventory_id int NOT NULL auto_increment,
	vendor_id int,
	part_id int,
	unit_cost decimal,
	quantity int,
	revenue decimal,
	part_number int,
	vendor_name varchar(400),
	
	PRIMARY KEY (inventory_id)
	)engine=innodb;

/*Create Vendor_Part_Restock table. Will update table to assign/have not null foreign keys AFTER initial data load from
sheets has been imported, foreign key info has been inserted, and part_number and vendor_name columns
have been removed:*/
CREATE TABLE Vendor_Part_Restock(
	restock_id int NOT NULL auto_increment,
	part_id int,
    part_number varchar(50),
	vendor_id int,
    vendor_name varchar(200),
	restock_quantity int NOT NULL,
	purchase_status boolean default false,
	received boolean default false,
	tracking_number int,
	
	PRIMARY KEY (restock_id)
	)engine=innodb;

/*Create Vendor_Return_Line_Items table:*/
CREATE TABLE Vendor_Return_Line_Items(
	return_line_id int NOT NULL auto_increment,
	vendor_return_id int NOT NULL,
	restock_id int NOT NULL,
	quantity_returned int NOT NULL,
	damaged boolean default false,
	defective boolean default false,
	comments varchar(500),
	
	PRIMARY KEY(return_line_id),
	FOREIGN KEY (vendor_return_id) REFERENCES Vendor_Return(return_id),
	FOREIGN KEY (restock_id) REFERENCES  Vendor_Part_Restock(restock_id)
	)engine=innodb;
	
/*Create Buyer_Order_Shipping table:*/
CREATE TABLE Buyer_Order_Shipping(
    shipping_id int NOT NULL auto_increment,
    ship_to_name varchar(200),
    street varchar(100),
    city varchar(50),
    contact varchar(50),
    tracking_number varchar(30),
    shipping_status_id int,
    
    PRIMARY KEY(shipping_id),
    FOREIGN KEY (shipping_status_id) REFERENCES Shipping_Status(shipping_status_id)
    )engine=innodb;
    
/*Create Buyer_Info table:*/
CREATE TABLE Buyer_Info(
    buyer_id int NOT NULL auto_increment,
    buyer_name varchar(200),
    street varchar(100),
    city varchar(50),
    contact varchar(50),
    
    PRIMARY KEY(buyer_id)
    )engine=innodb;

/*Create Buyer_PO table:*/
CREATE TABLE Buyer_PO(
    order_id int NOT NULL auto_increment,
    buyer_id int NOT NULL,
    payment_status boolean default false,
    order_status boolean default false,
    warranty_start_date date,
    
    PRIMARY KEY(order_id),
    FOREIGN KEY (buyer_id) REFERENCES Buyer_Info(buyer_id)
    )engine=innodb;

/*Create Buyer_PO_Line_Items table:*/
CREATE TABLE Buyer_PO_Line_Items(
    line_item_id int NOT NULL auto_increment,
    order_id int NOT NULL,
    inventory_id int NOT NULL,
    shipping_id int,
    customer_rating int,
    quantity_ordered int NOT NULL,
    extended_revenue_price decimal,
    
    PRIMARY KEY (line_item_id),
    FOREIGN KEY (order_id) REFERENCES Buyer_PO(order_id),
    FOREIGN KEY (inventory_id) REFERENCES Inventory(inventory_id),
    FOREIGN KEY (shipping_id) REFERENCES Buyer_Order_Shipping(shipping_id)
    )engine=innodb;
    
/*Create Buyer_Return table: */
CREATE TABLE Buyer_Return(
	buyer_return_id int NOT NULL auto_increment,
	return_received boolean NOT NULL,
	store_credit boolean default false,
	refund_check boolean default false,
	
	PRIMARY KEY (buyer_return_id)
	)engine=innodb;

/*Create Buyer_Return_Line_Items table:*/
CREATE TABLE Buyer_Return_Line_Items(
	return_line_id int NOT NULL auto_increment,
	buyer_return_id int NOT NULL,
	line_item_id int NOT NULL,
	quantity_returned int NOT NULL,
	damaged boolean default false,
	defective boolean default false,
	comments varchar(500),
    
    PRIMARY KEY(return_line_id),
	FOREIGN KEY (buyer_return_id) REFERENCES Buyer_Return(buyer_return_id),
	FOREIGN KEY (line_item_id) REFERENCES  Buyer_PO_Line_Items(line_item_id)
	)engine=innodb;
    

    

    
	
	
	
	
	
	
	
	