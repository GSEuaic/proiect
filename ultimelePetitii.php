<?php

echo '<p> <h2>Ultimele petitii:</h2></p>';

$conn = oci_connect("system", "sys", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}

$sql = 'select * from (SELECT * FROM petitiiAprobate order by dataPostare desc )where rownum<4';
$stid = oci_parse($conn, $sql);
# $didbv = 60;
# oci_bind_by_name($stid, ':didbv', $didbv);
oci_execute($stid);
while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
    echo '<div class="campSidebar ">
    <h2><a href="seePetitionInfo.php?idPet='.substr($row['IDPETITIE'],0,100).'">'.$row['NUME'] ."</a>
    <br>".substr($row['DESCRIERE'],0,100)."...</h2>
    </div>";
}

oci_free_statement($stid);
oci_close($conn);

?>