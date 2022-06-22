-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 172.17.0.2
-- Generation Time: Nov 12, 2015 at 11:49 PM
-- Server version: 5.7.9
-- PHP Version: 5.6.15

-- SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
-- SET time_zone = "+00:00";



--
-- Database: `stalks`
--

-- --------------------------------------------------------

--
-- Table structure for table `dailyLogs`
--

CREATE TABLE `dailyLogs` (
  `logID` int(11) NOT NULL,
  `userID` varchar(80) NOT NULL,
  `date` date NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `hallOfFame`
--

CREATE TABLE `hallOfFame` (
  `id` int(11) NOT NULL,
  `userID` varchar(80) NOT NULL,
  `username` varchar(80) NOT NULL,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `gain` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `portfolios`
--

CREATE TABLE `portfolios` (
  `id` int(11) NOT NULL,
  `userID` varchar(80) NOT NULL,
  `ticker` varchar(10) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` varchar(80) NOT NULL,
  `username` varchar(80) NOT NULL,
  `firstName` text NOT NULL,
  `lastName` text NOT NULL,
  `turnips` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dailyLogs`
--
ALTER TABLE `dailyLogs`
  ADD PRIMARY KEY (`logID`),
  ADD KEY `log_userID` (`userID`);

--
-- Indexes for table `portfolios`
--
ALTER TABLE `portfolios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `portfolio_userID` (`userID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dailyLogs`
--
ALTER TABLE `dailyLogs`
  MODIFY `logID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `portfolios`
--
ALTER TABLE `portfolios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `dailyLogs`
--
-- ALTER TABLE `dailyLogs`
 --  ADD CONSTRAINT `dailyLog_userID_key` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `portfolios`
--
-- ALTER TABLE `portfolios`
 --  ADD CONSTRAINT `portfolio_userID` FOREIGN KEY (`userID`) REFERENCES `users` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE;
