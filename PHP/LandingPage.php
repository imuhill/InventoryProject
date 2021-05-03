<?php // authenticate.php
  require_once 'loginfo.php';
  $con = new mysqli($hn, $username, $password, $db);

  if($con->connect_error){
      die("Error connecting to DB". $con->connect_error);
  }

?>