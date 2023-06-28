<?php
// Check token
$tokenErr = false;


// Faire attention à choisir les bonnes routes

if ($_SERVER['REQUEST_METHOD'] != "GET") {
    // Valid token required
    $data = json_decode(file_get_contents("php://input"), true);

    // if one is missing => error
    if (!isset($_SESSION['token']) || !isset($data['token'])) {
        $tokenErr = true;
    } else {
        $now = time();
        if ($_SESSION["expiration"] < $now) {
            $tokenErr = true;
        } elseif ($_SESSION['token'] != $data['token']) {
            $tokenErr = true;
        }
    }
}

if ($tokenErr == true) {
    $response['message'] = "Access Denied";
    $response['code'] = "Pas Ok";
    $response['file'] = "token.php";
    echo json_encode($response);
    die();
}

// Expired ?
// Verified if sessio token and recieved token ==