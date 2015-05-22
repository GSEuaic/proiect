<?php 
$conn = oci_connect("george", "george", "localhost/XE");
if (!$conn) {
   $m = oci_error();
   trigger_error(htmlentities($m['message']), E_USER_ERROR);
}


$stid = oci_parse($conn, 'begin makecsv; end;');
oci_execute($stid);
echo "<p><a href=\"/backup.csv\"> Raport format csv</a></p>";


?>