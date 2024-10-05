<?php

require 'config.php';

try {
  $transaction_no = $_POST['transaction_no'];
  $current_date = $_POST['current_date'];
  $subtotal = $_POST['subtotal'];
  $amount_paid = $_POST['amount_paid'];
  $change = $_POST['change'];
  $cart = $_POST['cart'];

  // Create connection
  $conn = new mysqli($servername, $username, $password, $dbname);
  // Check connection
  if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
  }

  $sql = "
    INSERT INTO transactions(
      transaction_no,
      `current_date`,
      subtotal,
      amount_paid,
      `change`,
      cart
    ) VALUES (
      '${transaction_no}',
      '${current_date}',
      '${subtotal}',
      '${amount_paid}',
      '${change}',
      '${cart}'
    )
  ";

  if ($conn->query($sql) === TRUE) {

    // update inventory

    $cart_array = json_decode($cart, TRUE);

    // {
    //   "cart":[
    //     {"barcode":"978020137961","name":"C2 Red","code":"C2R5HML","price":30,"image":"c2-red.png","total":30,"qty":1},
    //     {"barcode":"100036219082","name":"Absolute Mineral Water","code":"AMW500ML","price":10,"image":"absolute.png","total":10,"qty":1}
    //   ]
    // }

    foreach ($cart_array['cart'] as $item) {
      $sql = "UPDATE products SET qty = (qty - " . intval($item['qty']) . ") WHERE barcode = '" . $item['barcode'] . "'";
      if ($conn->query($sql) !== TRUE) {
        $res = [
          "sql" => $sql,
          "message" => $conn->error
        ];
      }
    }

    $res = [
      "message" => "Added successful."
    ];
  } else {
    $res = [
      "message" => $conn->error
    ];
  }

  $conn->close();

  echo json_encode($res);
  exit;
} catch (Exception $e) {
  $res = [
    "message" => $e->getMessage()
  ];

  echo json_encode($res);
  exit;
}

?>