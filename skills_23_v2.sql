-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 28, 2023 at 04:23 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `skills_23_v2`
--

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL,
  `zipcode` varchar(100) NOT NULL,
  `id_pays` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `zipcode`, `id_pays`) VALUES
(1, 'Bruxelles-Centre', '1000', 1),
(3, 'Berlin', '10115', 3),
(4, 'Rome', '00100', 4),
(5, 'Southall', 'UB1', 5),
(6, 'Koekelberg', '1081', 1),
(8, 'Venice', '34275', 11),
(13, 'Anápolis', '00750-000', 16),
(14, 'São Paulo', '00331-000', 16);

-- --------------------------------------------------------

--
-- Stand-in structure for view `contactcitiespays`
-- (See below for the actual view)
--
CREATE TABLE `contactcitiespays` (
`id` smallint(5) unsigned
,`name` varchar(150)
,`firstname` varchar(150)
,`email` varchar(255)
,`address` varchar(300)
,`id_city` smallint(6)
,`inscription` tinyint(1)
,`hobbies` set('Tennis','Cinéma','Théatre')
,`gender` enum('Homme','Femme','Autre')
,`cities_id` smallint(5) unsigned
,`city_name` varchar(100)
,`zipcode` varchar(100)
,`id_pays` tinyint(4)
,`countries_id` tinyint(3) unsigned
,`country_name` varchar(200)
);

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(150) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `address` varchar(300) DEFAULT NULL,
  `id_city` smallint(6) DEFAULT NULL,
  `inscription` tinyint(1) DEFAULT 1,
  `hobbies` set('Tennis','Cinéma','Théatre') DEFAULT NULL,
  `gender` enum('Homme','Femme','Autre') NOT NULL,
  `father_id` int(11) DEFAULT NULL,
  `grandfather_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `firstname`, `email`, `address`, `id_city`, `inscription`, `hobbies`, `gender`, `father_id`, `grandfather_id`) VALUES
(1, 'Smith', 'John', 'john.smith@example.com', 'Rue de l\'Abbaye', 1, 1, 'Cinéma', 'Homme', NULL, NULL),
(2, 'Johnson', 'Emily', 'emily.johnson@example.com', 'Rue d\'Alger', NULL, 0, 'Tennis', 'Femme', NULL, NULL),
(3, 'Williams', 'Michael', 'NULL', 'Castello 4196', 8, 0, 'Tennis,Cinéma', 'Homme', NULL, NULL),
(4, 'Jones', 'Jessica', 'jessica.jones@example.com', 'NULL', 5, 1, NULL, 'Autre', NULL, NULL),
(5, 'Mirza', 'Hassan', 'hassanm.work@gmail.com', 'Rue Vandenboogaerde 86', 6, 1, 'Cinéma,Théatre', 'Homme', 6, 7),
(6, 'Mirza', 'Imran', 'ibaig1@hotmail.com', 'Rue Vandenboogaerde 86', 1, 1, NULL, 'Homme', 7, NULL),
(7, 'Mirza', 'Papi', NULL, NULL, NULL, 1, NULL, '', NULL, NULL),
(8, 'Mirza', 'Hussain', NULL, NULL, NULL, 1, NULL, '', 6, 7),
(9, 'To', 'Delete', NULL, NULL, NULL, 1, NULL, '', NULL, NULL),
(10, 'Fabri', 'Damien', NULL, NULL, NULL, 1, NULL, 'Homme', NULL, NULL),
(11, 'Burke', 'Bernadette', NULL, NULL, NULL, 1, NULL, 'Femme', NULL, NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `contactsandfathers`
-- (See below for the actual view)
--
CREATE TABLE `contactsandfathers` (
`id` smallint(5) unsigned
,`name` varchar(150)
,`firstname` varchar(150)
,`father_id` int(11)
,`father_firstname` varchar(150)
,`father_name` varchar(150)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `notbrusselsorsouthall`
-- (See below for the actual view)
--
CREATE TABLE `notbrusselsorsouthall` (
`id` smallint(5) unsigned
,`NAME` varchar(150)
,`firstname` varchar(150)
,`gender` enum('Homme','Femme','Autre')
);

-- --------------------------------------------------------

--
-- Table structure for table `pays`
--

CREATE TABLE `pays` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pays`
--

INSERT INTO `pays` (`id`, `name`) VALUES
(3, 'Allemagne'),
(1, 'Belgique'),
(16, 'Brésil'),
(11, 'Bulgarie'),
(14, 'Chine'),
(12, 'Espagne'),
(10, 'Finlande'),
(4, 'Italie'),
(7, 'Pays-Bas'),
(8, 'Pologne'),
(5, 'Royaumes-Unis'),
(9, 'Suède'),
(6, 'Suisse'),
(13, 'Turquie');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `login`, `password`) VALUES
(1, 'admin', 'admin'),
(2, 'hassan', 'password');

-- --------------------------------------------------------

--
-- Structure for view `contactcitiespays`
--
DROP TABLE IF EXISTS `contactcitiespays`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `contactcitiespays`  AS SELECT `contacts`.`id` AS `id`, `contacts`.`name` AS `name`, `contacts`.`firstname` AS `firstname`, `contacts`.`email` AS `email`, `contacts`.`address` AS `address`, `contacts`.`id_city` AS `id_city`, `contacts`.`inscription` AS `inscription`, `contacts`.`hobbies` AS `hobbies`, `contacts`.`gender` AS `gender`, `cities`.`id` AS `cities_id`, `cities`.`name` AS `city_name`, `cities`.`zipcode` AS `zipcode`, `cities`.`id_pays` AS `id_pays`, `pays`.`id` AS `countries_id`, `pays`.`name` AS `country_name` FROM ((`contacts` left join `cities` on(`cities`.`id` = `contacts`.`id_city`)) left join `pays` on(`cities`.`id_pays` = `pays`.`id`)) ORDER BY `pays`.`name` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `contactsandfathers`
--
DROP TABLE IF EXISTS `contactsandfathers`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `contactsandfathers`  AS SELECT `contacts`.`id` AS `id`, `contacts`.`name` AS `name`, `contacts`.`firstname` AS `firstname`, `contacts`.`father_id` AS `father_id`, `father`.`firstname` AS `father_firstname`, `father`.`name` AS `father_name` FROM (`contacts` join `contacts` `father` on(`contacts`.`father_id` = `father`.`id`)) ORDER BY `contacts`.`firstname` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `notbrusselsorsouthall`
--
DROP TABLE IF EXISTS `notbrusselsorsouthall`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `notbrusselsorsouthall`  AS SELECT `contacts`.`id` AS `id`, `contacts`.`name` AS `NAME`, `contacts`.`firstname` AS `firstname`, `contacts`.`gender` AS `gender` FROM `contacts` WHERE `contacts`.`id_city` not in (1,5) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `zipcode` (`zipcode`),
  ADD KEY `id_pays` (`id_pays`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `lastname` (`name`),
  ADD KEY `firstname` (`firstname`),
  ADD KEY `id_city` (`id_city`),
  ADD KEY `father_id` (`father_id`),
  ADD KEY `grandfather_id` (`grandfather_id`);

--
-- Indexes for table `pays`
--
ALTER TABLE `pays`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pays`
--
ALTER TABLE `pays`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
