<?php

require '../config.php';

try {
  error_reporting(E_ALL ^ E_NOTICE);  
  
  // Parse product ID
  $product_id = strip_tags($_GET['id']);

  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
  // Check connection
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "SELECT * FROM products WHERE id = ${product_id} AND deleted_at IS NULL";

  $result = $conn->query($sql);

  $product = [];

  if ($result->num_rows > 0) {
    $product[] = $result->fetch_assoc();
  }

  echo json_encode($product);
} catch (Exception $e) {
  echo json_encode([]);
} finally {
  $conn->close();
  exit;
}

?>