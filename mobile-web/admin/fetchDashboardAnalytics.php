<?php

require '../config.php';

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}

$year = isset($_GET['year']) ? $_GET['year'] : null;

if (isset($year)) {
  $sql = "SELECT COUNT(*) as total_count FROM transactions WHERE `current_date` LIKE concat('%', '/${year}_','%')";
} else {
  $sql = "SELECT COUNT(*) as total_count FROM transactions WHERE `current_date` LIKE concat(date_format(curdate(), '%c/%e/%Y'),'%')";
}

$total_transaction_today_query = $conn->query($sql);
$total_transaction_today = $total_transaction_today_query->fetch_assoc();

if (isset($year)) {
  $sql = "SELECT SUM(subtotal) as total_total FROM transactions WHERE `current_date` LIKE concat('%', '/__/${year}', '%')";
} else {
  $sql = "SELECT SUM(subtotal) as total_total FROM transactions WHERE `current_date` LIKE concat('%', date_format(curdate(), '%c/%e/%Y'), '%')";
}

$total_total_query = $conn->query($sql);
$total_total = $total_total_query->fetch_assoc();


$dashboard = [
  "total_transaction_today" => $total_transaction_today['total_count'] ?? 0,
  "total_sales_today" => "₱ " . (number_format($total_total['total_total'], 2, ".", ",") ?? 0),
];

$conn->close();

echo json_encode($dashboard);
exit;

?>
