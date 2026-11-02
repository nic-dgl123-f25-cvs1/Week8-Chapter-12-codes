-- ------------------------------------------------------------------
-- phpbook-1 sample database for Chapter 12 (Creative Folk site)
--
-- HOW TO IMPORT IN XAMPP
--   1. Start Apache and MySQL in the XAMPP Control Panel.
--   2. Open http://localhost/phpmyadmin
--   3. Click the Import tab (at the top, with no database selected).
--   4. Choose this file and click Import (or Go).
--
-- This file creates the phpbook-1 database for you.
-- Running it again resets the database to these starting rows.
-- ------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS `phpbook-1`
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE `phpbook-1`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `article`;
DROP TABLE IF EXISTS `image`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `member`;
SET FOREIGN_KEY_CHECKS = 1;

-- ------------------------------------------------------------------
-- member: people who post work on the site
-- ------------------------------------------------------------------
CREATE TABLE `member` (
  `id`       INT          NOT NULL AUTO_INCREMENT,
  `forename` VARCHAR(254) NOT NULL,
  `surname`  VARCHAR(254) NOT NULL,
  `email`    VARCHAR(254) NOT NULL,
  `password` VARCHAR(254) NOT NULL,
  `joined`   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `picture`  VARCHAR(254) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------
-- category: sections of the site shown in the navigation bar
-- ------------------------------------------------------------------
CREATE TABLE `category` (
  `id`          INT          NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(24)  NOT NULL,
  `description` VARCHAR(254) NOT NULL,
  `navigation`  TINYINT(1)   NOT NULL DEFAULT 0,  -- 1 = show in navigation bar
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_unique` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------
-- image: picture files stored in cms/uploads/
-- ------------------------------------------------------------------
CREATE TABLE `image` (
  `id`   INT          NOT NULL AUTO_INCREMENT,
  `file` VARCHAR(254) NOT NULL,
  `alt`  VARCHAR(1000) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------
-- article: one piece of work posted by a member
-- ------------------------------------------------------------------
CREATE TABLE `article` (
  `id`          INT          NOT NULL AUTO_INCREMENT,
  `title`       VARCHAR(80)  NOT NULL,
  `summary`     VARCHAR(254) NOT NULL,
  `content`     TEXT         NOT NULL,
  `created`     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_id` INT          NOT NULL,
  `member_id`   INT          NOT NULL,
  `image_id`    INT          DEFAULT NULL,
  `published`   TINYINT(1)   NOT NULL DEFAULT 0,  -- 1 = visible on the site
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  KEY `member_id` (`member_id`),
  KEY `image_id` (`image_id`),
  CONSTRAINT `article_category_fk` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `article_member_fk`   FOREIGN KEY (`member_id`)   REFERENCES `member` (`id`),
  CONSTRAINT `article_image_fk`    FOREIGN KEY (`image_id`)    REFERENCES `image` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------------
-- Sample data
-- Every member's password is: password  (stored as a hash)
-- ------------------------------------------------------------------
INSERT INTO `member` (`id`, `forename`, `surname`, `email`, `password`, `joined`, `picture`) VALUES
(1, 'Ivy',   'Stone', 'ivy@eg.link',  '$2y$10$hL/s0QmvBg4Ca022OnhpMeQkapMLud49AXirevE9hTv8gA5STVO8O', '2021-01-26 12:04:23', 'ivy.jpg'),
(2, 'Luke',  'Wood',  'luke@eg.link', '$2y$10$hL/s0QmvBg4Ca022OnhpMeQkapMLud49AXirevE9hTv8gA5STVO8O', '2021-01-26 12:15:18', 'luke.jpg'),
(3, 'Emiko', 'Ito',   'emi@eg.link',  '$2y$10$hL/s0QmvBg4Ca022OnhpMeQkapMLud49AXirevE9hTv8gA5STVO8O', '2021-02-12 10:53:47', 'emi.jpg');

INSERT INTO `category` (`id`, `name`, `description`, `navigation`) VALUES
(1, 'Print',        'Inspiring graphic work on paper',  1),
(2, 'Digital',      'Powerful pixels',                  1),
(3, 'Illustration', 'Hand-drawn visual storytelling',   1),
(4, 'Photography',  'Capturing the moment',             1);

INSERT INTO `image` (`id`, `file`, `alt`) VALUES
(1,  'systemic-brochure.jpg',      'Yellow folded brochure about systems in our world'),
(2,  'forecast.jpg',               'Repeating pattern of hand-drawn handbags on a pink background'),
(3,  'seascape.jpg',               'Calm sea under a hazy golden sky'),
(4,  'birds.jpg',                  'Two cartoon birds walking across a green hill'),
(5,  'swimming-pool.jpg',          'Black and white photo of a pool seen through large windows'),
(6,  'the-ice-palace.jpg',         'Hardback book with the title The Ice Palace'),
(7,  'micro-dunes.jpg',            'Close-up of ripples in desert sand'),
(8,  'snow-search.jpg',            'Child and dog standing in deep snow'),
(9,  'milk-beach-skyline.jpg',     'City skyline seen across a rocky beach'),
(10, 'polite-society-mural.jpg',   'Geometric line drawing in teal'),
(11, 'milk-beach-album.jpg',       'Album sleeve and vinyl record for Milk Beach'),
(12, 'milk-beach.jpg',             'Laptop showing the Milk Beach website'),
(13, 'wellness.jpg',               'Three phones showing a yoga timetable app'),
(14, 'stargazer.jpg',              'Tablet and phone showing the Stargazer festival line-up'),
(15, 'chimney.jpg',                'Three phones showing the Chimney Press book pages'),
(16, 'polite-society.jpg',         'Laptop showing the Polite Society fashion show page'),
(17, 'floral.jpg',                 'Laptop showing a florist website with flowers'),
(18, 'abandoned.jpg',              'Old crane on an abandoned industrial site'),
(19, 'chimney-cards.jpg',          'Box of Chimney business cards'),
(20, 'stargazer-mascot.jpg',       'Blue line drawing of a character with long hair'),
(21, 'polite-society-posters.jpg', 'Three posters with the letters P and S'),
(22, 'golden-brown.jpg',           'Sunny living room with plants and wooden furniture'),
(23, 'featherview.jpg',            'Open travel guide showing a page about Nijo Castle');

INSERT INTO `article` (`id`, `title`, `summary`, `content`, `created`, `category_id`, `member_id`, `image_id`, `published`) VALUES
(1,  'Systemic Brochure', 'Brochure design for a science publication',
     'A science publisher needed a fold-out guide explaining how natural systems connect. Bold yellow pages and simple diagrams make complex ideas easy to follow.',
     '2021-01-29 10:12:00', 1, 2, 1, 1),
(2,  'Forecast', 'Pattern design for an accessories brand',
     'A playful repeating print of handbags for a range of scarves and umbrellas. The soft pink palette works on fabric, packaging and the brand\'s online shop.',
     '2021-02-03 14:30:00', 3, 3, 2, 1),
(3,  'Seascape', 'Photograph for a travel website',
     'Taken at dawn on a still morning, this image captures the quiet calm of the coast. It now welcomes visitors on the home page of a holiday booking site.',
     '2021-02-08 09:45:00', 4, 2, 3, 1),
(4,  'Birds', 'Illustrations for a children\'s picture book',
     'A series of cheerful birds that guide young readers through a story about friendship. Each character was drawn by hand and coloured digitally.',
     '2021-02-15 16:20:00', 3, 3, 4, 1),
(5,  'Swimming Pool', 'Photograph for an architecture magazine',
     'A black and white study of light and reflection at a modern house. The magazine used it to open a feature on homes built around water.',
     '2021-02-22 11:05:00', 4, 2, 5, 1),
(6,  'The Ice Palace', 'Book cover design for a classic novel',
     'A new edition of a much-loved novel called for a cover that felt cold, quiet and mysterious. Frosted lettering sits over a wintry forest scene.',
     '2021-03-01 13:40:00', 1, 2, 6, 1),
(7,  'Micro Dunes', 'Photograph for a desert travel guide',
     'Low evening sun turns tiny ripples of sand into a landscape of their own. The picture opens the chapter on desert walks.',
     '2021-03-06 18:10:00', 4, 3, 7, 1),
(8,  'Snow Search', 'Illustrations for a winter storybook',
     'A child and her dog search for a lost mitten in the snow. Soft pencil lines and a pale palette give the story a hushed, wintry feel.',
     '2021-03-12 10:25:00', 3, 3, 8, 1),
(9,  'Milk Beach Skyline', 'Photograph for a band\'s tour poster',
     'The city skyline seen from the rocks at Milk Beach, faded to give it a dreamy, retro look that matches the band\'s sound.',
     '2021-03-18 15:50:00', 4, 2, 9, 1),
(10, 'Polite Society Mural', 'Line art design for a fashion label',
     'A single continuous teal line creates overlapping shapes for the wall of a new store. The same artwork now appears on tags and bags.',
     '2021-03-24 12:00:00', 3, 1, 10, 1),
(11, 'Milk Beach Album', 'Album cover design for a band',
     'Sleeve artwork for the band\'s debut record, pairing a faded coastal photograph with clean type on a coral background.',
     '2021-03-30 17:35:00', 1, 1, 11, 1),
(12, 'Milk Beach Website', 'Website for a band',
     'A simple site where fans can listen to new tracks, see tour dates and buy the album. It carries the look of the record sleeve onto the screen.',
     '2021-04-04 09:15:00', 2, 2, 12, 1),
(13, 'Wellness App', 'App for a yoga studio',
     'Members can check the class timetable, book a place and get reminders. Large buttons and a calm green colour scheme keep it easy to use.',
     '2021-04-09 14:45:00', 2, 3, 13, 1),
(14, 'Stargazer Website and App', 'Website and app for a music festival',
     'Festival-goers can plan their weekend, see who is playing on each stage and get updates on the day. Works on phones, tablets and desktops.',
     '2021-04-13 11:30:00', 2, 3, 14, 1),
(15, 'Chimney Press Website', 'Website for a book publisher',
     'Readers can browse new titles, read sample chapters and order books. Every page uses generous type so it feels like reading a printed book.',
     '2021-04-17 16:05:00', 2, 2, 15, 1),
(16, 'Polite Society Website', 'Website for a fashion label',
     'Launched in time for the label\'s first fashion show, the site streams the runway live and lets visitors shop the collection afterwards.',
     '2021-04-20 10:40:00', 2, 1, 16, 1),
(17, 'Floral Website', 'Website for a florist',
     'A local florist wanted to take orders online. The design puts large photos of fresh flowers first, with ordering just two clicks away.',
     '2021-04-22 13:15:00', 2, 1, 17, 1),
(18, 'Abandoned Industry', 'Photograph for a magazine feature',
     'Rusting cranes at an old shipyard, photographed for a story about how former industrial land is being turned into parks and homes.',
     '2021-04-23 09:55:00', 4, 2, 18, 1),
(19, 'Chimney Business Cards', 'Stationery design for a publishing company',
     'Business cards, letterheads and envelopes for Chimney Press. Letterpress printing on thick card gives them a crafted feel.',
     '2021-04-23 15:20:00', 1, 2, 19, 1),
(20, 'Stargazer', 'Illustrations for a music festival',
     'A friendly character drawn in a single blue ink appears on posters, wristbands and stage screens across the festival site.',
     '2021-04-24 11:10:00', 3, 3, 20, 1),
(21, 'Polite Society Posters', 'Poster designs for a fashion label',
     'A set of three posters announcing the label\'s new season. The P and S monogram is repeated in pink, teal and charcoal.',
     '2021-04-24 17:45:00', 1, 1, 21, 1),
(22, 'Golden Brown', 'Photograph for an interior design book',
     'Warm afternoon light fills a room full of plants and wooden furniture. The photo sets the mood for a chapter on relaxed living spaces.',
     '2021-04-25 10:30:00', 4, 3, 22, 1),
(23, 'Travel Guide', 'Book design for a series of travel guides',
     'The Featherview travel guides needed a fresh look for their books about Asia. The new layout is clear and compact, so the books look good on a coffee table and still fit in a backpack.',
     '2021-04-25 16:00:00', 1, 1, 23, 1);

-- ------------------------------------------------------------------
-- OPTIONAL: a user account for the site (instead of using root)
-- Remove the -- at the start of the next two lines to use it, then put
-- this username and password in cms/includes/database-connection.php
-- ------------------------------------------------------------------
-- CREATE USER IF NOT EXISTS 'phpbook'@'localhost' IDENTIFIED BY 'change-this-password';
-- GRANT SELECT, INSERT, UPDATE, DELETE ON `phpbook-1`.* TO 'phpbook'@'localhost';
