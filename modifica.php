<?php
include 'functions.php';

$conn = oci_connect("george", "george", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}
$descriere=substr($_REQUEST['descriere'],0,990);
$idPet=$_REQUEST['idulPet'];
$nume=$_REQUEST['nume'];
$cat=$_REQUEST['categorie'];
$dest=$_REQUEST['destinatar'];

$sql = 'update petitii 
		set descriere=:descr,
		nume=:nume,
		categorie=:categ,
		destinatar=:dest
		where idPetitie=:idp';
$stmt = oci_parse($conn,$sql);
oci_bind_by_name($stmt,':idp',$idPet,-1);
oci_bind_by_name($stmt,':descr',$descriere,-1);
oci_bind_by_name($stmt,':nume',$nume,-1);
oci_bind_by_name($stmt,':categ',$cat,-1);
oci_bind_by_name($stmt,':dest',$dest,-1);
oci_execute($stmt) or die("Eroare");
oci_close($conn); 
$loc = "Location: /seePetitionInfo.php?idPet=$idPet";
header( $loc ) ;
 ?>