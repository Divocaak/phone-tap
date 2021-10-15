<?php
include_once "config.php";

$return = [];
$sql = 'SELECT login, token, password FROM user WHERE login="' . $_GET["phone"] . '";';
if ($result = mysqli_query($link, $sql)) {
    while ($row = mysqli_fetch_row($result)) {
        if(password_verify($_GET["password"], $row[2])){
            $return = ["phone" => $row[0],
            "token" => $row[1]];
            echo json_encode($return, JSON_PRETTY_PRINT, JSON_FORCE_OBJECT);
        }
        else{echo "php error";}
    }
    mysqli_free_result($result);
}
mysqli_close($link);
?>