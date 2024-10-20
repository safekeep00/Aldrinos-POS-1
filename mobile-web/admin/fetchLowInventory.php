<?php

require '../config.php';

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM products WHERE qty <= qty_stock_threshold AND deleted_at IS NULL ORDER BY id DESC";
$result = $conn->query($sql);

$products = [];

if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    $products[] = $row;
  }
}

$conn->close();

echo json_encode($products);
exit;

?>