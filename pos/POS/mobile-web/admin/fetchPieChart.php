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
  $sql = "SELECT cart FROM transactions WHERE `current_date` LIKE concat('%', '/__/${year}', '%')";
} else {
  $sql = "SELECT cart FROM transactions WHERE `current_date` LIKE concat('%', date_format(curdate(), '%c/%e/%Y'), '%')";
}
$result = $conn->query($sql);


$labels = [];
$data = [];
$colors = [];
$summary = [];
$product_categories = [];
$aggregate = [];

if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    $cart_array = json_decode($row['cart'], TRUE);
    foreach ($cart_array['cart'] as $item) {
      if (isset($summary[$item['barcode']])) {
        $summary[$item['barcode']] = $summary[$item['barcode']] + $item['qty'];
      } else {
        $summary[$item['barcode']] = $item['qty'];
      }
    }
  }
}

foreach ($summary as $key => $value) {
  $sql = "SELECT `barcode`, `category` FROM products WHERE barcode = '" . $key . "'";
  $result = $conn->query($sql);
  $product = $result->fetch_assoc();
  $product_categories[$key] = $product['category'];
}

foreach ($summary as $key => $value) {
  if (isset($aggregate[$product_categories[$key]])) {
    $aggregate[$product_categories[$key]] =  $aggregate[$product_categories[$key]] + $value;
  } else {
    $aggregate[$product_categories[$key]] =  $value;
  }
}

foreach ($aggregate as $key => $value) {
  $labels[] = $key;
  $data[] = $value;
  $colors[] = 'rgb(' . rand(0, 255) . ',' . rand(0, 255) . ',' . rand(0, 255) . ')';
}

$pieChart = [
  "labels" => $labels,
  "data" => $data,
  "colors" => $colors
];

$conn->close();

echo json_encode($pieChart);
exit;

?>
