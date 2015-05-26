<p> <h2>Adauga comentarii:</h2></p>
<?php
$conn = oci_connect("george", "george", "localhost/XE");
if (!$conn) {
    $m = oci_error();
    trigger_error(htmlentities($m['message']), E_USER_ERROR);
}

$sql = ' select * from (SELECT c.IDCOMENTARIU,c.datapostarii,c.idcont,c.idpetitie,c.textComentariu,p.nume,j.username 
FROM Comentarii c join petitii p on c.idPetitie=p.idPetitie join Conturi j on j.idCont=c.idCont order by c.idcomentariu desc) where rownum<4';
$stid = oci_parse($conn, $sql);
oci_execute($stid);
while (($row = oci_fetch_array($stid, OCI_ASSOC)) != false) {
    echo '<div class="campSidebar "><h2>'.$row['USERNAME'].'  a comentat: <br>'.substr($row['TEXTCOMENTARIU'],0,70).'...</h2>';
    echo'la petitia: <a href="seePetitionInfo.php?idPet='.$row['IDPETITIE'].'">'.$row['NUME']."</a></h2>";
    echo '<br></div>';
}
oci_free_statement($stid);
oci_close($conn);

?>