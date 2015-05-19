<?php 
if(!isset($_REQUEST['loginUser']) || !isset($_REQUEST['loginPass']) )
	echo "Nu ati introdus parola sau Usenameul.";
else {//check for password
	$conn = oci_connect("system", "sys", "localhost/XE");
			if (!$conn) {
				$m = oci_error();
				trigger_error(htmlentities($m['message']), E_USER_ERROR);
				}
	$stid = oci_parse($conn, 'select \'Y\' from dual where exists(select idcont from conturi where username=:user and password = :pass) ');

	oci_bind_by_name($stid, ':user', $_REQUEST['loginUser']);
	oci_bind_by_name($stid, ':pass', $_REQUEST['loginPass']);
	oci_execute($stid);
	oci_fetch_row($stid);
	$cate = oci_result($stid, 1);
	echo $cate;

} 
 ?>