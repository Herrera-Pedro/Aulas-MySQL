<?php
$host = "localhost";
$usuario = "root";
$senha = "Root";
$banco = "gestao";

$conn = new mysqli($host, $usuario, $senha, $banco);

if ($conn->connect_error) {
    die("Falha na conexão: " .$conn->connect_error);
}

?>