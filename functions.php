<?php 
function getDescriere($idPet){
	
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$sql = 'select descriere from petitiiAprobate where idPetitie=:idp';

	$stmt = oci_parse($conn,$sql);
	oci_bind_by_name($stmt,':idp',$idPet,-1);

	oci_execute($stmt);
	oci_fetch_row($stmt);
	$rezultat = oci_result($stmt, 1);
	oci_close($conn);
	return $rezultat;
}

function getNume($idPet){
	
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$sql = 'select nume from petitiiAprobate where idPetitie=:idp';

	$stmt = oci_parse($conn,$sql);
	oci_bind_by_name($stmt,':idp',$idPet,-1);

	oci_execute($stmt);
	oci_fetch_row($stmt);	
	$rezultat = oci_result($stmt, 1);
	oci_close($conn);
	return $rezultat;
}

function getDestinatar($idPet){
	
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$sql = 'select destinatar from petitiiAprobate where idPetitie=:idp';

	$stmt = oci_parse($conn,$sql);
	oci_bind_by_name($stmt,':idp',$idPet,-1);

	oci_execute($stmt);
	oci_fetch_row($stmt);	
	$rezultat = oci_result($stmt, 1);
	oci_close($conn);
	return $rezultat;
}
function getTopPetitii(){
	echo "do it in oracle";
}
function getContentPaginaPetitie($id){
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}
	
	echo 'ddddddd';
	$sql = 'SELECT * FROM petitiiAprobate where idPetitie=:id';
	$stid = oci_parse($conn, $sql);
	oci_bind_by_name($stid, ':id', $id );
	oci_execute($stid);
	while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
		echo $row['NUME']. $row['DESCRIERE'];
	}
	echo 'ddddddd';

	oci_free_statement($stid);
	oci_close($conn);
} 
function searchPet($str)
{
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$cauta = $str;
	if($cauta){
		$sql = "select * from petitiiAprobate where nume like '%$cauta%'";
		$stmt = oci_parse($conn,$sql);
		oci_execute($stmt);
		$x=0;
		echo "<table border='1'>\n";
		while ($row = oci_fetch_array($stmt, OCI_ASSOC+OCI_RETURN_NULLS)) {
			$x=1;
			echo "<div>\n";
			echo '    <h2><a href="/seePetitionInfo.php?idPet='.oci_result($stmt,1).'">' . oci_result($stmt, 4) . "</a></h2>\n";
			echo "    <p>" . oci_result($stmt, 6) . "</p>\n";
			echo "</div>\n";
		}
		echo "</table>\n";
		if(!$x) 
			echo "<p>Nu a fost gasita o petitie cu \" $cauta \" in nume</p>";
	}
	else echo '*inserati termen in bara de cautare';

	oci_close($conn);
}
function getComentarii($id){
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
	oci_bind_by_name($stid, ':iddd', $id);
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

	}
	?>
