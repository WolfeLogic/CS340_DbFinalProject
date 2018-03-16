# CS340 Database Design  
## Final Project  
### Canyoneering Beta Database

### Description:  
Web interface allows the user to search a remotely hosted MySQL database for canyoneering routes by canyon name or number of rappels. Additionally allows users to define whether they’ve traversed a given canyon (on an Adventure Trip).

### Implementation:  
ajax  
body-parser  
bootstrap  
express  
express-handlebars  
jquery  
mysql  

### How To Run:
- **Database credentials are insecurely stored within `server.js`** Strongly consider the creation of a database config file like `dbcon.js` to hold your own database access credentials if being hosted within an unsecured environment (project was hosted behind VPN). 
- Upload the project directory intact with all associated files and subdirectories 
- Via console, navigate into the top-level project directory
- Install `package.json` by typing and hitting _enter_ after `$ npm install` (this leverages [npm](https://www.npmjs.com/) to download and install project dependent frameworks and libraries mentioned within the `package.json` file)
- If _forever_ is not already installed, type `npm install forever -g` (this might be better installed at `root`… Not sure? [npm forever package](https://www.npmjs.com/package/forever), but you run it from the project directory)
- You will need to both create and subsequently seed the database using the `create_tables.sql` and `seed.sql` files. Find details on [_Executing SQL Statements from a Text File_ here](https://dev.mysql.com/doc/refman/5.7/en/mysql-batch-commands.html).  
- Once all files have been configured for your environment (database credentials and database create/seed), run the project by typing and hitting _enter_ after `$ forever start server.js` into the console (from within the project directory)  
