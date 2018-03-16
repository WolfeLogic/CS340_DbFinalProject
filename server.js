// *****************************************************************************
// * Course: Oregon State University CS 340-400 Spring 2017
// * Program: Final Project, Canyoneering Beta Db
// * Author: Drew Wolfe
// * FILE: server.js
// *****************************************************************************
var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_wolfedr',
  password        : '0131',
  database        : 'cs340_wolfedr'
});

// var mysql = require('./dbcon.js');
// var pool = mysql.createPool({
// 	host: 'oniddb.cws.oregonstate.edu',
// 	user: 'wolfedr-db',
// 	password: '*********',
// 	database: 'wolfedr-db'
// });

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout: 'main'});

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 50362);

app.use(express.static(path.join(__dirname, 'public')));
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());

// app.use('/static', express.static(path.join(__dirname, 'public')))
// app.use(express.static('public'));

app.get('/', function(req, res) {
	res.render('home');
});

var selectTableData = function(res, table) {
  var ctx = {};
  pool.query('SELECT * FROM ' + table, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = rows;
    res.send(ctx);
  });
};

app.get('/trips', function(req, res) {
  selectTableData(res, 'trip');
});

app.get('/rappels', function(req, res) {
  selectTableData(res, 'rappel');
});

app.get('/canyons', function(req, res) {
  selectTableData(res, 'canyon');
});

app.get('/routes', function(req, res) {
  selectTableData(res, 'route');
});

app.get('/adventurers', function(req, res) {
  selectTableData(res, 'adventurer');
});

app.get('/advent_trip', function(req, res) {
  selectTableData(res, 'advent_trip');
});

app.get('/trip_route', function(req, res) {
  selectTableData(res, 'trip_route');
});

app.get('/advent_rappel', function(req, res) {
  selectTableData(res, 'advent_rappel');
});

app.get('/route_canyon', function(req, res) {
  selectTableData(res, 'route_canyon');
});

app.post('/search_route_canyon', function(req, res) {
  var ctx = {};
  var body = req.body;
  var queryStr = "SELECT route.title, route.aca_rating FROM route ";
  queryStr += 'INNER JOIN route_canyon ON route.id = route_canyon.route_id ';
  queryStr += 'INNER JOIN canyon ON canyon.id = route_canyon.canyon_id';
  queryStr += 'WHERE canyon.name = "' + body.name + '";';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = rows;
    res.send(ctx);
  });
});

// app.post('/search_advent_rappel', function(req, res) {
//   var ctx = {};
//   var body = req.body;
//   var queryStr = "SELECT adventurer.fname, adventurer.lname FROM adventurer ";
//   queryStr += 'INNER JOIN advent_rappel ON adventurer.id = advent_rappel.adventurer_id ';
//   queryStr += 'INNER JOIN rappel ON rappel.id = advent_rappel.rappel_id';
//   queryStr += ' WHERE rappel.title = "' + body.title + '";';

//   pool.query(queryStr, function(err, rows, fields) {
//     if (err) {
//       console.log(err);
//       return;
//     }
//     ctx.results = rows;
//     res.send(ctx);
//   });
// });

var generateUpdateStr = function(body, table) {
  var keys = [];
  var values = [];
  var str = '';
  for (var key in body) {
    keys.push(key);
    values.push("'" + body[key] + "'");
  }
  str += "INSERT INTO " + table;
  str += "(" + keys.join(",") + ")";
  str += " VALUES (" + values.join(",") + ");";

  return str;
};

var updateEntry = function(req, res, table) {
  var updateStr = generateUpdateStr(req.body, table);

  pool.query(updateStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    res.send(JSON.stringify(rows));
  });
};

app.post('/trips', function(req, res) {
  updateEntry(req, res, 'trip');
});

app.post('/adventurers', function(req, res) {
  updateEntry(req, res, 'adventurer');
});

app.post('/rappels', function(req, res) {
  updateEntry(req, res, 'rappel');
});

app.post('/routes', function(req, res) {
  updateEntry(req, res, 'route');
});

app.post('/canyons', function(req, res) {
  updateEntry(req, res, 'canyon');
});

app.post('/advent_trip', function(req, res) {
  updateEntry(req, res, 'advent_trip');
});

app.post('/trip_route', function(req, res) {
  updateEntry(req, res, 'trip_route');
});

app.post('/advent_rappel', function(req, res) {
  updateEntry(req, res, 'advent_rappel');
});

app.post('/route_canyon', function(req, res) {
  updateEntry(req, res, 'route_canyon');
});

var deleteEntry = function(req, res, table) {
  var ctx = {};
  var id = req.body.id;
  pool.query('DELETE FROM ' + table + ' WHERE id = ' + id, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
};

app.delete('/trips', function(req, res) {
  deleteEntry(req, res, 'trip');
});

app.delete('/adventurers', function(req, res) {
  deleteEntry(req, res, 'adventurer');
});

app.delete('/canyons', function(req, res) {
  deleteEntry(req, res, 'canyon');
});

app.delete('/rappels', function(req, res) {
  deleteEntry(req, res, 'rappel');
});

app.delete('/routes', function(req, res) {
  deleteEntry(req, res, 'route');
});

app.delete('/trip_route', function(req, res) {
  var ctx = {};
  var body = req.body;
  var trip_id = body.trip_id;
  var route_id = body.route_id;

  var queryStr = 'DELETE FROM trip_route WHERE trip_id = ' + trip_id;
  queryStr += ' AND route_id = ' + route_id + ';';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
});

app.delete('/advent_trip', function(req, res) {
  var ctx = {};
  var body = req.body;
  var trip_id = body.trip_id;
  var adventurer_id = body.adventurer_id;

  var queryStr = 'DELETE FROM advent_trip WHERE trip_id = ' + trip_id;
  queryStr += ' AND adventurer_id = ' + adventurer_id + ';';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
});

app.delete('/advent_rappel', function(req, res) {
  var ctx = {};
  var body = req.body;
  var adventurer_id = body.adventurer_id;
  var rappel_id = body.rappel_id;

  var queryStr = 'DELETE FROM advent_rappel WHERE adventurer_id = ' + adventurer_id;
  queryStr += ' AND rappel_id = ' + rappel_id + ';';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
});

app.delete('/route_canyon', function(req, res) {
  var ctx = {};
  var body = req.body;
  var route_id = body.route_id;
  var canyon_id = body.canyon_id;

  var queryStr = 'DELETE FROM route_canyon WHERE route_id = ' + route_id;
  queryStr += ' AND canyon_id = ' + canyon_id + ';';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
});

app.use(function(req, res) {
	res.status(404);
	res.render('404');
});

app.use(function(err, req, res, next){
	console.log(err.stack);
	res.status(500);
	res.render('500');
});

app.listen(app.get('port'), function() {
	console.log('Application started on port ' + app.get('port'));
});