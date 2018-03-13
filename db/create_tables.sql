/******************************************************************************
* Course: Oregon State University CS 340-400 Spring 2017
* Program: Final Project, Canyoneering Beta Db
* Author: Drew Wolfe
* Description: 
*
* FILE: create_tables.sql
*  
* 
*  
* 
******************************************************************************/

/*
 * Drop statements to clean the out the old star_trek database records
 * if they exist.
*/

DROP TABLE IF EXISTS `actor_character`;
DROP TABLE IF EXISTS `character_episode`;
DROP TABLE IF EXISTS `actor_series`;
DROP TABLE IF EXISTS `episode`;
DROP TABLE IF EXISTS `actor`;
DROP TABLE IF EXISTS `st_character`;
DROP TABLE IF EXISTS `series`;
DROP TABLE IF EXISTS `studio`;

/*
 * star_trek.actor
 * Actors that have appeared in one or many Star Trek TV shows
*/

CREATE TABLE `actor` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `fname` VARCHAR(255) NOT NULL,
   `lname` VARCHAR(255),
   `website` VARCHAR(255),
   `twitter` VARCHAR(255)	
) ENGINE=’innoDB’;

/*
 * star_trek.st_character
 * Character roles that have appeared in one or many Star Trek TV shows
*/

CREATE TABLE `st_character` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `fname` VARCHAR(255) NOT NULL,
   `lname` VARCHAR(255),
   `race` VARCHAR(255) NOT NULL
) ENGINE=’innoDB’;

/*
 * star_trek.studio
 * Studios that have produced one or many Star Trek TV shows
*/

CREATE TABLE `studio` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `name` VARCHAR(255) NOT NULL,
   `address` VARCHAR(255),
   `website` VARCHAR(255)
) ENGINE=’innoDB’;

/*
 * star_trek.series
 * Star Trek TV series
*/

CREATE TABLE `series` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `title` VARCHAR(255) NOT NULL,
   `creator_fname` VARCHAR(255),
   `creator_lname` VARCHAR(255) NOT NULL,
   `start_date` DATE,
   `end_date` DATE,
   `studio_id` INT(11),
   FOREIGN KEY(`studio_id`) REFERENCES studio(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
) ENGINE=’innoDB’;

/*
 * star_trek.episode
 * Star Trek TV episodes
*/

CREATE TABLE `episode` (
   `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
   `title` VARCHAR(255) NOT NULL,
   `episode_number` INT(11) NOT NULL,
   `season_number` INT(11) NOT NULL,
   `air_date` DATE,
   `series_id` INT(11),
   FOREIGN KEY(`series_id`) REFERENCES series(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
) ENGINE=’innoDB’;

/*
 * star_trek.actor_series
 * This table relates actors to the Star Trek series they have
 * acted in. Many to many relationship (actor, series)
*/

CREATE TABLE `actor_series` (
   `actor_id` INT(11),
   `series_id` INT(11),
   PRIMARY KEY (`actor_id`, `series_id`),
   FOREIGN KEY (`actor_id`) REFERENCES actor(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY (`series_id`) REFERENCES series(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
) ENGINE=’innoDB’;

/*
 * star_trek.actor_character
 * This table relates actors to the characters they have played
 * in Star Trek TV shows. Many to many relationship (actor, character)
*/

CREATE TABLE `actor_character` (
   `actor_id` INT(11),
   `character_id` INT(11),
   PRIMARY KEY (`actor_id`, `character_id`),
   FOREIGN KEY (`actor_id`) REFERENCES actor(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY (`character_id`) REFERENCES st_character(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
) ENGINE=’innoDB’;

/*
 * star_trek.character_episode
 * This table relates Star Trek characters to which episodes they
 * appeared in. Many to many relationship (character, episode)
*/

CREATE TABLE `character_episode` (
   `character_id` INT(11),
   `episode_id` INT(11),
   PRIMARY KEY (`character_id`, `episode_id`),
   FOREIGN KEY (`character_id`) REFERENCES st_character(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   FOREIGN KEY (`episode_id`) REFERENCES episode(`id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE
) ENGINE=’innoDB’;
