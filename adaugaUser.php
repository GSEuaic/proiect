<?php
$conn = oci_connect("george", "george", "localhost/XE");
if (!$conn) {
	$m = oci_error();
	trigger_error(htmlentities($m['message']), E_USER_ERROR);
}

$sql = 'insert into conturi(username,pass) values(:username,:passwrd)';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':username', $_REQUEST['usern'] );
$pas = md5($_REQUEST['pass']);
oci_bind_by_name($stid, ':passwrd', $pas );
oci_execute($stid);

oci_free_statement($stid);
oci_close($conn);
if(!oci_error())
	echo "Utilizator inregistrat";
?>
<meta http-equiv="refresh" content="5; url=/" />';
