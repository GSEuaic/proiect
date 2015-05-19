<?php 
function getDescriere($idPet){
	
$conn = oci_connect("system", "sys", "localhost/XE");
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
	
$conn = oci_connect("system", "sys", "localhost/XE");
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
	
$conn = oci_connect("system", "sys", "localhost/XE");
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
 ?>