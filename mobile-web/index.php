<?php
    session_start();

    $ipAddress = $_SERVER['REMOTE_ADDR'];

    if (!isset($_SESSION["ip_address"])) {
        $_SESSION["ip_address"] = $ipAddress;
        $_SESSION["auth_retry"] = 0;
        $_SESSION["auth_timestamp"] = date('h:i:s');
    }

    $latest_auth_timestamp = date('h:i:s');

    $start = intval((explode(":", $_SESSION["auth_timestamp"]))[1]);
    $end = intval((explode(":", $latest_auth_timestamp))[1]);
    $mins = abs($end - $start);
    $remaining = 5 - $mins;

    if ($mins >= 5) {
        $_SESSION["auth_retry"] = 0;
        $_SESSION["auth_timestamp"] = date('h:i:s');
    }

     if ($_SESSION["auth_retry"] > 5) {
        // echo "<pre>";
        // print_r([
        //     "auth_timestamp" => $_SESSION["auth_timestamp"],
        //     "latest_auth_timestamp" => $latest_auth_timestamp,
        //     "auth_retry" => $_SESSION["auth_retry"],
        //     "end" => $end,
        //     "start" => $start,
        //     "mins" => $mins,
        //     "remaining" => $remaining
        // ]);
        // echo "</pre>";
        // echo "<br>";

        echo "Max login attempt exceeded 5 times. Please try again after ${remaining} minute(s) and refresh the page. Click <a href='index.php'>here</a> to refresh.";
        die();
    }
?>

<html>

<head>
    <title>POS - Cashier</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <style>
        html,
        body {
            height: 100%;
        }

        body {
            display: flex;
            align-items: center;
            padding-top: 40px;
            padding-bottom: 40px;
            background-color: #5DADE2;
        }

        .form-signin {
            max-width: 330px;
            padding: 15px;
        }

        .form-signin .form-floating:focus-within {
            z-index: 2;
        }

        .form-signin input[type="text"] {
            margin-bottom: -1px;
            border-bottom-right-radius: 0;
            border-bottom-left-radius: 0;
        }

        .form-signin input[type="password"] {
            margin-bottom: 10px;
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }

        .form-signin button[type="submit"] {
            background-color: #F1C40F;
            border-color: #F1C40F;
        }
    </style>
</head>

<body class="text-center">
    <main class="form-signin w-100 m-auto">
        <form id="form-login" method="post" action="auth.php">
            <h1 class="h3 mb-3 fw-normal text-white">Aldrinos</h1>
            <div class="form-floating">
                <input type="text" class="form-control" id="employee-id" placeholder="Employee ID" name="employee-id"
                    required>
                <label for="employee-id">Employee ID</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="employee-pass" placeholder="Password"
                    name="employee-pass" required>
                <label for="employee-pass">Password</label>
            </div>
            <div id="err"></div>
            <button id="btn-submit" class="w-100 btn btn-lg text-white rounded-pill" name="submit" type="submit">Log In</button>
            <p class="mt-5 mb-3 text-white">&copy; 2024</p>
        </form>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
        crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.3.slim.min.js"
        integrity="sha256-ZwqZIVdD3iXNyGHbSYdsmWP//UBokj2FHAxKuSBKDSo=" crossorigin="anonymous"></script>
    <script src="js/history.js"></script>
    <script>
        $(document).ready(() => {
            const queryString = window.location.search;
            const urlParams = new URLSearchParams(queryString);
            const error = urlParams.get('error');
            const maxAttempt = "<?php echo $_SESSION["auth_retry"]; ?>";

            if (error) {
                $("#err").html(`
                    <div class="text-white mb-2">
                        <span class="text-white">Invalid credentials. Attempt ${maxAttempt}/5</span>
                    </div>
                `);
            }
        });
    </script>
</body>

</html>