use InventoryDB;

/*DROP TABLE IF EXISTS logging;*/
DROP TABLE IF EXISTS partdetails;
DROP TABLE IF EXISTS parts;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS permissions;

create table permissions(
    permissionNumber INT,
    reading BOOLEAN NOT NULL,
    inserting BOOLEAN NOT NULL,
    deleting BOOLEAN NOT NULL,
    updating BOOLEAN NOT NULL,
    PRIMARY KEY (permissionNumber)
);

create table users(
    userNumber INT AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    password VARCHAR(35) NOT NULL,
    phone VARCHAR(20) DEFAULT NULL,
    permissionNumber INT DEFAULT 0,
    PRIMARY KEY (userNumber),
    CONSTRAINT hasPermissions
    FOREIGN KEY (permissionNumber)
    REFERENCES permissions (permissionNumber)
        ON DELETE CASCADE
);

create table suppliers(
    supplier VARCHAR(50), 
    textDescription VARCHAR(4000) NOT NULL,
    image VARCHAR(150) DEFAULT NULL,
    PRIMARY KEY (supplier)
);

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
    qualityCheck VARCHAR(4000) DEFAULT NULL,
    PRIMARY KEY (partCode)
);

create table partdetails(
    supplier VARCHAR(50),
    partCode VARCHAR(15),
    PRIMARY KEY (supplier, partCode),
    CONSTRAINT soldBy
    FOREIGN KEY (supplier)
    REFERENCES suppliers (supplier)
        ON DELETE CASCADE,
    CONSTRAINT partOf
    FOREIGN KEY (partCode)
    REFERENCES parts (partCode)
        ON DELETE CASCADE
);

INSERT INTO permissions(
    permissionNumber, reading, inserting, deleting, updating)
    VALUES(0, 0, 0, 0, 0);

INSERT INTO permissions(
    permissionNumber, reading, inserting, deleting, updating)
    VALUES(1, 1, 0, 0, 0);

INSERT INTO permissions(
    permissionNumber, reading, inserting, deleting, updating)
    VALUES(2, 1, 0, 0, 1);

INSERT INTO permissions(
    permissionNumber, reading, inserting, deleting, updating)
    VALUES(3, 1, 0, 1, 0);

INSERT INTO permissions(
    permissionNumber, reading, inserting, deleting, updating)
    VALUES(4, 1, 0, 1, 1);

INSERT INTO permissions(
    permissionNumber, reading, inserting, deleting, updating)
    VALUES(5, 1, 1, 0, 0);

INSERT INTO permissions(
    permissionNumber, reading, inserting, deleting, updating)
    VALUES(6, 1, 1, 0, 1);

INSERT INTO permissions(
    permissionNumber, reading, inserting, deleting, updating)
    VALUES(7, 1, 1, 1, 0);

INSERT INTO permissions(
    permissionNumber, reading, inserting, deleting, updating)
    VALUES(8, 1, 1, 1, 1);

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

alter table users modify column password VARCHAR(100);