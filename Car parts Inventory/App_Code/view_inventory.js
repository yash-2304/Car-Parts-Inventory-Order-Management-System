const mysql = require('mysql');

const pool = mysql.createPool({
	host: 'localhost',
	port: '3306',
	user: 'ddalanni',
	password: 'Nicole805!',
	database: 'project',
	charset: 'utf8'
});

//html string that will be send to browser
var reo ='<html><head><title>List of Parts Available for Sale</title></head><body><h1>List of Parts Available for Sale</h1>{${table}}</body></html>';

//sets and returns html table with results from sql select
//Receives sql query and callback function to return the table
function setResHtml(sql, cb){
  pool.getConnection((err, con)=>{
    if(err) throw err;

    con.query(sql, (err, res, cols)=>{
      if(err) throw err;

      var table =''; //to store html table

      //create html table with data from results of query:
      for(var i=0; i<res.length; i++){
        /*table +='<tr><td>'+ (i+1) +'</td><td>'+ res[i].part_number +'</td><td>'+ res[i].part_name +'</td><td>'+ res[i].part_description +'</td><td>'+ res[i].vendor_name +'</td><td>'+ res[i].revenue +'</td><td>'+ res[i].quantity +'</td><td>'+ res[i].part_category +'</td></tr>';*/
		table +='<tr><td>'+ res[i].inventory_id +'</td><td>'+ res[i].part_number +'</td><td>'+ res[i].part_name +'</td><td>'+ res[i].part_description +'</td><td>'+ res[i].vendor_name +'</td><td>'+ '$'+res[i].revenue +'</td><td>'+ res[i].quantity +'</td><td>'+ res[i].part_category +'</td></tr>';
	  }
      table ='<table border="1"><tr><th>Inventory ID</th><th>Part Number</th><th>Part Name</th><th>Part Description</th><th>Vendor</th><th>Part Price</th><th>Quantity Available</th><th>Category</th></tr>'+ table +'</table>';

      con.release(); //Done with mysql connection

      return cb(table);
    });
  });
}

let sql = "select * from retreiveAvailableInventory;"

//create the server for browser access
const http = require('http');
const server = http.createServer((req, res)=>{
  setResHtml(sql, resql=>{
    reo = reo.replace('{${table}}', resql);
    res.writeHead(200, {'Content-Type':'text/html; charset=utf-8'});
    res.write(reo, 'utf-8');
    res.end();
  });
});

server.listen(8080, ()=>{
  console.log('Server running at //localhost:8080/');
});