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

INSERT INTO customers(
    customerName, contactLastName, contactFirstName, phone, addressLine1, city, country)
    VALUES('Deloris', 'Jaki', 'Mary-Ann', '281-652-5555', '1352 Somewhere Rd.', 'Nowhere', 'United States of America');

INSERT INTO customers(
    customerName, contactLastName, contactFirstName, phone, addressLine1, city, country)
    VALUES('Francis', 'Cilantro', 'Frankie', '578-124-8448', '44 Vocal Blvd.', 'Paris', 'United States of America');

INSERT INTO customers(
    customerName, contactLastName, contactFirstName, phone, addressLine1, city, country)
    VALUES('Johnny', 'Piper', 'John', '903-147-7794', '556 Brookshire Ln.', 'White Oak', 'United States of America');

INSERT INTO customers(
    customerName, contactLastName, contactFirstName, phone, addressLine1, city, country)
    VALUES('Stevie', 'Stevens', 'Joan', '281-335-5515', '423 Wonder Cir.', 'Athens', 'United States of America');

INSERT INTO customers(
    customerName, contactLastName, contactFirstName, phone, addressLine1, city, country)
    VALUES('Boid', 'Slicks', 'Dennard', '739-110-8700', '5562 Oiler St.', 'Kilgore', 'United States of America');

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

INSERT INTO payments(
    checkNumber, paymentDate, amount, customerNumber)
    VALUES('10100', '2020-11-5', 10.82, 1);

INSERT INTO payments(
    checkNumber, paymentDate, amount, customerNumber)
    VALUES('10101', '2020-10-16', 14.49, 2);

INSERT INTO payments(
    checkNumber, paymentDate, amount, customerNumber)
    VALUES('10102', '2020-12-1', 25.47, 3);

INSERT INTO payments(
    checkNumber, paymentDate, amount, customerNumber)
    VALUES('10103', '2021-01-28', 8.94, 4);

INSERT INTO payments(
    checkNumber, paymentDate, amount, customerNumber)
    VALUES('10104', '2020-09-14', 58.22, 5);

INSERT INTO payments(
    checkNumber, paymentDate, amount, customerNumber)
    VALUES('10105', '2020-10-21', 108.24, 4);

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

INSERT INTO orders(
    orderDate, requiredDate, status, customerNumber)
    VALUES('2020-11-05', '2020-11-19', 'delivered', 1);

INSERT INTO orders(
    orderDate, requiredDate, status, customerNumber)
    VALUES('2020-10-16', '2020-10-30', 'delivered', 2);

INSERT INTO orders(
    orderDate, requiredDate, status, customerNumber)
    VALUES('2020-12-01', '2020-12-15', 'delayed', 3);

INSERT INTO orders(
    orderDate, requiredDate, status, customerNumber)
    VALUES('2021-01-28', '2021-02-11', 'shipped', 4);

INSERT INTO orders(
    orderDate, requiredDate, status, customerNumber)
    VALUES('2020-09-14', '2020-09-28', 'delivered', 5);

INSERT INTO orders(
    orderDate, requiredDate, status, customerNumber)
    VALUES('2020-10-21', '2020-11-04', 'delivered', 4);

create table `productlines`(
    `productLine` VARCHAR(50), 
    `textDescription` VARCHAR(4000) NOT NULL, 
    `htmlDescription` MEDIUMTEXT DEFAULT NULL, 
    `image` MEDIUMBLOB DEFAULT NULL,
    PRIMARY KEY (productLine));

INSERT INTO productlines(
    productLine, textDescription, htmlDescription)
    VALUES ('Under Armour', 'Sports mask', 'breathable mask for exercising');

INSERT INTO productlines(
    productLine, textDescription, htmlDescription)
    VALUES ('Nike', 'Active masks', 'masks for active children and adults');

INSERT INTO productlines(
    productLine, textDescription, htmlDescription)
    VALUES ('Gucci', 'Luxury mask', 'gold-hemmed high-end mask');

INSERT INTO productlines(
    productLine, textDescription, htmlDescription)
    VALUES ('Vera Bradley', 'Womens quilted mask', 'simple, elegant quilted mask for women');

INSERT INTO productlines(
    productLine, textDescription, htmlDescription)
    VALUES ('Walmart', 'Everyday mask', 'cheap mask for every day use');

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

INSERT INTO products(
    productCode, productName, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP, productLine)
    VALUES ('100110', 'UA Sports Mask', '0.1 lbs', 'Under Armour', 'Sports mask', 2000, 1.75, 4.99, 'Under Armour');

INSERT INTO products(
    productCode, productName, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP, productLine)
    VALUES ('100111', 'Nike Childrens Masks (3 ct)', '0.2 lbs', 'Nike', 'Active childrens masks', 2500, 2.25, 7.99, 'Nike');

INSERT INTO products(
    productCode, productName, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP, productLine)
    VALUES ('100112', 'GG Golden Mask', '0.5 lbs', 'Gucci', 'Luxury mask', 4, 25.00, 54.99, 'Gucci');

INSERT INTO products(
    productCode, productName, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP, productLine)
    VALUES ('100113', 'VB Quilted Mask', '0.1 lbs', 'Vera Bradley', 'Womens quilted mask', 1800, 2.50, 6.99, 'Vera Bradley');

INSERT INTO products(
    productCode, productName, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP, productLine)
    VALUES ('100114', 'Disposable Masks (100 ct)', '1.2 lbs', 'Walmart', 'Everyday mask', 5000, 5.99, 29.99, 'Walmart');

INSERT INTO products(
    productCode, productName, productScale, productVendor, productDescription, quantityInStock, buyPrice, MSRP, productLine)
    VALUES ('100115', 'Nike Adult Masks (2 ct)', '0.3 lbs', 'Nike', 'Active adult masks', 3500, 2.75, 9.99, 'Nike');

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

INSERT INTO orderdetails(
    orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
    VALUES(1, '100110', 2, 4.99, 2040);

INSERT INTO orderdetails(
    orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
    VALUES(2, '100113', 2, 6.99, 2041);

INSERT INTO orderdetails(
    orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
    VALUES(3, '100111', 3, 7.99, 2042);

INSERT INTO orderdetails(
    orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
    VALUES(4, '100114', 3, 2.99, 2043);

INSERT INTO orderdetails(
    orderNumber, productCode, quantityOrdered, priceEach, orderLineNumber)
    VALUES(5, '100112', 1, 54.99, 2044);

/*One
SELECT * 
    FROM orders 
    WHERE orderDate >= '2020-1-1' AND orderDate < '2021-1-1'
    ORDER BY orderDate ASC;

/*Two
SELECT * 
    FROM payments
    WHERE amount > 100;

/*Three
SELECT * 
    FROM products
    WHERE quantityInStock > 5
    ORDER BY productName ASC;

/*Four
SELECT cu.customerNumber, cu.customerName, COUNT(*) NumberOfOrders, cu.contactLastName, cu.contactFirstName, cu.phone, cu.addressLine1, cu.city, cu.country 
    FROM customers cu, orders od
    WHERE cu.customerNumber = od.customerNumber
    GROUP BY cu.customerNumber
    ORDER BY NumberOfOrders DESC;

/*Five
SELECT pl.productLine, COUNT(*) TotalProducts, pl.textDescription
    FROM productlines pl, products pr
    WHERE pl.productLine = pr.productLine
    GROUP BY productLine
    ORDER BY productLine;

/*Six     
SELECT productCode, (quantityOrdered * priceEach) TotalSales
    FROM orderdetails
    ORDER BY TotalSales DESC;
    */
