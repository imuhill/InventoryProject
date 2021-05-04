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
    }

    echo <<< _END
    <html>
    <head>
        <link rel="stylesheet" type="text/css" href="http://localhost/InventoryProject/CSS/inventory.css" media="screen"/>
    </head>

    <style>
        .bgimg {
        background-image: url('http://localhost/InventoryProject/images/squirrel.jpg');
        min-height: 100%;
        background-position: center;
        background-size: cover;
        }
    </style>

    <body>
        <div class = "bgimg">
        <div class = "wrapper fadeInDown">
            <div id = "formContent">
                <h2 class="active"> Landing Page </h2>

                <div class="fadeIn first">
                <img src="http://localhost/InventoryProject/images/smile.jpg" id="icon" alt="Squirrel Icon" />
                </div>

                <div id = "login" class = "fadeIn second">
                    <p><br>Hello, <b>$fname $lname</b>, welcome to the Landing Page.<br>Please select what action you would like to do.</p>
                </div>
                <div id="formFooter" class = "fadeIn third">
                    <a class = "underlineHover" href = "http://localhost/InventoryProject/HTML/homePage.html" style = "">Log Out</a><br>
    _END;

        if($insert === 1){
            echo "<a class = 'underlineHover' href = 'supplierForm.php'>Supplier Form</a><br>";
        }

        if($delete === 1){
            
        }

        if($update === 1){
            
        }

    echo <<< _END
                    <a class = "underlineHover" href = "supplierForm.php">Supplier Form</a><br>
                    <a class = "underlineHover" href = "partDisplay.php">Part Display</a><br>

                </div>
            </div>
        </div>
        </div>
    </body>
</html>
_END;
?>