-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 31, 2017 at 12:47 PM
-- Server version: 5.6.35
-- PHP Version: 7.1.1

-- Database: `yii2_mlm`
--

-- --------------------------------------------------------

--
-- Table structure for table `participant`
--

CREATE TABLE `participant` (
  `id` int(11) UNSIGNED NOT NULL,
  `lft` int(11) NOT NULL,
  `rgt` int(11) NOT NULL,
  `depth` smallint(6) NOT NULL
) ENGINE=InnoDB ;

-- --------------------------------------------------------

--
-- Table structure for table `rwd_basic`
--

CREATE TABLE `rwd_basic` (
  `id` int(10) UNSIGNED NOT NULL,
  `usr_rewarded_id` int(11) UNSIGNED NOT NULL,
  `subject_id` int(11) NOT NULL,
  `subject_type` enum('subject') NOT NULL,
  `value` float NOT NULL,
  `level` int(11) NOT NULL,
  `status` enum('pending','approved','denied','paid') NOT NULL DEFAULT 'pending',
  `is_locked` tinyint(1) NOT NULL DEFAULT '0',
  `is_final` tinyint(1) NOT NULL DEFAULT '1',
  `approved_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB ;

-- --------------------------------------------------------

--
-- Table structure for table `rwd_custom`
--

CREATE TABLE `rwd_custom` (
  `id` int(10) UNSIGNED NOT NULL,
  `usr_rewarded_id` int(11) UNSIGNED NOT NULL,
  `subject_id` int(11) NOT NULL,
  `subject_type` enum('subject') NOT NULL,
  `value` float NOT NULL,
  `status` enum('pending','approved','denied','paid') NOT NULL DEFAULT 'pending',
  `is_locked` tinyint(1) NOT NULL,
  `approved_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB ;

-- --------------------------------------------------------

--
-- Table structure for table `rwd_extra`
--

CREATE TABLE `rwd_extra` (
  `id` int(10) UNSIGNED NOT NULL,
  `usr_rewarded_id` int(11) UNSIGNED NOT NULL,
  `rwd_basic_id` int(10) UNSIGNED NOT NULL,
  `value` float NOT NULL,
  `status` enum('pending','approved','denied','paid') NOT NULL DEFAULT 'pending',
  `is_locked` tinyint(1) NOT NULL,
  `approved_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL
) ENGINE=InnoDB ;

-- --------------------------------------------------------

--
-- Table structure for table `subject`
--

CREATE TABLE `subject` (
  `id` int(10) UNSIGNED NOT NULL,
  `participant_id` int(11) UNSIGNED DEFAULT NULL,
  `amount` float NOT NULL,
  `amount_vat` float DEFAULT 0
) ENGINE=InnoDB ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `participant`
--
ALTER TABLE `participant`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rwd_basic`
--
ALTER TABLE `rwd_basic`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rwd_custom`
--
ALTER TABLE `rwd_custom`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rwd_extra`
--
ALTER TABLE `rwd_extra`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subject`
--
ALTER TABLE `subject`
  ADD PRIMARY KEY (`id`);

