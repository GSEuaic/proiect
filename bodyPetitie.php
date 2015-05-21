<div class="content campGeneral camp">
	<p>
<?php
include "functions.php";
$numePetitie = getNume($_REQUEST['idPet']);
$descrierePetitie = getDescriere($_REQUEST['idPet']);
print "<h2>Numele petitiei:</h2><br> $numePetitie<br> <h2>Descrierea petitiei: </h2><br> $descrierePetitie"; //numele petitiei
?>

	</p>
	<p> <h2>Comentarii:</h2></p>
<?php
$conn = oci_connect("george", "george", "localhost/XE");
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
$done=0;
while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
    $done=1;
    echo '<div class="campSidebar "><h2>'.$row['USERNAME'].'  a comentat: <br>'.substr($row['TEXTCOMENTARIU'],0,50).'...</h2>';
    //echo'la petitia: <a href="seePetitionInfo.php?idPet='.$row['IDPETITIE'].'">'.$row['NUME']."</a></h2>";
    echo '<br></div>';
}
if(!$done){
	echo "<p>Nu sunt comentarii</p>";}
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