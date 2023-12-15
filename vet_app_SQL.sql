-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: localhost
-- Üretim Zamanı: 14 Ara 2023, 23:18:03
-- Sunucu sürümü: 8.0.31
-- PHP Sürümü: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `vet_app`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `animal`
--

CREATE TABLE `animal` (
  `id` bigint NOT NULL,
  `breed` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `colour` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `gender` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `species` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `customer_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `animal`
--

INSERT INTO `animal` (`id`, `breed`, `colour`, `date_of_birth`, `gender`, `name`, `species`, `customer_id`) VALUES
(1, 'Kangal', 'Kahverengi-Beyaz', '2018-11-30', 'Erkek', 'Karabaş', 'Köpek', 1),
(2, 'British', 'Beyaz', '2020-02-02', 'Dişi', 'Lili', 'Kedi', 1),
(3, 'Türk Van', 'Gri Desenli', '2019-11-20', 'Erkek', 'Prens', 'Van Kedisi', 2),
(4, 'Ankara Kedisi', 'Gri', '2021-03-10', 'Dişi', 'Minnoş', 'Angora', 2),
(5, 'Karışık', 'Siyah-Beyaz', '2020-08-08', 'Erkek', 'Şans', 'Köpek', 3),
(6, 'Suriye', 'Kahverengi', '2019-12-25', 'Dişi', 'Boncuk', 'Hamster', 4),
(7, 'Minyatür', 'Krem', '2017-07-07', 'Dişi', 'Karamel', 'Tavşan', 4),
(8, 'Muhabbet', 'Sarı', '2020-04-12', 'Dişi', 'Tarçın', 'Kuş', 5);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `appointment`
--

CREATE TABLE `appointment` (
  `id` bigint NOT NULL,
  `appointment_date` datetime(6) DEFAULT NULL,
  `animal_id` bigint DEFAULT NULL,
  `doctor_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `appointment`
--

INSERT INTO `appointment` (`id`, `appointment_date`, `animal_id`, `doctor_id`) VALUES
(1, '2023-12-20 09:00:00.000000', 1, 1),
(2, '2023-12-22 09:00:00.000000', 2, 1),
(3, '2023-12-20 10:00:00.000000', 3, 1),
(4, '2023-12-19 19:00:00.000000', 4, 2),
(5, '2023-12-20 19:00:00.000000', 5, 2),
(6, '2023-12-27 10:00:00.000000', 6, 3),
(7, '2023-12-29 10:00:00.000000', 7, 4),
(8, '2023-12-19 10:00:00.000000', 8, 5);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `available_date`
--

CREATE TABLE `available_date` (
  `id` bigint NOT NULL,
  `available_date` date DEFAULT NULL,
  `doctor_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `available_date`
--

INSERT INTO `available_date` (`id`, `available_date`, `doctor_id`) VALUES
(1, '2023-12-20', 1),
(2, '2023-12-22', 1),
(3, '2023-12-26', 1),
(4, '2023-12-28', 1),
(5, '2023-12-19', 2),
(6, '2023-12-20', 2),
(7, '2023-12-27', 3),
(8, '2023-12-28', 3),
(9, '2023-12-29', 3),
(10, '2023-12-29', 4),
(11, '2023-12-19', 5),
(12, '2023-12-26', 5);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `customer`
--

CREATE TABLE `customer` (
  `id` bigint NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mail` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(11) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `customer`
--

INSERT INTO `customer` (`id`, `address`, `city`, `mail`, `name`, `phone`) VALUES
(1, 'Üsküdar/İstanbul', 'İstanbul', 'salihkiran@gmail.com', 'Salih Kıran', '5333333333'),
(2, 'Kadıköy/İstanbul', 'İstanbul', 'ayse.yilmaz@gmail.com', 'Ayşe Yılmaz', '5555555555'),
(3, 'Beşiktaş/İstanbul', 'İstanbul', 'mehmet.demir@gmail.com', 'Mehmet Demir', '5444444444'),
(4, 'Sarıyer/İstanbul', 'İstanbul', 'fatma.kaya@gmail.com', 'Fatma Kaya', '5322222222'),
(5, 'Ümraniye/İstanbul', 'İstanbul', 'cem.ozturk@gmail.com', 'Cem Öztürk', '5333333332');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `doctor`
--

CREATE TABLE `doctor` (
  `id` bigint NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `city` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mail` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `phone` varchar(11) COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `doctor`
--

INSERT INTO `doctor` (`id`, `address`, `city`, `mail`, `name`, `phone`) VALUES
(1, 'Ataşehir/İstanbul', 'İstanbul', 'hndkyldz@gmail.com', 'Hande Akyıldız', '05426898988'),
(2, 'Levent/İstanbul', 'İstanbul', 'elifakgun@gmail.com', 'Elif Akgün', '05551112222'),
(3, 'Etiler/İstanbul', 'İstanbul', 'canaydin@gmail.com', 'Can Aydın', '05336667777'),
(4, 'Kuştepe/İstanbul', 'İstanbul', 'defneaktas@gmail.com', 'Defne Aktaş', '05443334444'),
(5, 'Maslak/İstanbul', 'İstanbul', 'ardayilmaz@gmail.com', 'Arda Yılmaz', '05554445555');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `vaccine`
--

CREATE TABLE `vaccine` (
  `id` bigint NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `protection_finish_date` date NOT NULL,
  `protection_start_date` date NOT NULL,
  `animal_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `vaccine`
--

INSERT INTO `vaccine` (`id`, `code`, `name`, `protection_finish_date`, `protection_start_date`, `animal_id`) VALUES
(1, 'A2', 'Aşı 2', '2023-12-20', '2022-12-20', 1),
(2, 'A1', 'Aşı 1', '2024-01-01', '2023-01-01', 1),
(3, 'A1', 'Aşı 1', '2023-12-10', '2022-12-10', 2),
(4, 'A1', 'Aşı 1', '2023-12-01', '2022-12-01', 3),
(5, 'A1', 'Aşı 1', '2023-06-01', '2022-06-01', 4),
(6, 'A3', 'Aşı 3', '2023-06-01', '2022-06-01', 4),
(7, 'A2', 'Aşı 2', '2023-12-01', '2022-12-01', 5);

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `animal`
--
ALTER TABLE `animal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6pvxm5gfjqxclb651be9unswe` (`customer_id`);

--
-- Tablo için indeksler `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK2kkeptdxfuextg5ch7xp3ytie` (`animal_id`),
  ADD KEY `FKoeb98n82eph1dx43v3y2bcmsl` (`doctor_id`);

--
-- Tablo için indeksler `available_date`
--
ALTER TABLE `available_date`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKk0d6pu1wxarsoou0x2e1cc2on` (`doctor_id`);

--
-- Tablo için indeksler `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `vaccine`
--
ALTER TABLE `vaccine`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKne3kmh8y5pcyxwl4u2w9prw6j` (`animal_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `animal`
--
ALTER TABLE `animal`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Tablo için AUTO_INCREMENT değeri `appointment`
--
ALTER TABLE `appointment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Tablo için AUTO_INCREMENT değeri `available_date`
--
ALTER TABLE `available_date`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Tablo için AUTO_INCREMENT değeri `customer`
--
ALTER TABLE `customer`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `vaccine`
--
ALTER TABLE `vaccine`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `animal`
--
ALTER TABLE `animal`
  ADD CONSTRAINT `FK6pvxm5gfjqxclb651be9unswe` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`);

--
-- Tablo kısıtlamaları `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `FK2kkeptdxfuextg5ch7xp3ytie` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`),
  ADD CONSTRAINT `FKoeb98n82eph1dx43v3y2bcmsl` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`);

--
-- Tablo kısıtlamaları `available_date`
--
ALTER TABLE `available_date`
  ADD CONSTRAINT `FKk0d6pu1wxarsoou0x2e1cc2on` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id`);

--
-- Tablo kısıtlamaları `vaccine`
--
ALTER TABLE `vaccine`
  ADD CONSTRAINT `FKne3kmh8y5pcyxwl4u2w9prw6j` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
