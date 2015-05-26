<div class="content campGeneral camp">
	<?php 
	include "functions.php";
	$actual_link = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
	if(strpos($actual_link,"seePetitionInfo"))
		
		{//content pagina petitie
			getContentPaginaPetitie($_REQUEST['idPet']);
		}

		elseif (strpos($actual_link,"cauta")) {
			//do search stuff
			echo"	<h2>Rezulltatele cautarii</h2>";
			if(isset($_REQUEST['cauta']))
				searchPet($_REQUEST['cauta']);
		}
		else
		{//mainpage
			echo"	<h2>Top 5 Petitii</h2>";
			getTopPetitii();
		} 
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