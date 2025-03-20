<?php
include("../config/conexao.php")

if($_SERVER("REQUEST_METHOD") == "POST"){
    $nome = $_POST["nome"];
    $email = $_POST["email"];
    $senha = password_hash($_POST["senha"], PASSWORD_DEFAULT);
    $tipo = $_POST["tipo"];

    $sql = "INSERT INTO Usuarios (nome, email, senha, tipo) VALUES ('$nome', '$email', '$senha', '$tipo')";
    $stmt = $conn -> prepare($sql);
    $stmt -> bind_param("ssss", $nome, $email, $senha, $tipo);

    if($stmt -> execute()){
        echo "Usuário cadastrado com sucesso!";
    } else {
        echo "Erro: " .$stmt -> error;
    }

    $stmt -> close();
    $conn -> close();
}

?>

<form method="POST">
    <input type="text" name="nome" placeholder="Nome" required><br>

    <input type="email" name="email" placeholder="E-mail" required><br>

    <input type="password" name="senha" placeholder="Senha" required><br>

    <select name="tipo">
        <option value="aluno">Aluno</option>
        <option value="professor">Professor</option>
        <option value="admin">Administrador</option>
    </select><br>
    <button type="submit">Cadastrar</button>
</form>

