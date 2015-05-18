<?php 

$conn = oci_connect("system", "sys", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}

$sql = 'BEGIN adaugaPetitie(:idInitiator, :nume, :destinatar, :descriere,:categorie); END;';

$stmt = oci_parse($conn,$sql);
$init = 100;
oci_bind_by_name($stmt,':idInitiator',$init,-1);//get cont from cookie //default anonim
oci_bind_by_name($stmt,':nume',$_REQUEST['nume'],-1);
oci_bind_by_name($stmt,':destinatar',$_REQUEST['destinatar'],-1);
oci_bind_by_name($stmt,':descriere',$_REQUEST['descriere'],-1);
oci_bind_by_name($stmt,':categorie',$_REQUEST['categorie'],-1);


oci_execute($stmt);


print "Petitia a fost adaugata"; 

oci_close($conn);

 ?>