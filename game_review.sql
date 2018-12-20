/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.5-10.1.32-MariaDB : Database - game_review
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`game_review` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `game_review`;

/*Table structure for table `comments` */

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `content_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `comment` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `comments` */

/*Table structure for table `contents` */

DROP TABLE IF EXISTS `contents`;

CREATE TABLE `contents` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `image` varchar(500) NOT NULL,
  `title` varchar(100) NOT NULL,
  `release_date` date DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `contents` */

insert  into `contents`(`id`,`image`,`title`,`release_date`,`description`) values (1,'https://c-7npsfqifvt0x24tubujdx2enfubdsjujdx2edpn.g00.metacritic.com/g00/3_c-7x78x78x78.nfubdsjujd.dpn_/c-7NPSFQIFVT0x24iuuqtx3ax2fx2ftubujd.nfubdsjujd.dpnx2fjnbhftx2fqspevdutx2fhbnftx2f2x2f22gec855ged9dg57663d94e1dec05933-09.kqhx3fj21d.nbslx3djnbhf_$/$/$/$/$/$','RimWorld','2018-10-17','A sci-fi colony sim driven by an intelligent AI storyteller. Inspired by Dwarf Fortress and Firefly. Generates stories by simulating psychology, ecology, gunplay, melee combat, climate, biomes, diplomacy, interpersonal relationships, art, medicine, trade, and more.'),(2,'https://c-7npsfqifvt0x24tubujdx2enfubdsjujdx2edpn.g00.metacritic.com/g00/3_c-7x78x78x78.nfubdsjujd.dpn_/c-7NPSFQIFVT0x24iuuqtx3ax2fx2ftubujd.nfubdsjujd.dpnx2fjnbhftx2fqspevdutx2fhbnftx2f2x2fcf2gg53c6613dcg57dd2f98ed99d1726-09.kqhx3fj21d.nbslx3djnbhf_$/$/$/$/$/$','Return of the Obra Dinn','2018-10-18','Return of the Obra Dinn is a first-person mystery adventure based on exploration and logical deduction.'),(3,'https://c-7npsfqifvt0x24tubujdx2enfubdsjujdx2edpn.g00.metacritic.com/g00/3_c-7x78x78x78.nfubdsjujd.dpn_/c-7NPSFQIFVT0x24iuuqtx3ax2fx2ftubujd.nfubdsjujd.dpnx2fjnbhftx2fqspevdutx2fhbnftx2f0x2f502g2eb433c8dd08774dgc60f3b9b235-09.kqhx3fj21d.nbslx3djnbhf_$/$/$/$/$/$','Forza Horizon 4','2018-09-28','For the first time in the racing and driving genre, experience dynamic seasons in a shared open-world. Explore beautiful scenery, collect over 450 cars, and become a Horizon Superstar in historic Britain.'),(4,'https://c-7npsfqifvt0x24tubujdx2enfubdsjujdx2edpn.g00.metacritic.com/g00/3_c-7x78x78x78.nfubdsjujd.dpn_/c-7NPSFQIFVT0x24iuuqtx3ax2fx2ftubujd.nfubdsjujd.dpnx2fjnbhftx2fqspevdutx2fhbnftx2f4x2f2g05dbfc9efg9g677c6cdecdcgf5df7c-09.kqhx3fj21d.nbslx3djnbhf_$/$/$/$/$/$','Football Manager 2019','2018-11-02','In Football Manager 2019 YOU are the author of your club\'s success: you define the tactics and style of play, and drive player recruitment to build the ultimate squad. You take an active role on the training ground, developing your squad and fine-tuning the preparations for upcoming matches.'),(5,'https://c-7npsfqifvt0x24tubujdx2enfubdsjujdx2edpn.g00.metacritic.com/g00/3_c-7x78x78x78.nfubdsjujd.dpn_/c-7NPSFQIFVT0x24iuuqtx3ax2fx2ftubujd.nfubdsjujd.dpnx2fjnbhftx2fqspevdutx2fhbnftx2f1x2f91bbfb84g9g43838f42e51d2149gc8g6-09.kqhx3fj21d.nbslx3djnbhf_$/$/$/$/$/$','CrossCode','2018-09-20','A retro-inspired 2D Action RPG set in the distant future. CrossCode combines 16-bit SNES-style graphics with butter-smooth physics, a fast-paced combat system, and engaging puzzle mechanics, served with a gripping sci-fi story.');

/*Table structure for table `reviews` */

DROP TABLE IF EXISTS `reviews`;

CREATE TABLE `reviews` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `customer` varchar(100) NOT NULL,
  `comments` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `reviews` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `email` varchar(250) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `users` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
