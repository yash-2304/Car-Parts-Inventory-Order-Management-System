# 📦Car parts Inventory & Order Management System

This project is a complete **relational database system** designed for managing inventory, purchase orders, returns, and logistics between vendors and buyers. The schema is normalized and includes over 12 interconnected entities that simulate a real-world parts distribution and restocking environment.

---

## 📌 Domain
**Domain**: Supply Chain / Parts Inventory Management

---

## 🎯 Business Need
Companies that handle mechanical/electrical parts often face challenges in tracking vendor restocks, managing inventory, processing buyer orders, and handling returns efficiently. This database solves these challenges by integrating all workflows into a centralized system.

---

## 🧱 Entity Overview (15+ Entities)
- **Part_Category**: Classification for each part (e.g., electronics, hardware)
- **Parts**: Core entity representing inventory items
- **Inventory**: Tracks quantity, cost, revenue for parts
- **Vendor_Info**: Stores vendor contact and address info
- **Vendor_Part_Restock**: Handles restocking requests with tracking and quantity
- **Vendor_Return**: Manages return types (store credit, refund, etc.)
- **Vendor_Return_Line_Items**: Return details (quantity, condition, comments)
- **Buyer_Info**: Stores buyer identity and contact info
- **Buyer_PO**: Tracks buyer purchase orders with status and warranty
- **Buyer_PO_Line_Items**: Line-level detail of purchases and ratings
- **Buyer_Return**: Return type and resolution
- **Buyer_Return_Line_Items**: Line-level info for returned parts
- **Buyer_Order_Shipping**: Shipping details, tracking, and status
- **Shipping_Status**: Defines shipment progress states

---

## ⚙️ Attributes Sample
Each entity includes meaningful attributes like:
- `part_number`, `part_description`, `category_id` for **Parts**
- `unit_cost`, `quantity`, `revenue` for **Inventory**
- `restock_quantity`, `purchase_status`, `tracking_number` for **Vendor_Part_Restock**
- `customer_rating`, `extended_revenue_price` for **Buyer_PO_Line_Items**

---

## 📏 Business Rules (examples)
- A **Part** belongs to a **Category** but can be restocked by multiple **Vendors**
- Each **Inventory** record must reference a **Vendor** and a **Part**
- Each **Buyer_PO** must include line items referencing **Inventory**
- A **Return** can involve multiple line items and conditions (damaged, defective)
- **Shipping_Status** must be assigned to each **Shipping** record

---

## 📈 Sample Reports & Queries
- Top 10 most restocked parts
- Parts with highest buyer ratings
- Monthly revenue by part category
- Vendor performance by delivery status
- Average return quantity by vendor and buyer
- Orders pending shipment by shipping status
- Buyer with most returns per quarter
- Inventory aging report (low turnover parts)

---

## 🗃️ Database Structure & Scripts
- **DDL**: Full SQL schema with constraints, PKs, FKs, indexing
- **DML**:
  - Views: Inventory snapshot, buyer order summary, vendor return status, etc.
  - Stored Procedures: Create new PO, generate return reports, revenue calculations
  - Triggers: Auto-calculate revenue, enforce return limits

---

## 🖥️ CRUD System Integration
Basic forms or scripts allow insertion, editing, deletion of:
- Part and inventory records
- Buyer/vendor info
- Order and shipping statuses

---


## 📄 License
This database project is released under the MIT License.

---

Designed to model complex parts logistics, inventory control, and buyer-vendor interactions efficiently and accurately.
