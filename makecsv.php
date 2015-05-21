<?php 
$conn = oci_connect("george", "george", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}

$sql = 'begin
		CSV_UTIL.makeCSV;
		end;';

$stmt = oci_parse($conn,$sql);
oci_execute($stmt) or die("Eroare");
oci_close($conn); 
 ?>