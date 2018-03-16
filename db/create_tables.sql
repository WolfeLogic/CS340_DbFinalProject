/******************************************************************************
* Course: Oregon State University CS 340-400 Spring 2017
* Program: Final Project, Canyoneering Beta Db
* Author: Drew Wolfe
* FILE: create_tables.sql
******************************************************************************/

/*
 * Drop statements to clean the out the old canyoneering database records
 * if they exist.
*/

DROP TABLE IF EXISTS `advent_trip`;
DROP TABLE IF EXISTS `advent_rappel`;
DROP TABLE IF EXISTS `trip_route`;
DROP TABLE IF EXISTS `route_canyon`;
DROP TABLE IF EXISTS `rappel`;
DROP TABLE IF EXISTS `trip`;
DROP TABLE IF EXISTS `adventurer`;
DROP TABLE IF EXISTS `route`;
DROP TABLE IF EXISTS `canyon`;


/*
 * canyoneering.trip
 * Trips include one or many Canyoneering adventurers
*/

CREATE TABLE `trip` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `adventName` VARCHAR(255) NOT NULL,
   `adventDate` DATE,
   `aca_rating` VARCHAR(255),
   `weather` VARCHAR(255)	
);

/*
 * canyoneering.adventurer
 * Adventureres have one or many Canyoneering trips and rappels
*/

CREATE TABLE `adventurer` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `fname` VARCHAR(255) NOT NULL,
   `lname` VARCHAR(255),
   `username` VARCHAR(255) NOT NULL
);

/*
 * canyoneering.canyon
 * Canyons that have one or many Canyoneering routes
*/

CREATE TABLE `canyon` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(255) NOT NULL,
   `state` VARCHAR(255),
   `region` VARCHAR(255)
);

/*
 * canyoneering.route
 * Canyoneering route
*/

CREATE TABLE `route` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `title` VARCHAR(255) NOT NULL,
   `start_point` VARCHAR(255),
   `end_point` VARCHAR(255),
   `aca_rating` VARCHAR(255),
   `num_rappel` INT(11),
   `canyon_id` INT(11),
   FOREIGN KEY(`canyon_id`) REFERENCES canyon(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

/*
 * canyoneering.rappel
 * Canyoneering rappels
*/

CREATE TABLE `rappel` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `title` VARCHAR(255) NOT NULL,
   `rappel_length_ft` INT(11) NOT NULL,
   `difficulty_note` VARCHAR(255),
   `anchr_type` VARCHAR(255),
   `route_id` INT(11),
   FOREIGN KEY(`route_id`) REFERENCES route(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

/*
 * canyoneering.trip_route
 * This table relates trips to routes they take.
 * A trip can take multiple routes. A route can be in many trips. 
 * Many to many relationship (trip, route)
*/

CREATE TABLE `trip_route` (
   `trip_id` INT(11),
   `route_id` INT(11),
   PRIMARY KEY (`trip_id`, `route_id`),
   FOREIGN KEY (`trip_id`) REFERENCES trip(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY (`route_id`) REFERENCES route(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

/*
 * canyoneering.advent_trip
 * This table relates adventureres to the trips they have attended. 
 * Many to many relationship (trip, adventurer)
*/

CREATE TABLE `advent_trip` (
   `trip_id` INT(11),
   `adventurer_id` INT(11),
   PRIMARY KEY (`trip_id`, `adventurer_id`),
   FOREIGN KEY (`trip_id`) REFERENCES trip(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY (`adventurer_id`) REFERENCES adventurer(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

/*
 * canyoneering.advent_rappel
 * This table relates Canyoneering adventurers to the rappels they
 * have descended. Many to many relationship (adventurer, rappel)
*/

CREATE TABLE `advent_rappel` (
   `adventurer_id` INT(11),
   `rappel_id` INT(11),
   PRIMARY KEY (`adventurer_id`, `rappel_id`),
   FOREIGN KEY (`adventurer_id`) REFERENCES adventurer(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY (`rappel_id`) REFERENCES rappel(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

/*
 * canyoneering.route_canyon
 * This table relates routes to the canyons they're in.
 * Many routes to one canyon (route, canyon)
*/

CREATE TABLE `route_canyon` (
   `route_id` INT(11),
   `canyon_id` INT(11),
   PRIMARY KEY (`route_id`, `canyon_id`),
   FOREIGN KEY (`route_id`) REFERENCES route(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY (`canyon_id`) REFERENCES canyon(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);