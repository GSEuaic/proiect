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

$sql = 'SELECT c.IDCOMENTARIU,c.datapostarii,c.idcont,c.idpetitie,c.textComentariu,p.nume FROM Comentarii c join petitiiAprobate p on c.idPetitie=p.idPetitie where rownum<4';
$stid = oci_parse($conn, $sql);
# $didbv = 60;
# oci_bind_by_name($stid, ':didbv', $didbv);
oci_execute($stid);
while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
    echo '<div class="campGeneral">
    <h2><a href="seePetitionInfo.php?idPet='.$row['IDCOMENTARIU'].'">'.$row['NUME'] ."</a></h2>
    <br><h3>".$row['TEXTCOMENTARIU']."</h3>
    </div>";
}
oci_free_statement($stid);
oci_close($conn);

?>
</html>