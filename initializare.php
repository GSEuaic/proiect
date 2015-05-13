<?php

$c = oci_connect("system", "sys", "localhost/XE");

$sqlName="initializare.sql";


$myfile = fopen($sqlName, "r") or die("Unable to open file!");
$continut = fread($myfile,filesize($sqlName));
$instructiuni = explode("/", $continut);
foreach ($instructiuni as $instructiune) {
	echo $instructiune;
	
	# code...
	$s = oci_parse($c, $instructiune);
	$r = oci_execute($s);
	echo "<br><br>";
}



fclose($myfile);

?>