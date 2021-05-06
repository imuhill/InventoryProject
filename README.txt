This is the Inventory Management System created for Mr. Lester Leonares during the Spring 2021 Semester at HBU.
This project was created and designed by Brian Davis and I'munique Hill.

Here are the basic instructions for setting up the database for this to work:
    1. Place the GitHub repository in the http://localhost directory (also called /var/www/html)
    2. Follow steps in Dr. Zaki's instructions for setting up Ubuntu and WSL. (https://mzaki.gitbook.io/web-development/part-1-setting-up-lamp-on-wsl)
    3. After Part 1 has been completed, continue to Part 2 with few modified commands. (https://mzaki.gitbook.io/web-development/part-2-mysql-database-setup)
        Run these commands instead (starting in ubuntu):
        a. sudo mysql -u root -p
        b. CREATE USER 'inventorydb_sa'@'%' IDENTIFIED BY 'P4ssw0rd';
        c. GRANT ALL PRIVILEGES ON *.* TO 'inventorydb_sa'@'%' WITH GRANT OPTION;
        d. FLUSH PRIVILEGES;
        e. exit
    4. Proceed to Part 3 with modified commands. (https://mzaki.gitbook.io/web-development/creating-our-mask-database)
        Run these commands instead (starting in ubuntu):
        a. sudo mysql -u inventorydb_sa -p
        b. CREATE DATABASE InventoryDB;
        c. SHOW databases;
        d. exit
        e. mysql -u maskdb_sa -p < /var/www/html/InventoryProject/IM_CrtTables.sql
    5. Make sure to install the "Remote - WSL" extension for VS Code
    6. Now cd into the repository and open it in VisualStudio Code
        a. cd /var/www/html/InventoryProject/
        b. code .
    7. Once inside, go to the terminal and run this command to begin using the web application:
        a. sensible-browser http://localhost/InventoryProject/HTML/homePage.html

The Superuser is lleonares@hbu.edu with password root.