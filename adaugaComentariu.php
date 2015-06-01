<?php
include 'functions.php';
if(isset($_REQUEST['comm']))
adaugaComentariu('100',$_REQUEST['idPet'],$_REQUEST['comm']);
echo '<meta http-equiv="refresh" content="0;URL=\'http://localhost/seePetitionInfo.php?idPet='.$_REQUEST['idPet']."'\" /> ";   
?>
