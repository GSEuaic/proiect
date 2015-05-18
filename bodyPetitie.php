<div class="content campGeneral camp">
	<p>
<?php

$conn = oci_connect("system", "sys", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}

$sql = 'BEGIN GetName(:idpet, :nume, :descriere); END;';

$stmt = oci_parse($conn,$sql);

//  Bind the input parameter
oci_bind_by_name($stmt,':idPet',$_REQUEST['idPet'],32);

// Bind the output parameter
oci_bind_by_name($stmt,':nume',$numePetitie,32);
oci_bind_by_name($stmt,':descriere',$descrierePetitie,32);
oci_execute($stmt);

// $message is now populated with the output value
print "Numele petitiei:<br> $numePetitie<br> Descrierea petitiei: <br> $descrierePetitie"; //numele petitiei

oci_close($conn);

?>

	</p>






	<p> <h2>Comentarii:</h2></p>
<?php
$conn = oci_connect("system", "sys", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}

$sql = 'SELECT c.IDCOMENTARIU,c.datapostarii,c.idcont,c.idpetitie,c.textComentariu,p.nume,j.username 
		FROM Comentarii c join petitiiAprobate p on c.idPetitie=p.idPetitie 
		join Conturi j on j.idCont=c.idCont 
		where c.idPetitie=:iddd';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':iddd', $_REQUEST['idPet']);
oci_execute($stid);
while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
    echo '<div class="campSidebar "><h2>'.$row['USERNAME'].'  a comentat: <br>'.substr($row['TEXTCOMENTARIU'],0,50).'...</h2>';
    //echo'la petitia: <a href="seePetitionInfo.php?idPet='.$row['IDPETITIE'].'">'.$row['NUME']."</a></h2>";
    echo '<br></div>';
}
oci_free_statement($stid);
oci_close($conn);

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