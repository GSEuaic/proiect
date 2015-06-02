<?php 

$conn = oci_connect("george", "george", "localhost/XE");
if (!$conn) {
	$m = oci_error();
	trigger_error(htmlentities($m['message']), E_USER_ERROR);
}
if(isset($_COOKIE['logged'])){
$sql = 'BEGIN adaugaPetitie(:idInitiator, :nume, :destinatar, :descriere,:categorie); END;';

$stmt = oci_parse($conn,$sql);
$init = $_COOKIE['logged'];
oci_bind_by_name($stmt,':idInitiator',$init,-1);//get cont from cookie //default anonim
$desc = substr($_REQUEST['descriere'],0,990);
oci_bind_by_name($stmt,':nume',$_REQUEST['nume'],-1);
oci_bind_by_name($stmt,':destinatar',$_REQUEST['destinatar'],-1);
oci_bind_by_name($stmt,':descriere',$desc,-1);
oci_bind_by_name($stmt,':categorie',$_REQUEST['categorie'],-1);


oci_execute($stmt);


print "Petitia a fost adaugata"; 

oci_close($conn);
}
?>
<meta http-equiv="refresh" content="5; url=/" />
