<?php

    require '../config.php';
    session_start();

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    if (isset($_POST["submit"])) {
        $employee_id = $_POST["employee-id"] ?? null;
        $employee_pass = $_POST["employee-pass"] ?? null;
        $employee_pass = $employee_pass ? md5($employee_pass) : null;
        $sql = "SELECT * FROM users WHERE `username` = '${employee_id}' AND `password` = '${employee_pass}' AND `type`='admin'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $_SESSION["username"] = $employee_id;
            $_SESSION["auth_retry"] = 0;
            $_SESSION["auth_timestamp"] = date('h:i:s');
            header("Location: ./dashboard.html");
        } else {
            $_SESSION["auth_retry"] = $_SESSION["auth_retry"] + 1;
            $_SESSION["auth_timestamp"] = date('h:i:s');
            header("Location: ./index.php?error=auth");
        }
    } else {
        header("Location: ./index.php");
    }

?>