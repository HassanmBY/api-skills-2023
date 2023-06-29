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

$routes = ['pays', 'contacts', 'cities', 'users'];

if (!in_array($route, $routes)) {
    $response['message'] = "Access denied2";
    $response['code'] = "Pas ok";
    $response['file'] = "index.php";
    http_response_code(404);
    echo json_encode($response);
    die();
}

// Get all the data from any table
if ($_SERVER['REQUEST_METHOD'] == "GET") {
    $sql = "SELECT * FROM $route";
    $args = [];
    $i = 0;
    $data = json_decode(file_get_contents('php://input'), true);

    if (isset($data['search'])) {
        $data = $data['search'];
        if (isset($data['operator'])) {
            $operator = $data['operator'];
            unset($data['operator']);
        } else {
            $operator = "AND";
        }
        foreach ($data as $field => $value) {
            ($i == 0) ?
                $sql .= " WHERE $field LIKE :$field"
                :
                $sql .= " $operator $field LIKE :$field";
            $args[$field] = is_int($value) ? $value : "%" . $value . "%";
            $i++;
        }
    }

    $req = $conn->prepare($sql);
    $req->execute($args);

    $usersCount = $req->rowCount();
    $users = $req->fetchAll();

    if ($users > 0) {
        $response['content'] = $users;
        $response['message'] = "Liste $route";
        $response["code"] = 'ok';
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
        http_response_code(500);
    }
}

// Delete any row from any table
if ($_SERVER['REQUEST_METHOD'] == "DELETE") {
    if (!isset($_GET['id'])) {
        $data = json_decode(file_get_contents('php://input'), true);
        unset($data['token']);
        $data = array_values($data['delete']);
        $sql = "DELETE FROM $route WHERE id IN (";
        $i = 0;

        foreach ($data as $value) {
            if ($i <= count($data) - 1) {
                $sql .= ":id$i, ";
                $args["id$i"] = intval($value);
            }
            $i++;
        }

        $sql = rtrim($sql, ", ");
        $sql .= ")";
    } else {
        $sql = "DELETE FROM $route WHERE id = :id";
        $args = ['id' => $_GET['id']];
    }

    $req = $conn->prepare($sql);
    $req->execute($args);
    $nb_hits = $req->rowCount();



    if ($nb_hits > 0) {
        if ($nb_hits > 1) {
            $response['message'] = "Elements supprimés: " . implode(",", $args);
        } else {
            $response['message'] = "$route.id=>{$_GET['id']} supprimé";
        }
        $response['code'] = "Ok";
        $response['nbhits'] = $nb_hits;
    } else {
        $response['message'] = "Erreur";
        $response['code'] = "Code d'erreur";
        http_response_code(500);
    }
}

// Update any row from any table
if ($_SERVER['REQUEST_METHOD'] == "PUT") {
    if (!isset($_GET['id'])) {
        $response['message'] = "Il manque l'id";
        $response['code'] = "Code d'erreur";
        http_response_code(400);
        die();
    };
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
        http_response_code(500);
    }
}

echo json_encode($response);


// myPrint_r($user);