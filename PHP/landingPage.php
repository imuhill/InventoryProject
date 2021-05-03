<?php // authenticate.php
    require_once 'loginfo.php';
    $con = new mysqli($hn, $username, $password, $db);

    if($con->connect_error){
        die("Error connecting to DB". $con->connect_error);
    }

    session_start();
    if(isset($_SESSION['firstname']))
    {
        $fname = $_SESSION['firstname'];
        $lname = $_SESSION['lastname'];
        $email = $_SESSION['email'];

        echo "<br>Welcome $fname $lname to the Landing Page.<br>Please select what action you would like to do.<br>";
    }

    echo <<< _END
    <html>
    <head>
        <link rel="stylesheet" type="text/css" href="http://localhost/InventoryProject/CSS/inventory.css" media="screen"/>
    </head>

    <body>

    <div class="wrapper fadeInDown">
    <div id="formContent">
        <h2 class="active"> Landing Page </h2>

        <!-- Icon -->
        <div class="fadeIn first">
        <img src="http://localhost/InventoryProject/images/squirrel.jpg" id="icon" alt="Squirrel Icon" />
        </div>

        <!-- Login Form -->
        <div id = "login">
            <a class="underlineHover" href = "http://localhost/InventoryProject/HTML/homePage.html">Log Out</a><br>
            <a class="underlineHover" href = "supplierForm.php">Supplier Form</a><br>
            <a class="underlineHover" href = "partDisplay.php">Part Display</a><br>
        </div>
    </div>
    </div>

    </body>
    </html>
    _END;
?>