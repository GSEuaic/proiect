<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title> Pet4Web Main Page</title>
	<link rel="stylesheet" type="text/css" href="style.css">

<?php
$conn = oci_connect("system", "sys", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}
$sql = 'SELECT * FROM petitiiAprobate where idPetitie=:id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':id', $_REQUEST['idPet'] );
oci_execute($stid);
while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
    echo $row['NUME'].$row['DESCRIERE'];
}

oci_free_statement($stid);
oci_close($conn);

?>
</html>