<div class="content campGeneral camp">
	<?php 
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
		elseif(strpos($actual_link,"petitiileMele")){
			echo '<h2>Petitiile mele</h2>';
			getMyPetitions($_REQUEST['petitiileMele']);
		}
			else
		{//mainpage
			echo'<br><h2 style="text-align:right">Este nevoie de o singură persoană pentru a începe schimbarea.<br>Începe o petiție on-line și fa-ti mesajul auzit</h2><br>';
			
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