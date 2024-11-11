<?php

require '../config.php';

try {
  if (isset($_POST['submit'])) {

    $barcode = str_replace("-", "", $_POST['barcode']);
    $name = $_POST['name'];
    $category = $_POST['category'];
    $code = $_POST['code'];
    $price = $_POST['price'];
    $qty = $_POST['qty'];
    $qty_unit = $_POST['qty_unit'];
    $qty_stock_threshold = $_POST['qty_stock_threshold'];
    $image_name = str_replace(" ", "%20", $_FILES['image']['name']);

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
    if ($conn->connect_error) {
      die("Connection failed: " . $conn->connect_error);
    }

    $sql = "
      INSERT INTO products(
        barcode,
        name,
        category,
        code,
        price,
        qty,
        qty_unit,
        qty_stock_threshold,
        image
      ) VALUES (
        '${barcode}',
        '${name}',
        '${category}',
        '${code}',
        ${price},
        ${qty},
        '${qty_unit}',
        ${qty_stock_threshold},
        '${image_name}'
      )
    ";

    if ($conn->query($sql) === TRUE) {
      $uploaddir = '../images/';
      $uploadfile = $uploaddir . basename($_FILES['image']['name']);

      move_uploaded_file($_FILES['image']['tmp_name'], $uploadfile);
    } else {
      echo $conn->error;
    }

    $conn->close();

    header("Location: inventory.html");
  }
} catch (Exception $e) {
  echo $e->getMessage();
}

?>