<?php 
			$conn = oci_connect("system", "sys", "localhost/XE");
			if (!$conn) {
				$m = oci_error();
				trigger_error(htmlentities($m['message']), E_USER_ERROR);
				}

$stid = oci_parse($conn, 'SELECT * FROM petitiiAprobate');
oci_execute($stid);
echo "Petitii inregistrate : ";
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
        echo "    <td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
    }
    echo "</tr>\n";
}
echo "</table>\n";

$stid = oci_parse($conn, 'SELECT * FROM Comentarii order by idPetitie');
oci_execute($stid);
echo "Comentarii postate : <br>";
echo "<table border='1'>\n";
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
        echo "    <td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
    }
    echo "</tr>\n";
}
echo "</table>\n";


?>