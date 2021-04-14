<?php
      require_once 'logininfo.php';
      $con = new mysqli($hn, $username, $password, $db);
  
      if($con->connect_error){
          die("Error connecting to DB". $con->connect_error);
      }

      $firstname = $_POST['FirstName'];
      $lastname = $_POST['LastName'];
      $email = $_POST['email'];
      $password = $_POST['password'];
      $phone = $_POST['phone'];
      $hash = password_hash($password, PASSWORD_DEFAULT);

      $query = "INSERT INTO users (FirstName, LastName, email, password, phone) VALUES ('$firstName', '$lastName', '$email', '$password', '$phone')";
      $result = $con->query($query);

      add_user($con, $firstname, $lastname, $email, $hash, $phone);


      function add_user($con, $fn, $ln, $em, $pw, $ph){
        $stmt = $con->prepare('INSERT INTO users VALUES(?, ?, ?, ?)');

        $stmt->bind_param("ssss", $fn, $ln, $un, $pw);
        $stmt->execute();
    }

    //create table
    $query = "SELECT * FROM users";
    $result = $con->query($query);
    if(!$result)
        die("Error executing the query.");
    $rows = $result->num_rows;

    echo <<< _END
       <div class = "table-users">
       <div class = "header"> Register Information Form </div>
       _END;

       
       //create HTML body
       echo <<< _END

       <html>
           <head>
               <link rel = "stylesheet" type = "text/css" href = "table.css" media = "screen"/>
           </head>
           <body>
           <form action="register.php" method="post">
               <pre>
                   First Name: <input type="text" name="FirstName" required>

                   Last Name: <input type="text" name="LastName" required>

                   Email: <input type="text" name="email" required>

                   Password: <input type="text" name="password" required>

                   Phone Number: <input type="text" name="phone">

             <input type="submit" value="SIGN UP">
                </pre>
            </form>
       _END;
?>
