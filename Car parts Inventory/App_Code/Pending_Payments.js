const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const path = require('path');

const app = express();
const port = 3000;

app.use(bodyParser.json());


//connecting to the db
const dbConfig = {
    host: 'localhost',
    user: 'ddalanni',
    port: '3306',
    password: 'Nicole805!',
    database: 'project'
};

const connection = mysql.createConnection(dbConfig);

connection.connect(err => {
    if (err) {
        console.error('Error connecting to database:', err);
        return;
    }
    console.log('Connected to MySQL database');
});

//get order information and payment status from view that combines buyer information with po information:
app.get('/Pending_Payments/:orderId', (req, res) => {
    const orderId = req.params.orderId;

    const query = `SELECT * FROM pendingPayments WHERE order_id = ${orderId}`;
    connection.query(query, (err, row) => {
        if (err) {
            console.error('Error fetching pendingPayments:', err);
            res.status(500).send('Error fetching Buyer_PO data');
            return;
        }
        res.json(row[0]); // Assuming only one row is expected
    });
});

//update Buyer_Po table payment status

app.put('/updatePaymentStatus/:orderId', (req, res) => {
    const orderId = req.params.orderId;
    const { status } = req.body;

    const updateQuery = `UPDATE buyer_po SET payment_status = ${status} WHERE order_id = ${orderId}`;
    connection.query(updateQuery, (updateErr, updateResult) => {
        if (updateErr) {
            console.error('Error updating payment status:', updateErr);
            res.status(500).json({ success: false, message: 'Error updating payment status' });
            return;
        }
//update shipping status:
        const shippingQuery = `CALL changeShippingStatus(1, ${orderId})`;
        connection.query(shippingQuery, (shippingErr, shippingResult) => {
            if (shippingErr) {
                console.error('Error updating shipping status:', shippingErr);
                res.status(500).json({ success: false, message: 'Error updating shipping status' });
                return;
            }

            res.json({ success: true, message: 'Payment and shipping statuses updated successfully' });
        });
    });
});

app.get('/Update_Payment_Made.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'Update_Payment_Made.html'));
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});
