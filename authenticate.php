<?php // authenticate.php
  require_once 'loginfo.php';
  $con = new mysqli($hn, $username, $password, $db);

  //echo "$hn, $db, $username, $password";
  if($con->connect_error){
      die("Error connecting to DB". $con->connect_error);
  }

  if(!empty($_POST['login']) && !empty($_POST['pswd']))
  {
    $un_temp = sanitizeMySQL($con, $_POST['login']);   //note the login needs to be sanitized first .. very important
    $pw_temp = sanitizeMySQL($con, $_POST['pswd']);
 
    $query   = "SELECT * FROM users WHERE username='$un_temp'";
    $result  = $con->query($query);

    if ($result->num_rows != 1) die("User not found");
    
    $row = $result->fetch_array(MYSQLI_ASSOC);
    $fn  = $row['firstname'];
    $ln  = $row['lastname'];
    $un  = $row['username'];
    $pw  = $row['password'];
      
    if (password_verify(str_replace("'", "", $pw_temp), $pw))
    {
      session_start();

      $_SESSION['firstname'] = $fn;
      $_SESSION['lastname'] = $ln;
      
      echo htmlspecialchars("$fn $ln : Hi $fn, you are now logged in as '$un'");
      die("<p><a href = 'productForm.php'>Click here to continue</a></p>");
    }
      
    else die("Invalid username/password combination");
 }
 else
  {
    header('WWW-Authenticate: Basic realm="Restricted Area"');
    header('HTTP/1.0 401 Unauthorized');
    die ("Please enter your username and password");
  }

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
?>