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

$summary = [];

if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    $cart_array = json_decode($row['cart'], TRUE);
    foreach ($cart_array['cart'] as $item) {
      if (isset($summary[$item['barcode']])) {
        $summary[$item['barcode']] = [
          "name" => $item['name'],
          "code" => $item['code'],
          "qty" => $summary[$item['barcode']]['qty'] + $item['qty'],
          "total" => number_format((double) $summary[$item['barcode']]['total'] + (double) $item['total'], 2)
        ];
      } else {
        $summary[$item['barcode']] = [
          "name" => $item['name'],
          "code" => $item['code'],
          "qty" => $item['qty'],
          "total" => number_format((double) $item['total'], 2),
        ];
      }
    }
  }
}

$conn->close();

function invenDescSort($item1,$item2)
{
    if ($item1['total'] == $item2['total']) return 0;
    return ($item1['total'] < $item2['total']) ? 1 : -1;
}
usort($summary,'invenDescSort');

$summary = array_slice($summary, 0, 5, true);

echo json_encode($summary);
exit;

?>
