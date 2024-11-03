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
  $sql = "
    SELECT
      SUM(subtotal) as mon_subtotal,
      mon
    FROM (
      SELECT 
        current_year_mons_sale.subtotal, 
        DATE_FORMAT(current_year_mons_sale.month_sale, '%c') as mon 
      FROM (
        SELECT subtotal, STR_TO_DATE(`current_date`, '%c/%d/%Y') as month_sale FROM transactions WHERE `current_date` LIKE concat('%', '/${year}_', '%')
      ) as current_year_mons_sale
    ) as summary_current_year_mons_sale
    GROUP BY
      mon
    ORDER BY mon
  ";
} else {
  $sql = "
    SELECT
      SUM(subtotal) as mon_subtotal,
      mon
    FROM (
      SELECT 
        current_year_mons_sale.subtotal, 
        DATE_FORMAT(current_year_mons_sale.month_sale, '%c') as mon 
      FROM (
        SELECT subtotal, STR_TO_DATE(`current_date`, '%c/%d/%Y') as month_sale FROM transactions WHERE `current_date` LIKE concat('%', date_format(curdate(), '/%Y_'), '%')
      ) as current_year_mons_sale
    ) as summary_current_year_mons_sale
    GROUP BY
      mon
    ORDER BY mon
  ";
}
$result = $conn->query($sql);

$data = [
  0 => 0,
  1 => 0,
  2 => 0,
  3 => 0,
  4 => 0,
  5 => 0,
  6 => 0,
  7 => 0,
  8 => 0,
  9 => 0,
  10 => 0,
  11 => 0
];

if ($result->num_rows > 0) {
  while($row = $result->fetch_assoc()) {
    $data[$row['mon'] - 1] = $row['mon_subtotal'];
  }
}


$pieChart = [
  "data" => $data
];

$conn->close();

echo json_encode($pieChart);
exit;

?>
