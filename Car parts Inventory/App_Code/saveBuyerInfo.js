const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');

const app = express();
app.use(bodyParser.json());

// Serve static files from the specified directory
app.use(express.static('C:\\Users\\ddalanni\\Desktop\\project\\Project Trial and Error App'));

// Start the server
app.listen(3000, () => {
  console.log('Server is running on port 3000');
});

const connection = mysql.createConnection({
  host: 'localhost',
  user: 'ddalanni',
  password: 'Nicole805!',
  database: 'project',
});

app.post('/saveBuyerInfo', (req, res) => {
  const { buyer_name, street, city, contact } = req.body;
  const checkQuery = 'SELECT * FROM Buyer_Info WHERE buyer_name = ?';
  const insertQuery = 'CALL createBuyer(?, ?, ?, ?)';

  // Check if the buyer already exists
  connection.query(checkQuery, [buyer_name], (error, results, fields) => {
    if (error) {
      console.error('Error checking data:', error);
      res.status(500).send('Error checking data');
      return;
    }

    if (results.length > 0) {
      console.log('Buyer already exists');
      res.status(200).send('Buyer already exists');
    } else {
      // If the buyer doesn't exist, insert new data
      connection.query(insertQuery, [buyer_name, street, city, contact], (insertError, insertResults) => {
        if (insertError) {
          console.error('Error inserting data:', insertError);
          res.status(500).send('Error inserting data');
          return;
        }
        console.log('Data inserted successfully');
        res.status(200).send('Data inserted successfully');
      });
    }
  });
});


//url: http://localhost:3000/Create_New_Buyer.html