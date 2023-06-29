<?php
include_once("config.php");

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $data = json_decode(file_get_contents('php://input', true));

    if (isset($data->auth)) {
        require_once("config.php");
        $sql = "SELECT * from users WHERE login= :login AND password = :password";
        $req = $conn->prepare($sql);
        $req->execute([
            'login' => $data->login,
            'password' => $data->password
        ]);
        $usersFound = $req->rowCount();

        if ($usersFound > 0) {
            // Create a SESSION
            $user = $req->fetchObject();
            $_SESSION['user_id'] = $user->id;
            $_SESSION['token'] = md5(date("DdMyHis"));
            $_SESSION['expiration'] = time() + 1 * 600;

            $response['token'] = $_SESSION['token'];
            $response['message'] = "Connecté";
            $response['code'] = "Ok";
        } else {
            $response['message'] = "Erreur de log ou pas";
            $response['code'] = "Code d'erreur";
        }
    }
} 

if ($_SERVER['REQUEST_METHOD'] == "GET") {
    // Disconnect
    unset($_SESSION['token']);
    unset($_SESSION['user_id']);
    unset($_SESSION['expiration']);
    $response['message'] = "Déconnexion";
    $response['code'] = "ok";
}

echo json_encode($response);
