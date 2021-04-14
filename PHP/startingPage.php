<?php
    echo <<< _END
    <html>
    <head>
        <link rel="stylesheet" type="text/css" href="masks.css" media="screen"/>
    </head>
    
    <body>
    
    <div class="wrapper fadeInDown">
      <div id="formContent">
        <!-- Tabs Titles -->
    
        <!-- Icon -->
        <div class="fadeIn first">
        </div>
    
        <!-- Login Form -->
        <div id="login">  
          <form action="signin.php" method ="post">
              <input type="submit" class="fadeIn fourth" value="Log In">
          </form>
          <form action="register.php" method ="post">
              <input type="submit" class="fadeIn fourth" value="Register">
          </form>
        </div>
    
        <!-- Sign Up Form -->
    
      </div>
    </div>
    
    </body>
    </html>
    _END;
?>
