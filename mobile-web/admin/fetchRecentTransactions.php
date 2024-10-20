<?php

require '../config.php';

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM transactions ORDER BY id DESC LIMIT 5";
$result = $conn->query($sql);

$transactions = [];

if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    $transactions[] = [
        "id" => $row["id"],
        "transaction_no" => $row["transaction_no"],
        "current_date" => $row["current_date"],
        "subtotal" => $row["subtotal"],
        "amount_paid" => $row["amount_paid"],
        "change" => $row["change"],
        "cart" => $row["cart"],
    ];
  }
}

$conn->close();

echo json_encode($transactions);
exit;

?>