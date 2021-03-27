show databases;

use MaskDB;

select database();

show tables;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orderdetails;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS productlines;

create table `customers`(
    `customerNumber` INT AUTO_INCREMENT, 
    `customerName` VARCHAR(50) NOT NULL, 
    `contactLastName` VARCHAR(50) NOT NULL, 
    `contactFirstName` VARCHAR(50) NOT NULL, 
    `phone` VARCHAR(20) NOT NULL, 
    `addressLine1` VARCHAR(50) NOT NULL, 
    `addressLine2` VARCHAR(50) DEFAULT NULL, 
    `city` VARCHAR(50) NOT NULL, 
    `state` VARCHAR(50) DEFAULT NULL, 
    `postalCode` VARCHAR(15) DEFAULT NULL, 
    `country` VARCHAR(50) NOT NULL, 
    `salesRepEmployeeNumber` INT DEFAULT NULL, 
    `creditLimit` DECIMAL(10,2) DEFAULT NULL,
    PRIMARY KEY (customerNumber));

create table payments(
    checkNumber VARCHAR(50), 
    paymentDate DATE NOT NULL, 
    amount DECIMAL(10,2) NOT NULL,
    customerNumber INT NOT NULL,
    PRIMARY KEY (checkNumber),
    CONSTRAINT payedBy
    FOREIGN KEY (customerNumber)
    REFERENCES customers (customerNumber)
);

create table orders(
    orderNumber INT AUTO_INCREMENT, 
    orderDate DATE NOT NULL, 
    requiredDate DATE NOT NULL, 
    shippedDate DATE DEFAULT NULL, 
    status VARCHAR(15) NOT NULL, 
    comments TEXT DEFAULT NULL,
    customerNumber INT(11) NOT NULL,
    PRIMARY KEY (orderNumber),
    CONSTRAINT orderedFrom
    FOREIGN KEY (customerNumber)
    REFERENCES customers (customerNumber)
        ON DELETE CASCADE
);

create table `productlines`(
    `productLine` VARCHAR(50), 
    `textDescription` VARCHAR(4000) NOT NULL, 
    `htmlDescription` MEDIUMTEXT DEFAULT NULL, 
    `image` MEDIUMBLOB DEFAULT NULL,
    PRIMARY KEY (productLine));

create table products(
    productCode VARCHAR(15), 
    productName VARCHAR(70) NOT NULL, 
    productScale VARCHAR(10) NOT NULL, 
    productVendor VARCHAR(50) NOT NULL, 
    productDescription TEXT DEFAULT NULL, 
    quantityInStock SMALLINT NOT NULL, 
    buyPrice DECIMAL(10,2) NOT NULL, 
    MSRP DECIMAL(10,2) NOT NULL,
    productLine VARCHAR(50) NOT NULL,
    PRIMARY KEY (productCode),
    CONSTRAINT soldBy
    FOREIGN KEY (productLine)
    REFERENCES productlines (productLine)
        ON DELETE CASCADE
);

create table orderdetails(
    orderNumber INT(11) NOT NULL,
    productCode VARCHAR(15) NOT NULL,
    quantityOrdered INT(11) NOT NULL,
    priceEach DECIMAL(10,2) NOT NULL,
    orderLineNumber SMALLINT(6) NOT NULL,
    PRIMARY KEY (orderNumber, productCode),
    KEY productCode (productCode),
    CONSTRAINT containsA
    FOREIGN KEY (orderNumber)
    REFERENCES orders (orderNumber),
    CONSTRAINT hasA
    FOREIGN KEY (productCode)
    REFERENCES products (productCode)
        ON DELETE CASCADE
);
