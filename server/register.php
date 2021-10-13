<?php
header("Content-Type: text/html; charset=utf-8");

include_once "config.php";

$outputMessage = "";
$sql = 'SELECT id FROM user WHERE login=' . $_GET["login"] . ';';
if (mysqli_query($link, $sql)) {
    $outputMessage = "Zadaný login je již registrován!";
}

if($outputMessage == ""){
    $passHash = password_hash($_GET["password"], PASSWORD_DEFAULT);
    $sql = 'INSERT INTO user (login, password, token) VALUES ("' . $_GET["login"] . '", "' . $passHash . '", "' . $_GET["token"] . '");'; 
    if (mysqli_query($link, $sql)) {
        $outputMessage = "Byl jste úspěšně zaregistrován, přihlaste se.";
    } else {
        $outputMessage = "Někde se stala chyba, zkuste to prosím později.";
    }
}
mysqli_close($link);

echo $outputMessage;
?>