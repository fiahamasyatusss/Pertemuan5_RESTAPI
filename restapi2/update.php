<?php
header('Access-Control-Allow-Origin; *');
header('Content-Type: application/json');
include('db.php');
if (!isset($_POST['id']) && !isset($_POST['name']) && !isset($_POST['address']) && !isset($_POST['salary'])) {
    echo json_encode("No Data Sent");
} else {
    $id = $_POST['id'];
    $name = $_POST['name'];
    $address = $_POST['address'];
    $salary = $_POST['salary'];
    $result = mysqli_query($db, "UPDATE employees SET name = '{$name}', address = '{$address}', salary = '{$salary}' WHERE id = {$id}");
    if ($result) {
        echo json_encode("Success");
    } else {
        echo json_encode("Failed");
    }
}
