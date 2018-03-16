/******************************************************************************
* Course: Oregon State University CS 340-400 Spring 2017
* Program: Final Project, Canyoneering Beta Db
* Author: Drew Wolfe
* FILE: seed.sql
******************************************************************************/

/*
 * The statements below are used to prepopulate the canyoneering database with data
*/

/*
 * Prepopulating the table trip with Canyoneering trips
*/

INSERT INTO trip (adventName, adventDate, aca_rating, weather)
VALUES ("1Eyed Willy's Wonky Canyon", '2014-07-11', "3-C3 II R", "hot and dry"),
       ("Don't Think Twice Twilight Canyon", '2017-04-23', "S2-A III", "chilly but dry"),
       ("Going Bananas for Monkey Face Canyon", '2015-09-18', "4-A V", "too hot and dry"),
       ("Coffee and Bailey Canyon", '2016-02-03', "3-B PG IV", "cool, but not cold"),
       ("Sprint Through Vishnu Canyon", '2010-06-28', "S4-A XX III", NULL),
       ("Hall Beckley in May", '2007-05-08', "S3-C2 II", "warm, a little rain"),
       ("SF Ladies Take on Rough Tooth Melee", '2017-06-08', NULL, "nice and warm");
/*
 * Prepopulating the table adventurer with Canyoneering adventurers
*/

INSERT INTO adventurer (fname, lname, username)
VALUES ("Harris", "Channing", "HackJobHarry"),
       ("Doug", "Filburn", "Burninator"),
       ("Alice", "Combs", "Ace89"),
       ("Philip", "Sorgin", "Trogdor"),
       ("Katie", "Lodegren", "SBForever"),
       ("Jake", "Housin", "DaCheat"),
       ("Kristen", "Grestat", "LongRappGrestat");

/*
 * Prepopulating the table canyon with Canyoneering canyons
*/

INSERT INTO canyon (name, state, region)
VALUES ("Willy's Canyon", "Utah", "Four Corners"),
       ("Twilight Canyon", "Colorado", "Four Corners"),
       ("Monkey Face Canyon", "California", "SoCal"),
       ("Bailey Canyon", "California", "SoCal"),
       ("Hall Beckley", "California", "SoCal"),
       ("Rough Tooth Canyon", "California", "Death Valley"),
       ("Vishnu Canyon", "Oregon", "Coastal Range");

/*
 * Prepopulating the table route with Canyoneering routes
*/

INSERT INTO route (title, start_point, end_point, aca_rating, num_rappel, canyon_id)
VALUES ("Willy's Mean Green", NULL, NULL, "3-C3 II", 9, (SELECT id FROM canyon WHERE name = "Willy's Canyon")),
       ("Vampire Slog", NULL, NULL, "S2-A III", 13, (SELECT id FROM canyon WHERE name = "Twilight Canyon")),
       ("Banana Slide Route", "34.0998, -116.9529", NULL, "4-A V", 11, (SELECT id FROM canyon WHERE name = "Monkey Face Canyon")),
       ("Irish Route", "34 10.26'N 118 3.67'W", NULL, "3-B PG IV", 12, (SELECT id FROM canyon WHERE name = "Bailey Canyon")),
       ("Elephant Stomp", NULL, NULL, "S4-A XX III", 11, (SELECT id FROM canyon WHERE name = "Vishnu Canyon")),
       ("Dentist's Nightmare", NULL, NULL, "3A III", 8, (SELECT id FROM canyon WHERE name = "Rough Tooth Canyon")),
       ("Hall or Nothing", "34 15.62'N 118 11.54'W", NULL, "3B III", 7, (SELECT id FROM canyon WHERE name = "Hall Beckley")),
       ("Monkey Business", "34 17.82'N 118 10.20'W", NULL, "3BR IV", 14, (SELECT id FROM canyon WHERE name = "Monkey Face Canyon")),
       ("Twilight Abridged", NULL, NULL, "S2-A III", 7, (SELECT id FROM canyon WHERE name = "Twilight Canyon"));

/*
 * Prepopulating the table rappel with some Canyoneering rappels
*/

INSERT INTO rappel (title, rappel_length_ft, difficulty_note, anchr_type, route_id)
VALUES ("Algenon's Dive", 180, "long, dry, vertical", "webbing on tree", (SELECT id FROM route WHERE title = "Willy's Mean Green")),
       ("Kersplat", 215, "50' free-rappel", "two bolts. Solid", (SELECT id FROM route WHERE title = "Vampire Slog")),
       ("Number 9", 110, "Nasty start", "dead-man", (SELECT id FROM route WHERE title = "Vampire Slog")),
       ("Wha?!", 280, "long with redirect", NULL, (SELECT id FROM route WHERE title = "Banana Slide Route")),
       ("Nope", 65, "swift water landing", "tree with webbing", (SELECT id FROM route WHERE title = "Irish Route")),
       ("Mice Drop", 90, "loose rocks at anchor", "two bolts", (SELECT id FROM route WHERE title = "Elephant Stomp")),
       ("SWW", 80, "slippery when wet", "piton and chockstone on webbing", (SELECT id FROM route WHERE title = "Twilight Abridged"));

/*
 * Prepopulating the trip_route table to relate trips to Canyoneering routes 
*/

INSERT INTO trip_route (trip_id, route_id)
VALUES ((SELECT id FROM trip WHERE adventName = "1Eyed Willy's Wonky Canyon" AND adventDate = '2014-07-11'),
              (SELECT id FROM route WHERE title = "Vampire Slog")),
       ((SELECT id FROM trip WHERE adventName = "1Eyed Willy's Wonky Canyon" AND adventDate = '2014-07-11'),
              (SELECT id FROM route WHERE title = "Twilight Abridged")),
       ((SELECT id FROM trip WHERE adventName = "Don't Think Twice Twilight Canyon" AND adventDate = '2017-04-23'),
              (SELECT id FROM route WHERE title = "Willy's Mean Green")),
       ((SELECT id FROM trip WHERE adventName = "Going Bananas for Monkey Face Canyon" AND adventDate = '2015-09-18'),
              (SELECT id FROM route WHERE title = "Vampire Slog")),
       ((SELECT id FROM trip WHERE adventName = "Going Bananas for Monkey Face Canyon" AND adventDate = '2015-09-18'),
              (SELECT id FROM route WHERE title = "Twilight Abridged")),
       ((SELECT id FROM trip WHERE adventName = "Coffee and Bailey Canyon" AND adventDate = '2016-02-03'),
              (SELECT id FROM route WHERE title = "Vampire Slog")),
       ((SELECT id FROM trip WHERE adventName = "Coffee and Bailey Canyon" AND adventDate = '2016-02-03'),
              (SELECT id FROM route WHERE title = "Twilight Abridged")),
       ((SELECT id FROM trip WHERE adventName = "SF Ladies Take on Rough Tooth Melee" AND adventDate = '2017-06-08'),
              (SELECT id FROM route WHERE title = "Willy's Mean Green")),
       ((SELECT id FROM trip WHERE adventName = "Sprint Through Vishnu Canyon" AND adventDate = '2010-06-28'),
              (SELECT id FROM route WHERE title = "Vampire Slog")),
       ((SELECT id FROM trip WHERE adventName = "Hall Beckley in May" AND adventDate = '2007-05-08'),
              (SELECT id FROm route WHERE title = "Banana Slide Route"));

/*
 * Prepopulating the advent_trip table to relate trips to Canyoneering adventurers
*/

INSERT INTO advent_trip (trip_id, adventurer_id)
VALUES ((SELECT id FROM trip WHERE adventName = "1Eyed Willy's Wonky Canyon" AND adventDate = '2014-07-11'),
              (SELECT id FROM adventurer WHERE fname = "Harris" AND lname = "Channing")),
       ((SELECT id FROM trip WHERE adventName = "Don't Think Twice Twilight Canyon" AND adventDate = '2017-04-23'),
              (SELECT id FROM adventurer WHERE fname = "Doug")),
       ((SELECT id FROM trip WHERE adventName = "Going Bananas for Monkey Face Canyon" AND adventDate = '2015-09-18'),
              (SELECT id FROM adventurer WHERE fname = "Kristen")),
       ((SELECT id FROM trip WHERE adventName = "Coffee and Bailey Canyon" AND adventDate = '2016-02-03'),
              (SELECT id FROM adventurer WHERE fname = "Jake" AND lname = "Housin")),
       ((SELECT id FROM trip WHERE adventName = "Sprint Through Vishnu Canyon" AND adventDate = '2010-06-28'),
              (SELECT id FROM adventurer WHERE fname = "Katie")),
       ((SELECT id FROM trip WHERE adventName = "Hall Beckley in May" AND adventDate = '2007-05-08'), 
              (SELECT id FROM adventurer WHERE fname = "Philip" AND lname = "Sorgin")),
       ((SELECT id FROM trip WHERE adventName = "SF Ladies Take on Rough Tooth Melee" AND adventDate = '2017-06-08'),
              (SELECT id FROM adventurer WHERE fname = "Alice" AND lname = "Combs"));

/*
 * Prepopulating the advent_rappel table to relate Canyoneering adventurers to rappels
 * they have descended
*/

INSERT INTO advent_rappel (adventurer_id, rappel_id)
VALUES ((SELECT id FROM adventurer WHERE fname = "Harris" AND lname = "Channing"),
              (SELECT id FROM rappel WHERE title = "Number 9")),
       ((SELECT id FROM adventurer WHERE fname = "Katie"),
              (SELECT id FROM rappel WHERE title = "Number 9")),
       ((SELECT id FROM adventurer WHERE fname = "Katie"),
              (SELECT id FROM rappel WHERE title = "Kersplat")),
       ((SELECT id FROM adventurer WHERE fname = "Harris" AND lname = "Channing"),
              (SELECT id FROM rappel WHERE title = "Kersplat")),
       ((SELECT id FROM adventurer WHERE fname = "Kristen"),
              (SELECT id FROM rappel WHERE title = "Kersplat")),
       ((SELECT id FROM adventurer WHERE fname = "Kristen"),
              (SELECT id FROM rappel WHERE title = "Number 9")),
       ((SELECT id FROM adventurer WHERE fname = "Kristen"),
              (SELECT id FROM rappel WHERE title = "SWW")),
       ((SELECT id FROM adventurer WHERE fname = "Jake" AND lname = "Housin"),
              (SELECT id FROM rappel WHERE title = "Kersplat")),
       ((SELECT id FROM adventurer WHERE fname = "Jake" AND lname = "Housin"),
              (SELECT id FROM rappel WHERE title = "Number 9")),
       ((SELECT id FROM adventurer WHERE fname = "Jake" AND lname = "Housin"),
              (SELECT id FROM rappel WHERE title = "SWW")),
       ((SELECT id FROM adventurer WHERE fname = "Philip" AND lname = "Sorgin"),
              (SELECT id FROM rappel WHERE title = "Wha?!")),
       ((SELECT id FROM adventurer WHERE fname = "Alice" AND lname = "Combs"),
              (SELECT id FROM rappel WHERE title = "Algenon's Dive")),
       ((SELECT id FROM adventurer WHERE fname = "Doug"),
              (SELECT id FROM rappel WHERE title = "Algenon's Dive"));

/*
 * Prepopulating the route_canyon table to relate routes to their canyons
*/

INSERT INTO route_canyon (route_id, canyon_id)
VALUES ((SELECT id FROM route WHERE title = "Willy's Mean Green"),
              (SELECT id FROM canyon WHERE name = "Willy's Canyon")),
       ((SELECT id FROM route WHERE title = "Vampire Slog"),
              (SELECT id FROM canyon WHERE name = "Twilight Canyon")),
       ((SELECT id FROM route WHERE title = "Banana Slide Route"),
              (SELECT id FROM canyon WHERE name = "Monkey Face Canyon")),
       ((SELECT id FROM route WHERE title = "Irish Route"),
              (SELECT id FROM canyon WHERE name = "Bailey Canyon")),
       ((SELECT id FROM route WHERE title = "Elephant Stomp"),
              (SELECT id FROM canyon WHERE name = "Vishnu Canyon")),
       ((SELECT id FROM route WHERE title = "Twilight Abridged"),
              (SELECT id FROM canyon WHERE name = "Twilight Canyon")),
       ((SELECT id FROM route WHERE title = "Dentist's Nightmare"),
              (SELECT id FROM canyon WHERE name = "Rough Tooth Canyon")),
       ((SELECT id FROM route WHERE title = "Hall or Nothing"),
              (SELECT id FROM canyon WHERE name = "Hall Beckley")),
       ((SELECT id FROM route WHERE title = "Monkey Business"),
              (SELECT id FROM canyon WHERE name = "Monkey Face Canyon"));
