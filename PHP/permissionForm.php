<?php
    require_once 'loginfo.php';

    session_start();

    if(isset($_SESSION['firstname']))
    {
        $fname = $_SESSION['firstname'];
        $lname = $_SESSION['lastname'];

        echo "Welcome back $fname $lname.<br>This is the Permission Update Form!<br>";
    }

    $con = new mysqli($hn, $username, $password, $db);
    
    //check connection to database
    if($con -> connect_error)
        die("Error connecting to DB" . $con -> connect_error);

    //Check if the page is loaded because the user is adding a product
    if(!empty($_POST['update'])){
        $permNumber = sanitizeMySQL($con, $_POST['pn']);
        $uNum = sanitizeMySQL($con, $_POST['un']);
        $query = "UPDATE users SET permissionNumber = $permNumber WHERE userNumber = $uNum;";
        echo "$query";

        $result = $con->query($query);
        echo "<br>Result: $result<br>";

        if(!result) echo "Unable to insert";
    }

    //create HTML file body
    echo <<<_END
        <html>
            <head>
                <link rel = "stylesheet" type = "text/css" href = "http://localhost/InventoryProject/CSS/table.css" media = "screen"/>
            </head>

            <body>
    _END;

    //here we will create the table
    $query = "SELECT * FROM users";
    $result = $con->query($query);
    if(!$result)
        die("Error executing the query");

    $rows = $result->num_rows;

    echo <<<_END
        <div class = "table-users">
            <div class = "header"> Permissions </div>
            <table cellspacing = "0">
                <tr>
                    <td> First Name </td>
                    <td> Last Name </td>
                    <td> Email </td>
                    <td> Phone Number </td>
                    <td> Permission Number </td>
                    <td></td>
                </tr>
    _END;

    for ($j = 0; $j < $rows; $j++)
    {
        $row = $result->fetch_array(MYSQLI_BOTH);

        $v1 = htmlspecialchars($row['FirstName']);
        $v2 = htmlspecialchars($row['LastName']);
        $v3 = htmlspecialchars($row['email']);
        $v4 = htmlspecialchars($row['phone']);
        $v5 = htmlspecialchars($row['permissionNumber']);
        $v6 = htmlspecialchars($row['userNumber']);

        echo <<<_END
            <tr>
                <td>$v1</td>
                <td>$v2</td>
                <td>$v3</td>
                <td>$v4</td>
                <td><input type = "text" required name = 'pn' value = $v5></td>
                <td>
                    <form action = 'permissionForm.php' method = 'post'>
                        <input type = 'hidden' name = 'update' value = 'yes'>
                        <input type = 'hidden' name = 'un' value = '$v6'>
                        <input type = 'submit' value = 'UPDATE PERMISSIONS'>
                    </form>
                </td>
            </tr>
        _END;
    }

    echo <<<_END
        </table>
        </body>
        </html>
    _END;

    $result->close();
    $con->close();

    function sanitizeString($var)
    {
        if(get_magic_quotes_gpc())
            $var = stripslashes($var);
        $var = strip_tags($var);
        $var = htmlentities($var);
        return $var;
    }

    function sanitizeMySQL($con, $var)
    {
        $var = $con->real_escape_string($var);
        $var = sanitizeString($var);
        return $var;
    }

    function get_post($con, $var){
        return $con->real_escape_string($var);
    }
?>