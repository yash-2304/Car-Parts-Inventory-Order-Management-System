const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2/promise');

const app = express();
app.use(bodyParser.json());

//get files from the specified directory
app.use(express.static('C:\\Users\\ddalanni\\Desktop\\project\\Project Trial and Error App'));

// Start the server
const port = 9000;
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});

// Establish MySQL connection using promise wrapper
async function establishConnection() {
  try {
    const connection = await mysql.createConnection({
      host: 'localhost',
      user: 'ddalanni',
      password: 'Nicole805!',
      database: 'project',
    });
    return connection;
  } catch (error) {
    console.error('Error establishing connection:', error);
    throw error;
  }
}


//Information brought in from HTML file:
app.post('/submit-order', async (req, res) => {
  console.log('Received request body:', req.body); 
  const connection = await establishConnection(); 
  const { buyerName, shipToName, useBuyerInfo, shippingStreet, shippingCity, shipToContact, lineItems } = req.body;
  console.log('Individual fields:', buyerName, shipToName, useBuyerInfo, shippingStreet, shippingCity, shipToContact, lineItems); 

  try {
    let shippingId;
    let orderID;
    let buyer_results = {}; 

    const sanitizedBuyerName = decodeURIComponent(buyerName);
    console.log('Sanitized Buyer Name:', sanitizedBuyerName); 

    const getBuyerInfoQuery = 'SELECT buyer_id, buyer_name, street, city, contact FROM Buyer_Info WHERE buyer_name = ?';

    const [rows, fields] = await connection.query(getBuyerInfoQuery, [sanitizedBuyerName]);
	const buyerData = rows[0]; 
	const { buyer_id, buyer_name, street, city, contact } = buyerData; 
	if (rows && rows.length > 0) {
        console.log("Buyer Name successful", buyerData.buyer_name)
        
	} else {
        // Handle case when buyer info not found
        res.status(404).send('Buyer info not found');
        return;
      }

    if (useBuyerInfo) {
      
        const createShippingQuery = 'INSERT INTO Buyer_Order_Shipping (ship_to_name, street, city, contact) VALUES (?, ?, ?, ?)';
        const createShippingValues = [buyer_name, street, city, contact];

        const createShippingResult = await connection.query(createShippingQuery, createShippingValues);
		console.log(createShippingResult);
        shippingId = createShippingResult[0].insertId;
        
    
    } else {
      // Insert shipping info for someone other than the buyer
      const createShippingQuery = 'INSERT INTO Buyer_Order_Shipping (ship_to_name, street, city, contact) VALUES (?, ?, ?, ?,)';
      const createShippingValues = [shipToName, shippingStreet, shippingCity, shipToContact];

      const createShippingResult = await connection.query(createShippingQuery, createShippingValues);
      console.log(createShippingResult);
      shippingId = createShippingResult[0].insertId;
    }
    console.log(shippingId);

    if (buyer_id) {
      const createPOQuery = 'INSERT INTO Buyer_PO (buyer_id, shipping_id) VALUES (?, ?)';
      const createPOValues = [buyerData.buyer_id, shippingId];

      const createOrderResult = await connection.query(createPOQuery, createPOValues);
	  console.log("Create Order Result: ", createOrderResult);
      orderID = createOrderResult[0].insertId;
	  console.log("Order ID: ", orderID)

      //Add line items to database table:
      for (const item of lineItems) {
        const { inventoryId, itemQuantity } = item;

        const getExtRev = 'SELECT extRev(?,?) AS extended_revenue_price';
        const getExtRevValues = [inventoryId, itemQuantity];
        const [extendedRevenue] = await connection.query(getExtRev, getExtRevValues);

        const createLineItemQuery = 'INSERT INTO Buyer_PO_Line_Items (order_id, inventory_id, quantity_ordered, extended_revenue_price) VALUES (?, ?, ?, ?)';
        const createLineItemValues = [orderID, inventoryId, itemQuantity, extendedRevenue[0].extended_revenue_price];

        await connection.query(createLineItemQuery, createLineItemValues);
		
		//update inventory quantity
		const updateInv = 'call updateInventory(?,?)';
		const updateInvValues = [inventoryId, itemQuantity];
		const updateInvResult = await connection.query(updateInv, updateInvValues);
      }
    } else {
      res.status(404).send('Buyer info not found');
      return;
    }

    res.status(200).send('Order submitted successfully!');
  } catch (error) {
    console.error('Error:', error);
    res.status(500).send('Error submitting order');
  }
});
