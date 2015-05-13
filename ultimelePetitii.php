<?php

$c = oci_connect("system", "sys", "localhost/XE");
echo "fuck";
$s = oci_parse($c, "select * from conturi");
$r = oci_execute($s);

echo "<table border='1'>\n";
$ncols = oci_num_fields($s);
echo "<tr>";
for ($i = 1; $i <= $ncols; ++$i) {
	$colname = oci_field_name($s, $i);
	echo "  <th><b>".htmlentities($colname, ENT_QUOTES)."</b></th>\n";
}
echo "</tr>\n";

while (($row = oci_fetch_array($s, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
	echo "<tr>\n";
	foreach ($row as $item) {
		echo "  <td>".($item!==null?htmlentities($item, ENT_QUOTES):"&nbsp;")."</td>\n";
	}
	echo "</tr>\n";
}
echo "</table>\n";

?>