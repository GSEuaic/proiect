<?php 
if(isset($_REQUEST['cauta'])){
	$conn = oci_connect("george", "george", "localhost/XE");
	if (!$conn) {
		$m = oci_error();
		trigger_error(htmlentities($m['message']), E_USER_ERROR);
	}

	$cauta = $_REQUEST['cauta'];

	$sql = "select * from petitiiAprobate where nume like '%$cauta%'";
	//echo $sql;
	$stmt = oci_parse($conn,$sql);
	oci_execute($stmt);
	$x=0;
	echo "<table border='1'>\n";
	while ($row = oci_fetch_array($stmt, OCI_ASSOC+OCI_RETURN_NULLS)) {
		$x=1;
		echo "<tr>\n";
		foreach ($row as $item) {
			echo "    <td>" . ($item !== null ? htmlentities($item, ENT_QUOTES) : "&nbsp;") . "</td>\n";
		}
		echo "</tr>\n";
	}
	echo "</table>\n";
	if(!$x) 
		echo "<p>Nu a fost gasita o petitie cu \" $cauta \" in nume</p>";


	oci_close($conn);
}
?>