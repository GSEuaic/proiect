<?php 
$max = 30;
$conn = oci_connect("george", "george", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}


$stid = oci_parse($conn, 'SELECT count(*) FROM petitii');
oci_execute($stid);
oci_fetch_row($stid);
$cate = oci_result($stid, 1);
echo "<p>Sunt $cate petitii inregistrate</p>";

$stid = oci_parse($conn, 'SELECT * FROM petitii');
oci_execute($stid);
echo "<p><p>Petitii inregistrate : </p>";
echo "<table border='1'>\n";
echo "
<tr> 
<td>IdPetitie</td>
<td>Voturi</td>
<td>IdInitiator</td>
<td>Numele petitiei</td>
<td>Destinatar</td>
<td>Descriere</td>
<td>Categorie</td>
<td>Data postarii</td>
</tr>";
while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
    echo "<tr>\n";
    foreach ($row as $item) {
        echo "    <td>" . (substr($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;",0,$max)) . "</td>\n";
    }
    echo "</tr>\n";
}
echo "</table></p>";


$stid = oci_parse($conn, 'SELECT count(*),idPetitie FROM Comentarii group by idpetitie order by count(*) desc ');
oci_execute($stid);
oci_fetch_row($stid);
$cate = oci_result($stid, 1);
$care = oci_result($stid, 2);
$stid = oci_parse($conn, 'SELECT nume FROM petitii where idPetitie=:id ');
oci_bind_by_name($stid, ':id', $care);
oci_execute($stid);
oci_fetch_row($stid);
$care = oci_result($stid, 1);
echo "<p>Petitia cu cele mai multe comentarii( $cate ) este $care.</p>";


$stid = oci_parse($conn, 'SELECT count(*) FROM Comentarii');
oci_execute($stid);
oci_fetch_row($stid);
$cate = oci_result($stid, 1);
echo "<p>Sunt $cate comentarii postate.</p>";

/*
$stid = oci_parse($conn, 'SELECT * FROM Comentarii order by idPetitie');
oci_execute($stid);

echo "<p>Comentarii postate : </p>";
echo "<p><table border='1'>\n";
echo "
<tr> 
<td>IdComentariu</td>
<td>DataPostarii</td>
<td>IdCont</td>
<td>Id-ul petitiei</td>
<td>Comentariul</td>
</tr>";
while ($row = oci_fetch_array($stid, OCI_ASSOC+OCI_RETURN_NULLS)) {
    echo "<tr>\n";
    foreach ($row as $item) {
        echo "    <td>" . (substr($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;",0,$max)) . "</td>\n";
    }
    echo "</tr>\n";
}
echo "</table></p>";
*/

?>