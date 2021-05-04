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
    _END;

    $query1   = "SELECT * FROM users WHERE email='$email'";
    $result  = $con->query($query1);

    if ($result->num_rows != 1) die("User not found");

    $row1 = $result->fetch_array(MYSQLI_ASSOC);
    $pn  = $row1['permissionNumber'];

    $query2   = "SELECT * FROM permissions WHERE permissionNumber='$pn'";
    $result2  = $con->query($query2);

    $row2 = $result2->fetch_array(MYSQLI_ASSOC);
    $insert  = $row2['inserting'];
    $delete  = $row2['deleting'];
    $update  = $row2['updating'];

    if($insert == 1){
        echo "<a class = 'underlineHover' href = 'supplierForm.php'>INSERT</a><br>";
    }

    if($delete == 1){
        echo "<a class = 'underlineHover' href = 'supplierForm.php'>DELETE</a><br>";
    }

    if($update == 1){
        echo "<a class = 'underlineHover' href = 'supplierForm.php'>UPDATE</a><br>";
    }

    echo <<< _END
                    <a class = "underlineHover" href = "logOut.php" style = "">Log Out</a><br>
                </div>
            </div>
        </div>
        </div>
    </body>
</html>
_END;
?>