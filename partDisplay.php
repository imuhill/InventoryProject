<?php
    require_once 'loginfo.php';

    session_start();

    if(isset($_SESSION['firstname']))
    {
        $fname = $_SESSION['firstname'];
        $lname = $_SESSION['lastname'];

        echo "Welcome back $fname $lname.<br>This is the product form page!<br>";
    }

    $con = new mysqli($hn, $username, $password, $db);
    
    //check connection to database
    if($con -> connect_error)
        die("Error connecting to DB" . $con -> connect_error);

    //Check if the page is loaded because the user submitted a Delete Form
    if(!empty($_POST['delete']) && !empty($_POST['pline'])){
        $pline = $_POST['pline'];
        $query = "DELETE FROM productlines WHERE productLine = '$pline'";
        $result = $con->query($query);
        
        if(!result) echo "Unable to delete";
    }

    //Check if the page is loaded because the user is adding a product
    if(!empty($_POST['productLine']) && !empty($_POST['productDesc'])){
        $pline = get_post($con, $_POST['productLine']);
        $pdesc = get_post($con, $_POST['productDesc']);
        $query = "INSERT INTO productlines (productLine, textDescription) VALUES ('$pline', '$pdesc')";

        $result = $con->query($query);

        if(!result) echo "Unable to insert";
    }

    //create HTML file body
    echo <<<_END
        <html>
            <head>
                <link rel = "stylesheet" type = "text/css" href = "table.css" media = "screen"/>
            </head>

            <body>
            <form action = "productForm.php" method = "post">
                <pre>
                    Product Line: <input type = "text" name = 'productLine'>
                    Product Des.: <input type = "text" name = 'productDesc'>
                    <input type = "submit" value = "ADD PRODUCT">
                </pre>
            </form>
    _END;

    //here we will create the table
    $query = "SELECT * FROM productlines";
    $result = $con->query($query);
    if(!$result)
        die("Error executing the query");

    $rows = $result->num_rows;

    echo <<<_END
        <div class = "table-users">
            <div class = "header"> Product Lines </div>
            <table cellspacing = "0">
                <tr>
                    <td> Product Line </td>
                    <td> Description </td>
                    <td> Action </td>
                </tr>
    _END;

    for ($j = 0; $j < $rows; $j++)
    {
        $row = $result->fetch_array(MYSQLI_BOTH);

        $v1 = htmlspecialchars($row['productLine']);
        $v2 = htmlspecialchars($row['textDescription']);

        echo <<<_END
            <tr>
                <td>$v1</td>
                <td>$v2</td>
                <td>
                    <form action = 'productForm.php' method = 'post'>
                        <input type = 'hidden' name = 'delete' value = 'yes'>
                        <input type = 'hidden' name = 'pline' value = '$v1'>
                        <input type = 'submit' value = 'DELETE RECORD'>
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

    function get_post($con, $var){
        return $con->real_escape_string($var);
    }
?>