ALTER TABLE Buyer_PO_Line_Items
DROP FOREIGN KEY buyer_po_line_items_ibfk_3;

ALTER TABLE Buyer_PO_Line_Items
DROP COLUMN shipping_id;

ALTER TABLE buyer_po
ADD COLUMN shipping_id int;

ALTER TABLE buyer_po
ADD CONSTRAINT shipping_id
FOREIGN KEY (shipping_id)
REFERENCES buyer_order_shipping(shipping_id);