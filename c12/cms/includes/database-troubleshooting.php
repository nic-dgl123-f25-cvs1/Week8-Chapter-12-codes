<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>Database error</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css" />
  </head>
  <body style="padding: 3rem">
  <h1>You are not connected to the database, let's try to fix that...</h1>
  <p>First, this is what we think might be the issue:</p>
  <?php
    switch ($e->getCode()) {
        case 0:
            echo '<p>The value for <code>$type</code> must be <code>mysql</code>.<br>It is the first value in the DSN.</p>';
            break;
        case 2002:
            echo '<p>PHP could not reach MySQL.<br>
                  1. Open the XAMPP Control Panel and make sure <b>MySQL</b> is started (it should be green).<br>
                  2. Check <code>$port</code> is <code>3306</code> (the port shown next to MySQL in the XAMPP Control Panel).<br>
                  3. Check <code>$server</code> is <code>localhost</code>. If you still see this error try <code>127.0.0.1</code>.</p>';
            break;
        case 1044:
            echo '<p>Your user account does not appear to have permission to work with this database.<br> Check the permissions in phpMyAdmin.</p>';
            break;
        case 1045:
            echo '<p>The username or password appear to be wrong.<br>In phpMyAdmin check the user account was created.<br>Then make sure you have the correct username and password in the $username and $password variables.<br>
                  On a fresh XAMPP install the username is <code>root</code> and the password is blank (<code>\'\'</code>).</p>';
            break;
        case 1049:
            echo '<p>MySQL is running, but it has no database called <code>' . htmlspecialchars($db) . '</code>.<br>
                  Open <a href="http://localhost/phpmyadmin">phpMyAdmin</a> and check the database exists and is spelled exactly the same.<br>
                  If it is missing, create it and import the <code>phpbook-1.sql</code> file from the book code.</p>';
            break;
        case 1042:
            echo '<p>Cannot get hostname for your database server</p>';
            break;
        case 2003:
            echo '<p>1. Check that MySQL is running.<br>If this does not work, check the port number in phpMyAdmin. See <a href="http://notes.re/mysql/check-ports">http://notes.re/mysql/check-ports</a>.</p>';
            break;
        case 2005:
            echo '<p>The value for $server is incorrect.<br>
                  If you are using MAMP or XAMPP try <code>localhost</code>.<br>
                  If you still see the same error try <code>127.0.0.1</code>. This IP address is reserved for your local machine.</p>';
            break;
        case 2019:
            echo '<p>The <code>charset</code> in the DSN is incorrect.<br>Set it to <code>utf8</code>.</p>';
            break;
        default:
            echo '<p>First, check that you have: </p>
                 <ul>
                     <li>Created the sample database in phpMyAdmin</li>
                     <li>Created a user account to access the database</li>
                 </ul>
                 <p>Then, search the web for the error message you have received below.</p>';
            break;
    }
  ?>
  <hr style="margin-top: 3rem;">
  <p>Here is the SQL error code and message the web server created:</p>
  <p><b>SQLSTATE error code:</b> <?= $e->getCode() ?></p>
  <p><b>Error message: </b><?= $e->getMessage() ?></p>
  <?php exit; ?>
  </body>
</html>