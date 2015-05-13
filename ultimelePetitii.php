<?php
$conn = oci_connect("system", "sys", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}

$sql = 'SELECT * FROM petitiiAprobate where rownum<4';
$stid = oci_parse($conn, $sql);
# $didbv = 60;
# oci_bind_by_name($stid, ':didbv', $didbv);
oci_execute($stid);
while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
    echo '<div class="campGeneral">
    <h2><a href="seePetitionInfo.php?idPet='.$row['IDPETITIE'].'">'.$row['NUME'] ."</a></h2>
    <br><h3>".$row['DESCRIERE']."</h3>
    </div>";
}

oci_free_statement($stid);
oci_close($conn);

?>