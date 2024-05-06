-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: d123178.mysql.zonevs.eu
-- Loomise aeg: Mai 06, 2024 kell 10:24 EL
-- Serveri versioon: 10.4.32-MariaDB-log
-- PHP versioon: 8.2.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `d123178_akbaas`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `ilm`
--

CREATE TABLE `ilm` (
  `id` int(11) NOT NULL,
  `kuupaev` date DEFAULT NULL,
  `temp` int(11) DEFAULT NULL,
  `kirjeldus` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `ilm`
--

INSERT INTO `ilm` (`id`, `kuupaev`, `temp`, `kirjeldus`) VALUES
(3, '2023-11-08', 2, 'päike pasitab'),
(4, '2023-10-31', -5, 'väga külm');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kassid`
--

CREATE TABLE `kassid` (
  `id` int(11) NOT NULL,
  `Nimi` text DEFAULT NULL,
  `Synnikuupaev` date DEFAULT NULL,
  `Varv` text DEFAULT NULL,
  `Pilt` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `kasutajad`
--

CREATE TABLE `kasutajad` (
  `id` int(11) NOT NULL,
  `kasutaja` varchar(30) DEFAULT NULL,
  `parool` text DEFAULT NULL,
  `onAdmin` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Andmete tõmmistamine tabelile `kasutajad`
--

INSERT INTO `kasutajad` (`id`, `kasutaja`, `parool`, `onAdmin`) VALUES
(1, 'kasutaja', 'ta28kOQTAKQwc', 0),
(2, 'admin', 'tagJdjbPkRspk', 1),
(3, 'arkadi', 'tabG40o/jThuE', NULL),
(4, 'akaki', 'taAweEenpxAkU', NULL),
(5, 'test2', 'taZ/lz45bvwbA', NULL),
(6, 'test3', 'taZ/lz45bvwbA', NULL),
(7, 'asdf', 'ta6TKcHFxA34Y', NULL),
(8, 'assss', 'tauHjlRZd6JB.', NULL),
(9, 'asddd', 'tauHjlRZd6JB.', NULL),
(10, 'asdfaga', 'tauHjlRZd6JB.', NULL),
(11, 'asfafasfasf', 'tauHjlRZd6JB.', NULL),
(12, 'adfköafdsk', 'tauHjlRZd6JB.', NULL),
(13, 'irina', 'ta6Obs9X41wdM', NULL);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `linn`
--

CREATE TABLE `linn` (
  `id` int(11) NOT NULL,
  `linnanimi` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Andmete tõmmistamine tabelile `linn`
--

INSERT INTO `linn` (`id`, `linnanimi`) VALUES
(1, 'Tartu'),
(2, 'Tartu');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `linnaosa`
--

CREATE TABLE `linnaosa` (
  `id` int(11) NOT NULL,
  `linnaosa` text DEFAULT NULL,
  `inimesteArv` int(11) DEFAULT NULL,
  `linn_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Andmete tõmmistamine tabelile `linnaosa`
--

INSERT INTO `linnaosa` (`id`, `linnaosa`, `inimesteArv`, `linn_id`) VALUES
(1, '', 0, NULL),
(5, '123', 0, 1),
(11, 'asd', 123, 1),
(12, 'saf', 213, 1);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `opilane`
--

CREATE TABLE `opilane` (
  `id` int(11) NOT NULL,
  `Nimi` text DEFAULT NULL,
  `Koduleht` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Andmete tõmmistamine tabelile `opilane`
--

INSERT INTO `opilane` (`id`, `Nimi`, `Koduleht`) VALUES
(1, 'Maksim Artjomov', 'maksimartjomov22.thkit.ee'),
(2, 'Oleksander Bohatyrov', 'oleksandrbohatyrov22.thkit.ee'),
(3, 'Anton Buivol', 'antonbuivol22.thkit.ee'),
(4, 'Edvard Datser', 'edvarddatser22.thkit.ee'),
(5, 'Maksim Dochkin', 'maksimdotskin22.thkit.ee'),
(6, 'Timur Denisenko', 'timurdenisenko22.thkit.ee'),
(7, 'Egor Fedorenko', 'egorfedorenko22.thkit.ee'),
(8, 'Luca Gluhhov', 'lucagluhhov22.thkit.ee'),
(9, 'Denis Gorjunov', 'denissgorjunov22.thkit.ee'),
(10, 'Martin Kemppi', 'martinkemppi22.thkit.ee'),
(11, 'Arkadi Korotõtš', 'arkadikorotots22.thkit.ee'),
(12, 'Matvei Kulakovski', 'matveikulakovski22.thkit.ee'),
(13, 'Darja Miljukova', 'darjamiljukova22.thkit.ee'),
(14, 'Veronika Milovzorova', 'veronikamilovzorova22.thkit.ee'),
(15, 'Maksim Miskevich', 'maksymmiskevych22.thkit.ee'),
(16, 'Ekaterina Mõslajeva', 'ekaterinamosljajeva22.thkit.ee'),
(17, 'Martin Nõmmiste', 'martinnommiste22.thkit.ee'),
(18, 'Aleksander Rogovski', 'aleksanderrogovski22.thkit.ee'),
(19, 'Anna Sohromova', 'annasohromova22.thkit.ee'),
(20, 'Maksim Chepilevich', 'maksimtsepelevits22.thkit.ee'),
(21, 'Yaroslab Yekasov', 'yaroslavyekasov22.thkit.ee'),
(22, 'Artur Šuškevich', 'artursuskevits22.thkit.ee');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `raamatukogu`
--

CREATE TABLE `raamatukogu` (
  `id` int(11) NOT NULL,
  `nimi` varchar(50) DEFAULT NULL,
  `autor` varchar(50) DEFAULT NULL,
  `laenutus_kuup` text DEFAULT 'puudub',
  `laenu_pikkus` date DEFAULT NULL,
  `saadavus` text DEFAULT 'on'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Andmete tõmmistamine tabelile `raamatukogu`
--

INSERT INTO `raamatukogu` (`id`, `nimi`, `autor`, `laenutus_kuup`, `laenu_pikkus`, `saadavus`) VALUES
(4, 'as', 'ad', 'on', '2024-01-25', 'mitte'),
(5, 'koob', 'roob', 'on', '2024-01-19', 'mitte'),
(6, 'bro', 'orb', 'on', '2024-02-23', 'mitte'),
(7, 'asf', 'asfa', 'puudub', '2024-01-27', 'on'),
(8, 'gg', 'gg', 'puudub', '2024-01-30', 'on'),
(9, 'test', 'test', 'puudub', '2024-01-25', 'on');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `syndmused`
--

CREATE TABLE `syndmused` (
  `id` int(11) NOT NULL,
  `syndmus` varchar(30) DEFAULT NULL,
  `kuupaev` date DEFAULT NULL,
  `kirjeldus` varchar(100) DEFAULT NULL,
  `pilt` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `syndmused`
--

INSERT INTO `syndmused` (`id`, `syndmus`, `kuupaev`, `kirjeldus`, `pilt`) VALUES
(1, 'Mälumäng', '2023-11-12', 'Eimese kursuse mälumäng', 'https://i.ytimg.com/vi/jHgZh4GV9G0/maxresdefault.jpg'),
(2, 'asf', '2022-11-09', 'abbaabbabababa', 'https://steamuserimages-a.akamaihd.net/ugc/2031730758729035509/6B0AEEAD4FC119F5955F6D7A568889F56CE73B70/?imw=512&imh=512&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true'),
(13, 'sfasag', '2022-12-12', 'asfagag', 'https://ih1.redbubble.net/image.4742372675.8874/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg'),
(19, 'sagag', '2023-11-29', 'blue', 'https://steamuserimages-a.akamaihd.net/ugc/963116578370774090/2B15A58E6C62E7F6868230D0EEC49A32F1C39684/?imw=637&imh=358&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `tantsud`
--

CREATE TABLE `tantsud` (
  `id` int(11) NOT NULL,
  `tantsupaar` varchar(30) DEFAULT NULL,
  `punktid` int(11) DEFAULT 0,
  `kommentaarid` text DEFAULT '-',
  `ava_paev` datetime DEFAULT NULL,
  `avalik` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Andmete tõmmistamine tabelile `tantsud`
--

INSERT INTO `tantsud` (`id`, `tantsupaar`, `punktid`, `kommentaarid`, `ava_paev`, `avalik`) VALUES
(5, 'tttt', 5, '-', '2024-01-12 12:46:38', 1);

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `ilm`
--
ALTER TABLE `ilm`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `kassid`
--
ALTER TABLE `kassid`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `kasutajad`
--
ALTER TABLE `kasutajad`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `linn`
--
ALTER TABLE `linn`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `linnaosa`
--
ALTER TABLE `linnaosa`
  ADD PRIMARY KEY (`id`),
  ADD KEY `linn_id` (`linn_id`);

--
-- Indeksid tabelile `opilane`
--
ALTER TABLE `opilane`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `raamatukogu`
--
ALTER TABLE `raamatukogu`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `syndmused`
--
ALTER TABLE `syndmused`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `tantsud`
--
ALTER TABLE `tantsud`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tantsupaar` (`tantsupaar`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `ilm`
--
ALTER TABLE `ilm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `kassid`
--
ALTER TABLE `kassid`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `kasutajad`
--
ALTER TABLE `kasutajad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT tabelile `linn`
--
ALTER TABLE `linn`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT tabelile `linnaosa`
--
ALTER TABLE `linnaosa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT tabelile `opilane`
--
ALTER TABLE `opilane`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT tabelile `raamatukogu`
--
ALTER TABLE `raamatukogu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT tabelile `syndmused`
--
ALTER TABLE `syndmused`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT tabelile `tantsud`
--
ALTER TABLE `tantsud`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `linnaosa`
--
ALTER TABLE `linnaosa`
  ADD CONSTRAINT `linnaosa_ibfk_1` FOREIGN KEY (`linn_id`) REFERENCES `linn` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
