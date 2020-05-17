/*
SQLyog Ultimate v13.1.1 (64 bit)
MySQL - 10.3.14-MariaDB : Database - tugerente
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`tugerente` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `tugerente`;

/*Table structure for table `groups` */

DROP TABLE IF EXISTS `groups`;

CREATE TABLE `groups` (
  `groupcode` smallint(6) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`groupcode`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `groups` */

insert  into `groups`(`groupcode`,`name`) values 
(1,'BOLIVIA'),
(2,'SUCRE'),
(3,'tr');

/*Table structure for table `groupsusers` */

DROP TABLE IF EXISTS `groupsusers`;

CREATE TABLE `groupsusers` (
  `groupcode` smallint(6) NOT NULL,
  `usercode` smallint(6) NOT NULL,
  PRIMARY KEY (`groupcode`,`usercode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `groupsusers` */

insert  into `groupsusers`(`groupcode`,`usercode`) values 
(1,1),
(1,4);

/*Table structure for table `notes` */

DROP TABLE IF EXISTS `notes`;

CREATE TABLE `notes` (
  `notecode` smallint(6) NOT NULL AUTO_INCREMENT,
  `groupcode` smallint(6) NOT NULL,
  `title` varchar(50) NOT NULL,
  `detail` varchar(200) NOT NULL,
  PRIMARY KEY (`notecode`),
  KEY `groupcode` (`groupcode`),
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`groupcode`) REFERENCES `groups` (`groupcode`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

/*Data for the table `notes` */

insert  into `notes`(`notecode`,`groupcode`,`title`,`detail`) values 
(4,1,'ggff','vggh'),
(5,1,'ggff','vggh'),
(6,1,'ggff','vggh'),
(7,1,'rtt','rgh'),
(8,1,'4445','hhhh'),
(9,2,'4445','hhhh'),
(10,1,'r6e','dudu'),
(11,1,'r6e','dudu'),
(12,2,'rt','fg'),
(13,2,'rt','fg'),
(14,2,'thg','ggf'),
(15,2,'thg','ggf');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`email_verified_at`,`password`,`remember_token`,`created_at`,`updated_at`) values 
(1,'CARLOS','nocialu_matador@hotmail.com',NULL,'$2y$10$KvrLXngxK4wFOPu/CUZQuuBAEoL7cLjkzL6HMe.3p/h8NsqBjCwou',NULL,'2020-05-13 04:24:34','2020-05-13 04:24:34'),
(2,'DANIEL','fromhell.wtc@gmail.com',NULL,'$2y$10$t2Y7RjV9gN2RbD.zT2wyAO6eZMuP.15vzjGeLia4H4Hg8V0.9BXLG',NULL,'2020-05-13 04:34:38','2020-05-13 04:34:38'),
(4,'MIGUEL ANGEL','miguelhangelh@hotmail.com',NULL,'$2y$10$79v/WuB.VYh//UE60C7Dr.Fs2fQBx7Bq7kRAffDcVveljPb4y.Ay.',NULL,'2020-05-13 04:38:40','2020-05-13 04:38:40'),
(5,'miguel','miguelhangelh1@hotmail.coml',NULL,'$2y$10$4BR9vBxR4pSET.4lC5l7LOplHGAcRs3O8Qx3Ln72LlMWKROfny0g.',NULL,'2020-05-16 19:30:00','2020-05-16 19:30:00'),
(6,'miguelggg','miguelhange1lh1@hotmail.coml',NULL,'$2y$10$d4mwEkn6FPM0zdMB5SUEJOzyjBND1xDmMKEqkXdJeNokiWRiU1dta',NULL,'2020-05-16 19:32:26','2020-05-16 19:32:26'),
(7,'miguel','miguelhanrgelh1@hotmail.coml',NULL,'$2y$10$0fvHhQYPWGJp3EZDoeNpiOQnXSizTogA87/1BeMfY8N7FYiAd3qyy',NULL,'2020-05-16 19:37:31','2020-05-16 19:37:31'),
(8,'miguel','miguelhanr1gelh1@hotmail.coml',NULL,'$2y$10$4PR5Rikx5mWNdEsRy/h..u/Hf.ohsqcTodfuYxMmRzB8XwNl7rtTO',NULL,'2020-05-16 19:39:36','2020-05-16 19:39:36'),
(9,'miguel','miguelhanr12gelh1@hotmail.coml',NULL,'$2y$10$FuJgGnrkJgLO7dYjBbtvZeKr5oBi7QyvAGeXXCaD47IFygM20nFUq',NULL,'2020-05-16 19:45:36','2020-05-16 19:45:36'),
(10,'miguel','migue23lhangelh1@hotmail.coml',NULL,'$2y$10$cnVrwFt9v9yzYvVxYK7GeurSaDRsZ1FVDsqteTQcmhCWCecByIPry',NULL,'2020-05-17 03:08:47','2020-05-17 03:08:47'),
(11,'miguel','m22iguelhangelh1@hotmail.coml',NULL,'$2y$10$.nDAND5T.SAFyfbgu8GFcOxoH1LL4Zlw8stM79U8GjHOqshsYrtIS',NULL,'2020-05-17 03:11:59','2020-05-17 03:11:59');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
