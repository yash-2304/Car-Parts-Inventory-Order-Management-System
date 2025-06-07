use project;

ALTER TABLE inventory
MODIFY unit_cost DECIMAL(10, 2);

ALTER TABLE inventory
MODIFY revenue DECIMAL(10, 2);

ALTER TABLE buyer_po_line_items
MODIFY extended_revenue_price DECIMAL(10, 2);