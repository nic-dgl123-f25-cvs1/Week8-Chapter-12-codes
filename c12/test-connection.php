<?php
// Open this page in your browser to check the database connection:
// http://localhost/<your-folder>/c12/test-connection.php
require 'cms/includes/database-connection.php';   // Shows a help page and stops if it cannot connect

$version = $pdo->query('SELECT VERSION();')->fetchColumn();
$tables  = $pdo->query('SHOW TABLES;')->fetchAll(PDO::FETCH_COLUMN);
$needed  = ['article', 'category', 'image', 'member'];
$missing = array_diff($needed, $tables);
?>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Database connection test</title>
    <style>
    body {
        font-family: Arial, sans-serif;
        padding: 2rem 3rem;
        color: #333;
    }

    .ok {
        color: #00866f;
    }

    .bad {
        color: #c0392b;
    }

    table {
        border-collapse: collapse;
        margin-top: 1rem;
    }

    td,
    th {
        border: 1px solid #ddd;
        padding: .4rem .8rem;
        text-align: left;
    }
    </style>
</head>

<body>
    <h1 class="ok">Connected to <code><?= htmlspecialchars($db) ?></code></h1>
    <p>MySQL / MariaDB version: <?= htmlspecialchars($version) ?></p>

    <?php if ($missing) { ?>
    <h2 class="bad">But some tables are missing: <?= htmlspecialchars(implode(', ', $missing)) ?></h2>
    <p>In phpMyAdmin, select the <b><?= htmlspecialchars($db) ?></b> database, click <b>Import</b>,
        and import the <code>phpbook-1.sql</code> file from the book code.</p>
    <?php } else { ?>
    <h2 class="ok">All the tables the Chapter 12 site needs are here.</h2>
    <p><a href="cms/index.php">Open the Creative Folk site</a> &middot; <a href="index.php">Chapter 12 examples</a></p>
    <?php } ?>

    <table>
        <tr>
            <th>Table</th>
            <th>Rows</th>
        </tr>
        <?php foreach ($tables as $table) { ?>
        <tr>
            <td><?= htmlspecialchars($table) ?></td>
            <td><?= $pdo->query('SELECT COUNT(*) FROM `' . str_replace('`', '``', $table) . '`;')->fetchColumn() ?></td>
        </tr>
        <?php } ?>
    </table>
</body>

</html>