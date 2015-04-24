<?php
$c = oci_connect("system", "sys", "localhost/XE");
if (!$c) {
    $e = oci_error();
    echo $e;
}

$nume = $_REQUEST['nume'];
$email = $_REQUEST['email'];
$descriere = $_REQUEST['descriere'];
$destinatar = $_REQUEST['destinatar'];
$categorie = $_REQUEST['categorie'];

$insert = "insert into petitiiAprobate(idPetitie,voturi,idInitiator,nume,destinatar,descriere,categorie) 
values (100,0,101,'$nume','$destinatar','$descriere','categorie')";
$create = "
create table Conturi(
    idCont number(10) primary key,
    username  varchar2(100),
    password varchar2(100)
    )";
$create2 = "create table petitiiAprobate(
    idPetitie number(10) primary key,
    voturi number(10),
    idInitiator number(10) references Conturi(idCont),
    nume varchar2(22),
    destinatar varchar2(10),
    descriere varchar2(500),
    categorie varchar2(50   )
    )";
//$s = oci_parse($c, "insert into Conturi values(101,'dummy_user','dummy_pass')");
$s = oci_parse($c, $insert);

//$s = oci_parse($c, "drop table petitiiaprobate");
$r = oci_execute($s);
echo "done.";
?>