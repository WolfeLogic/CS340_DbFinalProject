/******************************************************************************
* Course: Oregon State University CS 340-400 Spring 2017
* Program: Final Project, Canyoneering Beta Db
* Author: Drew Wolfe
* Description: 
*
* FILE: seed.sql
*  
* 
*  
* 
******************************************************************************/

/*
 * The statements below are used to prepopulate the star_trek database with data
*/

/*
 * Prepopulating the table actor with Star Trek actors
*/

INSERT INTO actor (fname, lname, website, twitter)
VALUES ("Patrick", "Stewart", NULL, "@SirPatStew"),
       ("Leonard", "Nimoy", "https://www.shopllap.com", "@TheRealNimoy"),
       ("William", "Shatner", "http://www.williamshatner.com", "@WilliamShatner"),
       ("Kate", "Mulgrew", "http://totallykate.com", "@TheKateMulgrew"),
       ("Brent", "Spiner", "http://www.therealbrentspiner.com", "@BrentSpiner"),
       ("Colm", "Meaney", NULL, NULL),
       ("Michael", "Dorn", NULL, "@akaWorf");
/*
 * Prepopulating the table st_character with Star Trek characters
*/

INSERT INTO st_character (fname, lname, race)
VALUES ("Jean Luc", "Picard", "Human"),
       ("Spock", NULL, "Vulcan"),
       ("James", "Kirk", "Human"),
       ("Katherine", "Janeway", "Human"),
       ("Data", NULL, "Android"),
       ("Miles", "O'Brien", "Human"),
       ("Worf", NULL, "Klingon");

/*
 * Prepopulating the table studio with studios used in Star Trek productions
*/

INSERT INTO studio (name, address, website)
VALUES ("Desilu Productions", "Los Angeles, CA", NULL),
       ("Paramount Domestic Television", "5555 Melrose Avenue, Hollywood, CA, 90038", "http://www.paramountstudios.com/"),
       ("Paramount Network Television", "5555 Melrose Avenue, Hollywood, CA, 90038", "http://www.paramountstudios.com/"),
       ("CBS Television", "7800 Beverly Boulevard, Los Angeles, CA, 90036", "http://www.cbstelevisioncity.com");

/*
 * Prepopulating the table series with the various Star Trek TV series
*/

INSERT INTO series (title, creator_fname, creator_lname, start_date, end_date, studio_id)
VALUES ("Star Trek: The Original Series", "Gene", "Roddenberry", '1966-09-08', '1969-06-03', (SELECT id FROM studio WHERE name = "Desilu Productions")),
       ("Star Trek: The Next Generation", "Gene", "Roddenberry", '1987-09-28', '1994-05-23', (SELECT id FROM studio WHERE name = "Paramount Domestic Television")),
       ("Star Trek: Voyager", "Rick", "Berman", '1995-01-16', '2001-05-23', (SELECT id FROM studio WHERE name = "Paramount Network Television")),
       ("Star Trek: Deep Space Nine", "Rick", "Berman", '1993-01-03', '1999-06-02', (SELECT id FROM studio WHERE name = "Paramount Domestic Television"));

/*
 * Prepopulating the table episode with some Star Trek episodes
*/

INSERT INTO episode (title, episode_number, season_number, air_date, series_id)
VALUES ("The Trouble with Tribbles", 15, 2, '1967-12-29', (SELECT id FROM series WHERE title = "Star Trek: The Original Series")),
       ("Legacy", 6, 4, '1990-10-29', (SELECT id FROM series WHERE title = "Star Trek: The Next Generation")),
       ("Ensign Ro", 3, 5, '1991-10-07', (SELECT id FROM series WHERE title = "Star Trek: The Next Generation")),
       ("The Swarm", 4, 3, '1996-09-25', (SELECT id FROM series WHERE title = "Star Trek: Voyager")),
       ("Inquisition", 18, 6, '1998-04-08', (SELECT id FROM series WHERE title = "Star Trek: Deep Space Nine"));

/*
 * Prepopulating the actor_series table to relate actors to Star Trek Series they have
 * appeared in.
*/

INSERT INTO actor_series (actor_id, series_id)
VALUES ((SELECT id FROM actor WHERE fname = "Patrick" AND lname = "Stewart"),
              (SELECT id FROM series WHERE title = "Star Trek: The Next Generation")),
       ((SELECT id FROM actor WHERE fname = "Patrick" AND lname = "Stewart"),
              (SELECT id FROM series WHERE title = "Star Trek: Deep Space Nine")),
       ((SELECT id FROM actor WHERE fname = "Leonard" AND lname = "Nimoy"),
              (SELECT id FROM series WHERE title = "Star Trek: The Original Series")),
       ((SELECT id FROM actor WHERE fname = "Michael" AND lname = "Dorn"),
              (SELECT id FROM series WHERE title = "Star Trek: The Next Generation")),
       ((SELECT id FROM actor WHERE fname = "Michael" AND lname = "Dorn"),
              (SELECT id FROM series WHERE title = "Star Trek: Deep Space Nine")),
       ((SELECT id FROM actor WHERE fname = "Colm" AND lname = "Meaney"),
              (SELECT id FROM series WHERE title = "Star Trek: The Next Generation")),
       ((SELECT id FROM actor WHERE fname = "Colm" AND lname = "Meaney"),
              (SELECT id FROM series WHERE title = "Star Trek: Deep Space Nine")),
       ((SELECT id FROM actor WHERE fname = "William" AND lname = "Shatner"),
              (SELECT id FROM series WHERE title = "Star Trek: The Original Series")),
       ((SELECT id FROM actor WHERE fname = "Brent" AND lname = "Spiner"),
              (SELECT id FROM series WHERE title = "Star Trek: The Next Generation")),
       ((SELECT id FROM actor WHERE fname = "Kate" AND lname = "Mulgrew"),
              (SELECT id FROm series WHERE title = "Star Trek: Voyager"));

/*
 * Prepopulating the actor_character table to relate actors to Star Trek characters they
 * have portrayed.
*/

INSERT INTO actor_character (actor_id, character_id)
VALUES ((SELECT id FROM actor WHERE fname = "Patrick" AND lname = "Stewart"),
              (SELECT id FROM st_character WHERE fname = "Jean Luc" AND lname = "Picard")),
       ((SELECT id FROM actor WHERE fname = "Leonard" AND lname = "Nimoy"),
              (SELECT id FROM st_character WHERE fname = "Spock")),
       ((SELECT id FROM actor WHERE fname = "Michael" AND lname = "Dorn"),
              (SELECT id FROM st_character WHERE fname = "Worf")),
       ((SELECT id FROM actor WHERE fname = "Colm" AND lname = "Meaney"),
              (SELECT id FROM st_character WHERE fname = "Miles" AND lname = "O'Brien")),
       ((SELECT id FROM actor WHERE fname = "Brent" AND lname = "Spiner"),
              (SELECT id FROM st_character WHERE fname = "Data")),
       ((SELECT id FROM actor WHERE fname = "Kate" AND lname = "Mulgrew"), 
              (SELECT id FROM st_character WHERE fname = "Katherine" AND lname = "Janeway")),
       ((SELECT id FROM actor WHERE fname = "William" AND lname = "Shatner"),
              (SELECT id FROM st_character WHERE fname = "James" AND lname = "Kirk"));

/*
 * Prepopulating the character_episode table to relate Star Trek characters to episodes
 * they have appeared in.
*/

INSERT INTO character_episode (character_id, episode_id)
VALUES ((SELECT id FROM st_character WHERE fname = "Jean Luc" AND lname = "Picard"),
              (SELECT id FROM episode WHERE title = "Ensign Ro")),
       ((SELECT id FROM st_character WHERE fname = "Data"),
              (SELECT id FROM episode WHERE title = "Ensign Ro")),
       ((SELECT id FROM st_character WHERE fname = "Data"),
              (SELECT id FROM episode WHERE title = "Legacy")),
       ((SELECT id FROM st_character WHERE fname = "Jean Luc" AND lname = "Picard"),
              (SELECT id FROM episode WHERE title = "Legacy")),
       ((SELECT id FROM st_character WHERE fname = "Worf"),
              (SELECT id FROM episode WHERE title = "Legacy")),
       ((SELECT id FROM st_character WHERE fname = "Worf"),
              (SELECT id FROM episode WHERE title = "Ensign Ro")),
       ((SELECT id FROM st_character WHERE fname = "Worf"),
              (SELECT id FROM episode WHERE title = "Inquisition")),
       ((SELECT id FROM st_character WHERE fname = "Miles" AND lname = "O'Brien"),
              (SELECT id FROM episode WHERE title = "Legacy")),
       ((SELECT id FROM st_character WHERE fname = "Miles" AND lname = "O'Brien"),
              (SELECT id FROM episode WHERE title = "Ensign Ro")),
       ((SELECT id FROM st_character WHERE fname = "Miles" AND lname = "O'Brien"),
              (SELECT id FROM episode WHERE title = "Inquisition")),
       ((SELECT id FROM st_character WHERE fname = "Katherine" AND lname = "Janeway"),
              (SELECT id FROM episode WHERE title = "The Swarm")),
       ((SELECT id FROM st_character WHERE fname = "James" AND lname = "Kirk"),
              (SELECT id FROM episode WHERE title = "The Trouble with Tribbles")),
       ((SELECT id FROM st_character WHERE fname = "Spock"),
              (SELECT id FROM episode WHERE title = "The Trouble with Tribbles"));
