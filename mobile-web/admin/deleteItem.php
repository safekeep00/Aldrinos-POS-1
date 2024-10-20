<?php

require '../config.php';

try {
  // Parse product ID
  $product_id = strip_tags($_GET['id']);

  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
  // Check connection
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "UPDATE products SET deleted_at = NOW() WHERE id = ${product_id}";

  if ($conn->query($sql) === TRUE) {
    $conn->close();
    header("Location: inventory.html");
  }

  $conn->close();

  echo $conn->error;
} catch (Exception $e) {
  echo $e->getMessage();
}

?>