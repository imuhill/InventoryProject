<?php
    require_once 'loginfo.php';
    $con = new mysqli($hn, $username, $password, $db);
    
    //echo "$hn, $db, $username, $password";
    if($con -> connect_error)
        die("Error connecting to DB" . $con -> connect_error);

    echo "<p>Connection Successful</p>";
    
    $query = "SELECT * FROM productlines";
    $result = $con -> query($query);
    if(!$result)
        die("Error executing the query");

    $rows = $result -> num_rows;
    for ($j = 0; $j < $rows; $j++)
    {
        $row = $result -> fetch_array(MYSQLI_NUM);
        echo 'Product Line: ' . htmlspecialchars($row[0]) . '<br>';
        echo 'Product Description: ' . htmlspecialchars($row[2]) . '<br>';
        echo '<br>';

        /*$row = $result -> fetch_array(MYSQLI_ASSOC);
        echo 'Product Line:' . htmlspecialchars($row['productLine']) . '<br>';
        echo 'Product Description:' . htmlspecialchars($row['htmlDescription']) . '<br>';
        */
    }

    $result -> close();
    $con -> close();
?>