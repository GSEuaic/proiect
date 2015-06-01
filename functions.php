<?php 
function getDescriere($idPet){
	
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$sql = 'select descriere from petitii where idPetitie=:idp';

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

	$sql = 'select nume from petitii where idPetitie=:idp';

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

	$sql = 'select destinatar from petitii where idPetitie=:idp';

	$stmt = oci_parse($conn,$sql);
	oci_bind_by_name($stmt,':idp',$idPet,-1);

	oci_execute($stmt);
	oci_fetch_row($stmt);	
	$rezultat = oci_result($stmt, 1);
	oci_close($conn);
	return $rezultat;
}

function getContentPaginaPetitie($id){
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}
	
	echo 'ddddddd';
	$sql = 'SELECT * FROM petitii where idPetitie=:id';
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
		$sql = "select * from petitii where nume like '%$cauta%'";
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
}	function incarca(){
		//include 'initializare.php';//sterge si reface structura tabelelor
	$conn = oci_connect("george", "george", "localhost/XE");
	$php = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$sql = 'begin csv_util.readcsv;end;';
	$stid = oci_parse($conn, $sql);
	oci_execute($stid);
	if(oci_error($stid)) echo 'error'.oci_error($stid); 
	else echo 'corect';
	oci_free_statement($stid);
	oci_close($conn);

}


function getComentarii($id,$p){
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$sql = 'select * from(
		select * from(
			SELECT c.IDCOMENTARIU,c.datapostarii,c.idcont,c.idpetitie,c.textComentariu,p.nume,j.username 
			FROM Comentarii c join petitii p on c.idPetitie=p.idPetitie 
			join Conturi j on j.idCont=c.idCont 
			where c.idPetitie=:iddd and 
			rownum<:panala)
order by IDCOMENTARIU desc)  
where rownum <=5 
order by idcomentariu ';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':iddd', $id);
$a=$p*5+1;
oci_bind_by_name($stid, ':panala', $a);
oci_execute($stid);
$done=0;
while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
	$done=1;	
	echo '<div class="campSidebar ">'.$row['USERNAME'].'  a comentat: <br>'.substr($row['TEXTCOMENTARIU'],0,50).'<br></div>';
}
if($done==0){
	echo "<p>Nu sunt comentarii</p>";}
	else{
		$sql = 'select count(*) from comentarii where idpetitie=:iddd';
		$stid = oci_parse($conn, $sql);
		oci_bind_by_name($stid, ':iddd', $id);
		oci_execute($stid);
		$row=oci_fetch_row($stid);
		$cate=oci_result($stid, 1);
		if($cate>5){

			$cate=round($cate/5);
			if(($p==1 or $p==$cate) )
				echo "<p class='nextPrev2'>";
			else 
				echo "<p class='nextPrev'>";
			if($p!=1) 
			{	
				echo '<a href="seePetitionInfo.php?idPet='.$id.'"> cele mai vechi </a>  ';
				echo '<a  href="seePetitionInfo.php?idPet='.$id.'&&pagina='.($p-1).'"> mai vechi </a>  ';
			}

			if($p!=$cate)
			{
				echo '<a  href="seePetitionInfo.php?idPet='.$id.'&&pagina='.($p+1).'"> mai noi </a> ';
				echo '<a  href="seePetitionInfo.php?idPet='.$id.'&&pagina='.$cate.'">cele mai noi </a>';
			}
			echo '</p>';
		}
	}

	oci_free_statement($stid);
	oci_close($conn);

}

function getTopPetitii(){
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$sql = ' select * from(select * from petitii order by voturi desc) where rownum<6';
	$stid = oci_parse($conn, $sql);
	oci_execute($stid);
	$ab=1;
	while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
		echo '<div class="campSidebarz "><h2>'.$ab.'.'.$row['NUME'].' cu  '.$row['VOTURI'].' voturi<br></h2>';
		$ab=$ab+1;
		echo '</div>';
	}
	oci_free_statement($stid);
	oci_close($conn);
}
function adaugaComentariu($cont,$id,$text){

	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$sql = 'insert into Comentarii(dataPostarii,idcont,idpetitie,textcomentariu) values(sysdate,:cont,:id,:text)';
	$stid = oci_parse($conn, $sql);
	oci_bind_by_name($stid, ':cont', $cont);
	oci_bind_by_name($stid, ':id', $id);
	oci_bind_by_name($stid, ':text', $text);
	oci_execute($stid);

	oci_free_statement($stid);
	oci_close($conn);

}

function startSesiune($user,$pass){

	setcookie('user', $cookie_value, time() + (86400 * 30), "/"); // 86400 = 1 day
}

?>