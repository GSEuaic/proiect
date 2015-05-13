<?php

$c = oci_connect("system", "sys", "localhost/XE");

$myfile = fopen("initializare.sql", "r") or die("Unable to open file!");
$continut = fread($myfile,filesize("initializare.sql"));
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