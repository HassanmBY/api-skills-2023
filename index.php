<?php
require_once("config.php");
require_once("headers.php");

$route = isset($_GET['route']) ? $_GET['route'] : "";

require_once('token.php');

if ($route == "") {
    $response['message'] = "documentation";
    $response['content'] = "bla bla bla";
    die();
}

$routes = ['pays', 'contacts', 'cities'];

if (!in_array($route, $routes)) {
    $response['message'] = "Access denied2";
    $response['code'] = "Pas ok";
    $response['file'] = "index.php";
    echo json_encode($response);
    die();
}

if ($_SERVER['REQUEST_METHOD'] == "GET") {

    $sql = "SELECT * FROM $route";
    $req = $conn->prepare($sql);
    $req->execute();

    $usersCount = $req->rowCount();
    $users = $req->fetchAll();

    if ($users > 0) {
        $response['content'] = $users;
        $response['message'] = "Liste $route";
        $response["code"] = 'Ok';
        $response['nbhits'] = $usersCount;
    } else {
        $response['message'] = "Pas de réponse";
        $response['code'] = "Code d'erreur";
    }
}


// Create any new entry in the database
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $data = json_decode(file_get_contents('php://input'), true);
    unset($data['token']);
    $sql = "INSERT INTO $route SET ";
    $args = [];
    $i = 0;

    foreach ($data as $field => $value) {
        if ($i <= count($data) - 1) {
            $sql .= "$field = :$field,";
            $args[$field] = $value;
        }
        $i++;
    }

    $sql = rtrim($sql, ",");

    $req = $conn->prepare($sql);
    $req->execute($args);


    $id = $conn->lastInsertId();
    $nb_hits = $req->rowCount();

    if ($nb_hits > 0) {
        $response['message'] = "$route.id=>$id ajouté";
        $response['code'] = "Ok";
        $response['nbhits'] = $nb_hits;
    } else {
        $response['message'] = "Erreur";
        $response['code'] = "Code d'erreur";
    }
}

// Delete any row from any table
if ($_SERVER['REQUEST_METHOD'] == "DELETE") {
    $sql = "DELETE FROM $route WHERE id = :id";
    $req = $conn->prepare($sql);
    $req->execute(['id' => $_GET['id']]);
    $nb_hits = $req->rowCount();

    // myPrint_r($sql);

    if ($nb_hits > 0) {
        $response['message'] = "$route.id=>{$_GET['id']} supprimé";
        $response['code'] = "Ok";
        $response['nbhits'] = $nb_hits;
        $response['id'] = $_GET['id'];
    } else {
        $response['message'] = "Erreur";
        $response['code'] = "Code d'erreur";
    }
}

// Update any row from any table
if ($_SERVER['REQUEST_METHOD'] == "PATCH") {
    $data = json_decode(file_get_contents('php://input'), true);
    unset($data['token']);
    $sql = "UPDATE $route SET ";
    $args = [];
    $i = 0;

    foreach ($data as $field => $value) {
        if ($i <= count($data) - 1) {
            $sql .= "$field = :$field,";
            $args[$field] = $value;
        }
        $i++;
    }

    $sql = rtrim($sql, ",");
    $sql .= " WHERE id = :id";
    $args['id'] = $_GET['id'];

    $req = $conn->prepare($sql);
    $req->execute($args);

    $nb_hits = $req->rowCount();

    if ($nb_hits > 0) {
        $response['message'] = "$route.id=>{$_GET['id']} modifié";
        $response['code'] = "Ok";
        $response['nbhits'] = $nb_hits;
        $response['id'] = $_GET['id'];
    } else {
        $response['message'] = "Erreur";
        $response['code'] = "Code d'erreur";
    }
}

echo json_encode($response);


// myPrint_r($user);