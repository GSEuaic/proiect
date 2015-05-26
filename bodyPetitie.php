<div class="content campGeneral camp">
	<p>
<?php
include "functions.php";

$numePetitie = getNume($_REQUEST['idPet']);
$descrierePetitie = getDescriere($_REQUEST['idPet']);
$modifica = '<a id="dreapta" href="http://localhost/modificaPetitie.php?idPet='.$_REQUEST['idPet'].'">Modifica</a>';
echo $modifica;
print "<h2>Numele petitiei:</h2><br> $numePetitie<br> <h2>Descrierea petitiei: </h2><br> $descrierePetitie"; //numele petitiei
?>
	</p>
	<p> <h2>Comentarii:</h2></p>
<?php
if(isset($_REQUEST['pagina']))
	$p = $_REQUEST['pagina'];
else $p=1;
getComentarii($_REQUEST['idPet'],$p);
?>
	
</div>
<div class="sidebar">

<div class="campGeneral ultimelePetitii">
<?php include 'ultimelepetitii.php';?>
</div>
<div class="campGeneral ultimeleComentarii">
<?php include 'ultimeleComentarii.php'; ?>
</div>
</div>