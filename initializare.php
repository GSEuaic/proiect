<?php

$c = oci_connect("george", "george", "localhost/XE");

$sqlName="initializare.sql";


$myfile = fopen($sqlName, "r") or die("Unable to open file!");
$continut = fread($myfile,filesize($sqlName));
$instructiuni = explode("/", $continut);
foreach ($instructiuni as $instructiune) {
	echo $instructiune;
		//$instructiune = str_replace(chr(13),'',$instructiune);
		//$instructiune = str_replace(chr(10),'',$instructiune);
	//echo "<br>".$instructiune;
	$s = oci_parse($c, $instructiune);
	$r = oci_execute($s);
	echo "<br><br>";
}



fclose($myfile);

?>