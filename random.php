<?php 

		$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$sql = 'select * from petitii where idpetitie>(SELECT TRUNC(DBMS_RANDOM.VALUE (0, (select count(*) from petitii))) FROM DUAL)';
	$stid = oci_parse($conn, $sql);
	oci_execute($stid);
	oci_fetch($stid);
	$pag =  oci_result($stid,1);
	oci_free_statement($stid);
	oci_close($conn);
	echo '<meta http-equiv="refresh" content="0; url=/seePetitionInfo.php?idPet='.$pag.'" />';
	 ?>