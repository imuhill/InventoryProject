use MaskDB;

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orderdetails;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS partlines;

create table users(
    userNumber INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(20) NOT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (customerNumber));

create table partlines(
    partLine VARCHAR(50), 
    textDescription VARCHAR(4000) NOT NULL, 
    htmlDescription MEDIUMTEXT DEFAULT NULL, 
    image VARCHAR(150) DEFAULT NULL,
    PRIMARY KEY (partLine));

create table parts(
    partCode VARCHAR(15), 
    partName VARCHAR(70) NOT NULL,
    partStorage VARCHAR(50) DEFAULT NULL, 
    partDescription TEXT DEFAULT NULL,
    semester VARCHAR(30) NOT NULL,
    currentStock SMALLINT NOT NULL,
    initialStock SMALLINT NOT NULL,
    finalStock SMALLINT DEFAULT NULL,
    perStudent SMALLINT NOT NULL,
    buyPrice DECIMAL(10,2) NOT NULL,
    partLine VARCHAR(50) NOT NULL,
    qualityCheck VARCHAR(4000) DEFAULT NULL,
    PRIMARY KEY (partCode),
    CONSTRAINT soldBy
    FOREIGN KEY (partLine)
    REFERENCES partlines (partLine)
        ON DELETE CASCADE
);

/*create table logging(
    userNumber INT(11) NOT NULL,
    partCode VARCHAR(15) NOT NULL,
    quantityModified INT(11) NOT NULL,
    logDescription VARCHAR(400) NOT NULL,
    actionOf VARCHAR(40) NOT NULL,
    PRIMARY KEY (userNumber, partCode),
    KEY partCode (partCode),
    CONSTRAINT fromA
    FOREIGN KEY (userNumber)
    REFERENCES users (userNumber),
    CONSTRAINT containsA
    FOREIGN KEY (partCode)
    REFERENCES parts (partCode)
        ON DELETE CASCADE
);*/
