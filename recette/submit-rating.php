<?php
session_start();

include("../Config.php");

if (isset($_SESSION['id'])) {

    $id = $_SESSION['id'];

    if (isset($_GET['recId']) && isset($_GET['userId'])) {
        $recipe_id = $_GET['recId'];
        $user_id = $_GET['userId'];
    }

    if (isset($_POST['submit-comment'])) {
        $comment = $_POST['comment'];
        $rating = $_POST['rating'];
    }


    echo $recipe_id . "<br />";
    echo $id . "<br />";
    echo $rating . "<br />";
    echo $comment . "<br />";

    $query = "insert into comment (content,rating,user_id,recipe_id) values ('$comment','$rating','$id','$recipe_id')";

    if (mysqli_query($con, $query)) {
        header("Location: ./recette.php?recId=$recipe_id");
        die;
    }

}

?>