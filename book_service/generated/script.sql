-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS `DigitalCopy`;
DROP TABLE IF EXISTS `Book`;
DROP TABLE IF EXISTS `Author`;

CREATE TABLE `Author` (
	`id` INT AUTO_INCREMENT,
	`name` VARCHAR(191) NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `Book` (
	`id` INT AUTO_INCREMENT,
	`title` VARCHAR(191) NOT NULL,
	`isbn` VARCHAR(191) NOT NULL,
	`year` INT NOT NULL,
	`genre` VARCHAR(191) NOT NULL,
	`authorId` INT NOT NULL,
	FOREIGN KEY(`authorId`) REFERENCES `Author`(`id`),
	PRIMARY KEY(`id`)
);

CREATE TABLE `DigitalCopy` (
	`id` INT AUTO_INCREMENT,
	`fileUrl` VARCHAR(191) NOT NULL,
	`format` VARCHAR(191) NOT NULL,
	`bookId` INT UNIQUE NOT NULL,
	FOREIGN KEY(`bookId`) REFERENCES `Book`(`id`),
	PRIMARY KEY(`id`)
);


