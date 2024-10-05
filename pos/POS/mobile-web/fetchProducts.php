<?php

require 'config.php';

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM products WHERE deleted_at IS NULL";
$result = $conn->query($sql);

$products = [];

if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    $products[$row["barcode"]] = [
        "name" => $row["name"],
        "code" => $row["code"],
        "price" => $row["price"],
        "image" => $row["image"]
    ];
  }
}

$conn->close();

echo json_encode($products);
exit;

?>