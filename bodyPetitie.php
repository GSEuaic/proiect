<div class="content campGeneral camp">
	<p>

<?php
include "functions.php";
$numePetitie = getNume($_REQUEST['idPet']);
$descrierePetitie = getDescriere($_REQUEST['idPet']);	
$modifica = '<a class="buton" id="dreapta" href="http://localhost/modificaPetitie.php?idPet='.$_REQUEST['idPet'].'">Modifica</a>';
echo $modifica;
if(!isset($_COOKIE['nrCont'])) 
	$cont = 'XPSe7450';
else $cont = $_COOKIE['nrCont'];
$voteaza  = '<a class="buton" id="dreapta" href="http://localhost/voteazaPetitia.php?idPet='.$_REQUEST['idPet'].'&cont='.$cont.'">Voteaza petitia</a>';
echo $voteaza;
print "<h2>Numele petitiei:</h2>$numePetitie<br> <h2>Descrierea petitiei: </h2> $descrierePetitie"; 

?>
</p>
<?php include "media.php"; ?>
<p> <h2>Comentarii:</h2></p>
<?php
if(isset($_REQUEST['pagina']))
	$p = $_REQUEST['pagina'];
else $p=1;
getComentarii($_REQUEST['idPet'],$p);
?>
<form action='adaugaComentariu.php'>
	<input style="visibility:hidden" type="text" name="idPet" value=<?php echo $_REQUEST['idPet']; ?>   required/>
	<textarea class="campMare" type="text" name="comm" value="" size="40" placeholder="Introdu un comentariu"  required/></textarea>
	<input type="submit" value="Adauga"/>
</form>	
</div>
<div class="sidebar">

	<div class="campGeneral ultimelePetitii">
		<?php include 'ultimelepetitii.php';?>
	</div>
	<div class="campGeneral ultimeleComentarii">
		<?php include 'ultimeleComentarii.php'; ?>
	</div>
</div>