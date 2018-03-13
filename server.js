/******************************************************************************
* Course: Oregon State University CS 340-400 Spring 2017
* Program: Final Project, Canyoneering Beta Db
* Author: Drew Wolfe
* Description: 
*
* FILE: server.js
*  
* 
*  
* 
******************************************************************************/
var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var pool = mysql.createPool({
	host: 'localhost',
	user: process.env.DBUSER,
	password: process.env.DBPASS,
	database: process.env.DBNAME
});

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout: 'main'});

app.engine('handlebars', handlebars.engine);
app.set('view engine', 'handlebars');
app.set('port', 3000);
app.use(bodyParser.urlencoded({extended: false}));
app.use(bodyParser.json());
app.use(express.static('public'));

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

app.get('/actors', function(req, res) {
  selectTableData(res, 'actor');
});

app.get('/episodes', function(req, res) {
  selectTableData(res, 'episode');
});

app.get('/studios', function(req, res) {
  selectTableData(res, 'studio');
});

app.get('/series', function(req, res) {
  selectTableData(res, 'series');
});

app.get('/characters', function(req, res) {
  selectTableData(res, 'st_character');
});

app.get('/actor_character', function(req, res) {
  selectTableData(res, 'actor_character');
});

app.get('/actor_series', function(req, res) {
  selectTableData(res, 'actor_series');
});

app.get('/character_episode', function(req, res) {
  selectTableData(res, 'character_episode');
});

app.post('/search_character_episode', function(req, res) {
  var ctx = {};
  var body = req.body;
  var queryStr = "SELECT st_character.fname, st_character.lname FROM st_character ";
  queryStr += 'INNER JOIN character_episode ON st_character.id = character_episode.character_id ';
  queryStr += 'INNER JOIN episode ON episode.id = character_episode.episode_id';
  queryStr += ' WHERE episode.title = "' + body.title + '";';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = rows;
    res.send(ctx);
  });
});

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

app.post('/actors', function(req, res) {
  updateEntry(req, res, 'actor');
});

app.post('/characters', function(req, res) {
  updateEntry(req, res, 'st_character');
});

app.post('/episodes', function(req, res) {
  updateEntry(req, res, 'episode');
});

app.post('/series', function(req, res) {
  updateEntry(req, res, 'series');
});

app.post('/studios', function(req, res) {
  updateEntry(req, res, 'studio');
});

app.post('/actor_character', function(req, res) {
  updateEntry(req, res, 'actor_character');
});

app.post('/actor_series', function(req, res) {
  updateEntry(req, res, 'actor_series');
});

app.post('/character_episode', function(req, res) {
  updateEntry(req, res, 'character_episode');
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

app.delete('/actors', function(req, res) {
  deleteEntry(req, res, 'actor');
});

app.delete('/characters', function(req, res) {
  deleteEntry(req, res, 'st_character');
});

app.delete('/studios', function(req, res) {
  deleteEntry(req, res, 'studio');
});

app.delete('/episodes', function(req, res) {
  deleteEntry(req, res, 'episode');
});

app.delete('/series', function(req, res) {
  deleteEntry(req, res, 'series');
});

app.delete('/actor_series', function(req, res) {
  var ctx = {};
  var body = req.body;
  var actor_id = body.actor_id;
  var series_id = body.series_id;

  var queryStr = 'DELETE FROM actor_series WHERE actor_id = ' + actor_id;
  queryStr += ' AND series_id = ' + series_id + ';';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
});

app.delete('/actor_character', function(req, res) {
  var ctx = {};
  var body = req.body;
  var actor_id = body.actor_id;
  var character_id = body.character_id;

  var queryStr = 'DELETE FROM actor_character WHERE actor_id = ' + actor_id;
  queryStr += ' AND character_id = ' + character_id + ';';

  pool.query(queryStr, function(err, rows, fields) {
    if (err) {
      console.log(err);
      return;
    }
    ctx.results = JSON.stringify(rows);
    res.send(ctx);
  });
});

app.delete('/character_episode', function(req, res) {
  var ctx = {};
  var body = req.body;
  var character_id = body.character_id;
  var episode_id = body.episode_id;

  var queryStr = 'DELETE FROM character_episode WHERE character_id = ' + character_id;
  queryStr += ' AND episode_id = ' + episode_id + ';';

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

