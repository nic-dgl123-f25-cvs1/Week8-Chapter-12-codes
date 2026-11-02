<?php
// ---------------------------------------------------------------
// XAMPP settings. Change these if your setup is different.
// ---------------------------------------------------------------
$type     = 'mysql';                 // Type of database
$server   = 'localhost';             // Server the database is on (try 127.0.0.1 if localhost fails)
$db       = 'phpbook-1';             // Name of the database (must match phpMyAdmin exactly)
$port     = '3306';                  // XAMPP uses 3306 (MAMP uses 8889)
$charset  = 'utf8mb4';               // UTF-8 encoding using 4 bytes of data per character

$username = 'root';                  // XAMPP default user is root
$password = '';                      // XAMPP default root password is blank
                                     // If you created your own account in phpMyAdmin, use it here instead

$options  = [                        // Options for how PDO works
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
];                                                                  // Set PDO options

// DO NOT CHANGE ANYTHING BENEATH THIS LINE
$dsn = "$type:host=$server;dbname=$db;port=$port;charset=$charset"; // Create DSN
try {                                                               // Try following code
    $pdo = new PDO($dsn, $username, $password, $options);           // Create PDO object
} catch (PDOException $e) {                                         // If connection fails
    include __DIR__ . '/database-troubleshooting.php';              // Show a page explaining what to fix
    exit;                                                           // Stop the page
}