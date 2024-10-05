<?php

require '../config.php';

try {
  if (isset($_POST['submit'])) {

    $id = $_POST['id'];
    $barcode = $_POST['barcode'];
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

    if (!empty($image_name)) {
      $sql = "
        UPDATE 
          products 
        SET 
          barcode='${barcode}',
          name='${name}',
          category='${category}',
          code='${code}',
          price='${price}',
          qty='${qty}',
          qty_unit='${qty_unit}',
          qty_stock_threshold='${qty_stock_threshold}',
          image='${image_name}'
        WHERE 
          id = ${id}
      ";
    } else {
      $sql = "
        UPDATE 
          products 
        SET 
          barcode='${barcode}',
          name='${name}',
          category='${category}',
          code='${code}',
          price='${price}',
          qty='${qty}',
          qty_unit='${qty_unit}',
          qty_stock_threshold='${qty_stock_threshold}'
        WHERE 
          id = ${id}
      ";
    }
    

    if ($conn->query($sql) === TRUE) {

      if (isset($_FILES['image']['name'])) {
        $uploaddir = '../images/';
        $uploadfile = $uploaddir . basename($_FILES['image']['name']);

        move_uploaded_file($_FILES['image']['tmp_name'], $uploadfile);
      }
    } else {
      echo $conn->error;
    }

    header("Location: product.html?id=${id}&status=saved");

    $conn->close();
  }
} catch (Exception $e) {
  echo $e->getMessage();
}

?>