<div class="content campGeneral camp">
	<p>
		<a href="https://twitter.com/share" class="twitter-share-button">Tweet</a>
		<script>
		!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';
		if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}
	}(document, 'script', 'twitter-wjs');
	</script>
	<div
	class="fb-like"
	data-share="true"
	data-width="450"
	data-show-faces="true">
</div>
<?php
include "functions.php";
$numePetitie = getNume($_REQUEST['idPet']);
$descrierePetitie = getDescriere($_REQUEST['idPet']);
$modifica = '<a id="dreapta" href="http://localhost/modificaPetitie.php?idPet='.$_REQUEST['idPet'].'">Modifica</a>';
echo $modifica;
print "<h2>Numele petitiei:</h2>$numePetitie<br> <h2>Descrierea petitiei: </h2> $descrierePetitie"; //numele petitiei
?>
</p>
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