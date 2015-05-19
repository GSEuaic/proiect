<div class="content campGeneral camp">
	<?php 
	include "functions.php";
	$actual_link = "http://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
	if(strpos($actual_link,"seePetitionInfo")==false)
		{//mainpage
			echo"	<h2>Top Petitii dupa numarul de voturi</h2>";
			getTopPetitii();
		}
		else 
		{//content pagina petitie
			$conn = oci_connect("system", "sys", "localhost/XE");
			if (!$conn) {
				$m = oci_error();
				trigger_error(htmlentities($m['message']), E_USER_ERROR);
				}
			$sql = 'SELECT * FROM petitiiAprobate where idPetitie=:id';
			$stid = oci_parse($conn, $sql);
			oci_bind_by_name($stid, ':id', $_REQUEST['idPet'] );
			oci_execute($stid);
			while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
				    echo $row['NUME'].$row['DESCRIERE'];
				}

			oci_free_statement($stid);
			oci_close($conn);
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