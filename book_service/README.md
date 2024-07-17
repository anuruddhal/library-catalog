```
docker run -d -e MYSQL_ROOT_PASSWORD=my-secret-pw  -p 3306:3306 mysql:8.0
```

```
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

-- Insert Authors
INSERT INTO `Author` (`name`) VALUES 
('J.K. Rowling'),
('George Orwell'),
('Jane Austen'),
('Mark Twain'),
('J.R.R. Tolkien'),
('F. Scott Fitzgerald'),
('Leo Tolstoy'),
('Herman Melville'),
('Charles Dickens'),
('Mary Shelley');

-- Insert Books
INSERT INTO `Book` (`title`, `isbn`, `year`, `genre`, `authorId`) VALUES 
('Harry Potter and the Sorcerer\'s Stone', '978-0439708180', 1997, 'Fantasy', 1),
('Harry Potter and the Chamber of Secrets', '978-0439064873', 1998, 'Fantasy', 1),
('1984', '978-0451524935', 1949, 'Dystopian', 2),
('Animal Farm', '978-0451526342', 1945, 'Political Satire', 2),
('Pride and Prejudice', '978-1503290563', 1813, 'Romance', 3),
('Sense and Sensibility', '978-1503290310', 1811, 'Romance', 3),
('Adventures of Huckleberry Finn', '978-0486280615', 1884, 'Adventure', 4),
('The Adventures of Tom Sawyer', '978-0486400778', 1876, 'Adventure', 4),
('The Hobbit', '978-0345339683', 1937, 'Fantasy', 5),
('The Lord of the Rings: The Fellowship of the Ring', '978-0547928210', 1954, 'Fantasy', 5);


-- Insert Digital Copies
INSERT INTO `DigitalCopy` (`fileUrl`, `format`, `bookId`) VALUES 
('https://example.com/harry_potter_sorcerers_stone.pdf', 'PDF', 1),
('https://example.com/harry_potter_chamber_secrets.epub', 'EPUB', 2),
('https://example.com/1984.epub', 'EPUB', 3),
('https://example.com/animal_farm.pdf', 'PDF', 4),
('https://example.com/pride_and_prejudice.pdf', 'PDF', 5);


```



